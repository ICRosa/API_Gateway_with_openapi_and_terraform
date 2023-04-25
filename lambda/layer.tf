#bucket 
resource "aws_s3_bucket" "layer_buck" {
  bucket = "api-layer-bucket"
}


# Zip the "python\\" in the dir with layer name
data "archive_file" "zip_layer" { 

  type = "zip"  
  source_dir = "${path.module}\\SQLalchemy_AWSPsycopg2\\" 
  excludes = fileset("${path.module}\\SQLalchemy_AWSPsycopg2", "*.*")
  output_path = "${path.module}\\SQLalchemy_AWSPsycopg2\\SQLalchemy_AWSPsycopg2.zip"
}

# Uploads the ziped layer to the S3 
resource "aws_s3_object" "upload_layer" {

  key                    = "SQLalchemy_AWSPsycopg2.zip"
  bucket                 = "api-layer-bucket"
  source                 = "${path.module}\\SQLalchemy_AWSPsycopg2\\SQLalchemy_AWSPsycopg2.zip"

  depends_on = [
    data.archive_file.zip_layer,
    resource.aws_s3_bucket.layer_buck
  ]
}

# Ceates the layer in python3.9 runtime 
resource "aws_lambda_layer_version" "lambda_layer" {

  s3_bucket     = "api-layer-bucket"
  s3_key        = "SQLalchemy_AWSPsycopg2.zip"
  layer_name    = "SQLalchemy_AWSPsycopg2"

  compatible_runtimes = ["python3.9"]
  depends_on = [
    aws_s3_object.upload_layer
  ]
}

///

#Layer arn
output "layer_arn" {
  value = aws_lambda_layer_version.lambda_layer.arn

}