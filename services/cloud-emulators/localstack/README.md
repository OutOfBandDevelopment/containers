# LocalStack

Fully functional local AWS cloud stack for developing and testing cloud applications offline.

## Overview

LocalStack provides an easy-to-use test/mock framework for developing Cloud applications. It spins up a testing environment on your local machine that provides the same functionality as AWS cloud services.

## Features

- 80+ AWS services emulated
- S3, DynamoDB, Lambda, SQS, SNS, and more
- CloudFormation support
- Terraform compatible
- AWS CLI compatible
- Multiple SDKs supported
- Persistent storage
- Real cloud behavior simulation

## Supported Services

**Core Services (always available):**
- S3 (Object Storage)
- DynamoDB (NoSQL Database)
- SQS (Message Queue)
- SNS (Notification Service)
- Lambda (Serverless Functions)
- CloudFormation (Infrastructure as Code)
- CloudWatch (Monitoring)
- API Gateway (API Management)
- And 70+ more...

## Quick Start

**Linux/macOS:**
```bash
# Copy environment template
cp .env.template .env

# Edit services to enable
nano .env

# Start service
./start.sh

# Stop service
./stop.sh
```

**Windows:**
```cmd
# Copy environment template
copy .env.template .env

# Edit services to enable
notepad .env

# Start service
start.bat

# Stop service
stop.bat
```

## Configuration

Edit `.env` file to customize:

| Variable | Default | Description |
|:---------|:--------|:------------|
| LOCALSTACK_VERSION | latest | LocalStack image version |
| LOCALSTACK_EDGE_PORT | 4566 | Main API endpoint port |
| LOCALSTACK_PORT_RANGE | 4510-4559 | Additional service ports |
| LOCALSTACK_SERVICES | s3,dynamodb,sqs,sns,lambda | Services to enable |
| LOCALSTACK_DEBUG | 0 | Debug logging (0 or 1) |

## Accessing the Service

After starting:

- **API Endpoint**: http://localhost:4566
- **Health Check**: http://localhost:4566/_localstack/health

All AWS services are accessible through the single edge port (4566).

## AWS CLI Configuration

Configure AWS CLI to use LocalStack:

```bash
aws configure --profile localstack
  AWS Access Key ID: test
  AWS Secret Access Key: test
  Default region name: us-east-1
  Default output format: json
```

**Using with commands:**
```bash
aws --endpoint-url=http://localhost:4566 --profile localstack s3 ls
```

**Environment variables:**
```bash
export AWS_ENDPOINT_URL=http://localhost:4566
export AWS_ACCESS_KEY_ID=test
export AWS_SECRET_ACCESS_KEY=test
export AWS_DEFAULT_REGION=us-east-1
```

## S3 Examples

**Create bucket:**
```bash
aws --endpoint-url=http://localhost:4566 s3 mb s3://my-bucket
```

**Upload file:**
```bash
aws --endpoint-url=http://localhost:4566 s3 cp file.txt s3://my-bucket/
```

**List objects:**
```bash
aws --endpoint-url=http://localhost:4566 s3 ls s3://my-bucket/
```

## DynamoDB Examples

**Create table:**
```bash
aws --endpoint-url=http://localhost:4566 dynamodb create-table \
  --table-name MyTable \
  --attribute-definitions AttributeName=id,AttributeType=S \
  --key-schema AttributeName=id,KeyType=HASH \
  --billing-mode PAY_PER_REQUEST
```

**Put item:**
```bash
aws --endpoint-url=http://localhost:4566 dynamodb put-item \
  --table-name MyTable \
  --item '{"id": {"S": "123"}, "name": {"S": "Test"}}'
```

## Python Example (boto3)

```python
import boto3

# Configure boto3 for LocalStack
s3 = boto3.client(
    's3',
    endpoint_url='http://localhost:4566',
    aws_access_key_id='test',
    aws_secret_access_key='test',
    region_name='us-east-1'
)

# Create bucket
s3.create_bucket(Bucket='my-bucket')

# Upload file
s3.put_object(
    Bucket='my-bucket',
    Key='file.txt',
    Body=b'Hello, LocalStack!'
)

# Download file
response = s3.get_object(Bucket='my-bucket', Key='file.txt')
print(response['Body'].read())

# DynamoDB example
dynamodb = boto3.client(
    'dynamodb',
    endpoint_url='http://localhost:4566',
    aws_access_key_id='test',
    aws_secret_access_key='test',
    region_name='us-east-1'
)

# Create table
dynamodb.create_table(
    TableName='MyTable',
    KeySchema=[{'AttributeName': 'id', 'KeyType': 'HASH'}],
    AttributeDefinitions=[{'AttributeName': 'id', 'AttributeType': 'S'}],
    BillingMode='PAY_PER_REQUEST'
)
```

## Node.js Example (aws-sdk)

```javascript
const AWS = require('aws-sdk');

// Configure AWS SDK for LocalStack
const config = {
    endpoint: 'http://localhost:4566',
    accessKeyId: 'test',
    secretAccessKey: 'test',
    region: 'us-east-1',
    s3ForcePathStyle: true
};

const s3 = new AWS.S3(config);

// Create bucket
s3.createBucket({ Bucket: 'my-bucket' }, (err, data) => {
    if (err) console.log(err);
    else console.log('Bucket created');
});

// Upload file
s3.putObject({
    Bucket: 'my-bucket',
    Key: 'file.txt',
    Body: 'Hello, LocalStack!'
}, (err, data) => {
    if (err) console.log(err);
    else console.log('File uploaded');
});
```

## .NET Example (AWSSDK)

```csharp
using Amazon.S3;
using Amazon.S3.Model;
using Amazon.Runtime;

var credentials = new BasicAWSCredentials("test", "test");
var config = new AmazonS3Config
{
    ServiceURL = "http://localhost:4566",
    ForcePathStyle = true
};

using (var client = new AmazonS3Client(credentials, config))
{
    // Create bucket
    await client.PutBucketAsync("my-bucket");

    // Upload file
    await client.PutObjectAsync(new PutObjectRequest
    {
        BucketName = "my-bucket",
        Key = "file.txt",
        ContentBody = "Hello, LocalStack!"
    });

    // Download file
    var response = await client.GetObjectAsync("my-bucket", "file.txt");
    using (var reader = new StreamReader(response.ResponseStream))
    {
        var content = await reader.ReadToEndAsync();
        Console.WriteLine(content);
    }
}
```

## Lambda Functions

**Create Lambda function:**
```bash
zip function.zip index.js

aws --endpoint-url=http://localhost:4566 lambda create-function \
  --function-name my-function \
  --runtime nodejs18.x \
  --role arn:aws:iam::000000000000:role/lambda-role \
  --handler index.handler \
  --zip-file fileb://function.zip
```

**Invoke Lambda:**
```bash
aws --endpoint-url=http://localhost:4566 lambda invoke \
  --function-name my-function \
  --payload '{"key": "value"}' \
  output.txt
```

## Terraform Integration

```hcl
provider "aws" {
  access_key                  = "test"
  secret_key                  = "test"
  region                      = "us-east-1"
  s3_use_path_style          = true
  skip_credentials_validation = true
  skip_metadata_api_check     = true
  skip_requesting_account_id  = true

  endpoints {
    s3       = "http://localhost:4566"
    dynamodb = "http://localhost:4566"
    lambda   = "http://localhost:4566"
  }
}

resource "aws_s3_bucket" "test_bucket" {
  bucket = "my-test-bucket"
}
```

## Checking Service Health

```bash
curl http://localhost:4566/_localstack/health | jq
```

Shows status of all running services.

## Persistent Volumes

This service uses one persistent volume:

- **localstack-data**: Service data and state (`/tmp/localstack`)

Data persists across container restarts.

## Use in Compositions

To use this service in a higher-level composition:

```yaml
services:
  localstack:
    extends:
      file: ../../services/cloud-emulators/localstack/docker-compose.yml
      service: localstack
```

## Pro Version

LocalStack offers a Pro version with:
- Additional AWS services
- Advanced features
- Cloud Pods (state snapshots)
- CI/CD integrations
- Support

See https://localstack.cloud/pricing

## Documentation

- Official Website: https://localstack.cloud/
- Documentation: https://docs.localstack.cloud/
- GitHub: https://github.com/localstack/localstack
- AWS Service Coverage: https://docs.localstack.cloud/references/coverage/

## Source Tracking

**Migrated from:** AnotherOneBytesTheDust/ContainerStore
**Source commit:** `fe623ee56a7289bbb1602c9f9cadf6c214496612`
**Source date:** 2025-09-16
**Source file:** `docker-compose.localstack.yml`

---

**Service Type:** Cloud Emulator (AWS Services)
**Category:** Development Tools
**Deployment:** Standalone container with persistence
