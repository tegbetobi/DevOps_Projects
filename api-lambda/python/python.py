import json
import boto3
import botocore
import os
import uuid
from botocore.config import Config


s3 = boto3.client('s3')
BUCKET_NAME = 'mini-project234'

def lambda_handler(event, context):
    image_id = str(uuid.uuid4())
    object_key = f"uploads/{image_id}.jpg"

    presigned_url = s3.generate_presigned_url(
        'put_object',
        Params={
            'Bucket': BUCKET_NAME,
            'Key': object_key,
            'ContentType': 'image/jpg'
        },
        ExpiresIn=200  
    )

    return {
        'statusCode': 200,
        'body': f'{{"url": "{presigned_url}", "imageId": "{image_id}"}}'
    }

