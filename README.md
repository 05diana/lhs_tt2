# technical_test_2
## Configure backed s3 for terraform

You must create an S3 bucket and a table in dynamoDB

```
$ aws s3api create-bucket --region us-east-1 --bucket terraform-lwwjdattfsri2egsjecb2sdpufiusipyg15edkeoa4oe
$ aws s3api put-bucket-encryption --server-side-encryption-configuration '{"Rules": [{"ApplyServerSideEncryptionByDefault": {"SSEAlgorithm": "AES256"}}]}' --bucket terraform-lwwjdattfsri2egsjecb2sdpufiusipyg15edkeoa4oe
$ aws dynamodb create-table --table-name tfstate-locking --attribute-definitions AttributeName=LockID,AttributeType=S --key-schema AttributeName=LockID,KeyType=HASH --provisioned-throughput ReadCapacityUnits=5,WriteCapacityUnits=5
```
