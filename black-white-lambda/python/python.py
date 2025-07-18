import json
import boto3
from PIL import Image
from io import BytesIO
from urllib.parse import unquote_plus
import os

s3_client = boto3.client('s3')

# Destination bucket name set as an environment variable in Terraform
DEST_BUCKET = os.environ.get('DEST_BUCKET')  # e.g., 'mini-project234-processed'

def lambda_handler(event, context):
    for record in event['Records']:
        source_bucket = record['s3']['bucket']['name']  # get source bucket and object key
        object_key = unquote_plus(record['s3']['object']['key'])

        if object_key.startswith("bw_"):  # to gnore already processed files
            print(f"Skipping already processed image: {object_key}")
            continue

        try:
            response = s3_client.get_object(Bucket=source_bucket, Key=object_key) # get image from S3
            image_data = response['Body'].read()
            image = Image.open(BytesIO(image_data)).convert("L") # Open image with Pillow and convert to black_white

            buffer = BytesIO()
            image.save(buffer, format='JPEG')
            buffer.seek(0)

            new_key = f"uploads/bw_{object_key.split('/')[-1]}"  # Upload to destination bucket with new key
            s3_client.put_object(Bucket=DEST_BUCKET, Key=new_key, Body=buffer, ContentType='image/jpeg')

            print(f"Processed and uploaded: {new_key} to {DEST_BUCKET}")

        except Exception as e:
            print(f"Error processing file {object_key} from bucket {source_bucket}: {str(e)}")
            raise

    return {
        'statusCode': 200,
        'body': json.dumps('Black and white conversion complete.')
    }
