data "archive_file" "code" {
  type        = "zip"
  source_dir = "${path.module}\\upload-lambda"
  output_path = "${path.module}\\upload-lambda\\tasks_orm.zip"
}

resource "aws_lambda_function" "main" {
  for_each = var.tasks
    function_name     = "ToDo_${each.key}"
    role              = var.iam_role_arn
    runtime           = "python3.9"
    filename          = data.archive_file.code.output_path
    timeout           = try(each.value["timeout"], 15)
    memory_size       = try(each.value["memory_size"], 128)
    handler           = "tasks_orm.${each.key}"
    source_code_hash  = data.archive_file.code.output_base64sha256
    layers            = [aws_lambda_layer_version.lambda_layer.arn]
    environment {
      variables = {
        PG_DSN = "postgresql://${var.pg_user}:${var.pg_pass}@${var.pg_host}/${var.pg_dbname}"
      }
    }
    depends_on = [
      aws_lambda_layer_version.lambda_layer
    ]
}


# Invokes a lambda to create the table
resource "aws_lambda_invocation" "create_table_invocation" {

  function_name = aws_lambda_function.main["create_table"].function_name

  input = jsonencode({
    k = "1"
  })
}


resource "aws_cloudwatch_log_group" "example" {

  for_each = var.tasks

  name              = "/aws/lambda/${each.key}"
  retention_in_days = 5
}

