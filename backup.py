import os
import shutil
import tarfile
import tempfile
from datetime import datetime

import boto3

# First, create a temporary directory to work in.
work_dir = tempfile.mkdtemp()

# Next, copy the `/data` directory to the temporary directory.
shutil.copytree("/data", work_dir + "/data")

# Tar and gzip the copied directory. Name it with the current date and time.
backup_name = f"backup-{datetime.now().strftime('%Y-%m-%d_%H:%M:%S')}.tar.gz"
tar_path = os.path.join(work_dir, backup_name)

with tarfile.open(tar_path, "w:gz") as tar:
    tar.add(work_dir + "/data", arcname="data")

"""
s3 = boto3.client(
    "s3",
    endpoint_url="https://6a2000084da13cb43551f4059422f650.r2.cloudflarestorage.com",
    aws_access_key_id="238e0cc781eea4b4c567ed25d4baf6e8",
    aws_secret_access_key="1c1c47c04412239d60c7f973d207faafc1b015b52adf4e65152f0547806056fb",
)
"""

s3 = boto3.client(
    "s3",
    endpoint_url=os.environ.get("S3_ENDPOINT"),
    aws_access_key_id=os.environ.get("S3_ACCESS_KEY"),
    aws_secret_access_key=os.environ.get("S3_SECRET_KEY"),
)

bucket_name = os.environ.get("S3_BUCKET_NAME")

# Upload/Update single file
s3.upload_file(tar_path, bucket_name, backup_name)

# Get the list of all backups, sorted by last-modofied
sorted_s3_objects = sorted(
    s3.list_objects(Bucket=bucket_name)["Contents"],
    key=lambda x: x["LastModified"],
)


# If there are more than $NUM_BACKUPS backups, delete the oldest total - $NUM_BACKUPS amount.
num_backups = int(os.environ.get("NUM_BACKUPS", 3))

if len(sorted_s3_objects) > num_backups:
    for i in range(len(sorted_s3_objects) - num_backups):
        s3.delete_object(Bucket=bucket_name, Key=sorted_s3_objects[i]["Key"])


# Delete the temporary directory, and we're done!
shutil.rmtree(work_dir)
