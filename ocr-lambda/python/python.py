# import boto3
# import os
# import json
# from urllib.parse import unquote_plus

# s3 = boto3.client('s3')
# dynamodb = boto3.resource('dynamodb')

# BUCKET_NAME = 'mini-project234'
# DDB_TABLE_NAME = 'request'
# table = dynamodb.Table(DDB_TABLE_NAME)

# def lambda_handler(event, context):
#     print("EVENT:")
#     print(json.dumps(event, indent=2))

#     for record in event.get('Records', []):
#         try:
#             key = unquote_plus(record['s3']['object']['key'])
#             print(f"Raw S3 key: {key}")
#             image_id = key.split("/")[-1].split(".")[0]
#             print(f"Extracted image ID: {image_id}")
#         except Exception as e:
#             print(f"Error extracting image ID: {str(e)}")



import boto3
import os
from urllib.parse import unquote_plus
from datetime import datetime, timezone


s3 = boto3.client('s3')
dynamodb = boto3.resource('dynamodb')

BUCKET_NAME = 'mini-project234'
DDB_TABLE_NAME = 'bild-test'


table = dynamodb.Table(DDB_TABLE_NAME)

def lambda_handler(event, context):
    for record in event['Records']:
        # Extract the S3 object key (filename)
        key = unquote_plus(record['s3']['object']['key'])  # e.g., "uploads/image123.jpg"
        image_id = key.split("/")[-1].split(".")[0]       # e.g., "image123"
        timestamp = datetime.now(timezone.utc).isoformat()

        try:
            table.put_item(
                Item={
                    "ImageID": image_id,
                    "Status": "Uploaded",
                    "Timestamp": timestamp
                }
            )
            print(f"Stored metadata for image: {image_id}")
        
        except Exception as e:
            print(f"Error processing {key}: {e}")
            raise
        
