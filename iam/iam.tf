resource "aws_iam_role" "lambda" {
  name = "api_lambdas"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Service = [
          "lambda.amazonaws.com",
          "apigateway.amazonaws.com",

        ]
      }
      Action = "sts:AssumeRole"
    }]
  })

  inline_policy { 
    
    name = "All-rds"

    policy = jsonencode({
      "Version": "2012-10-17",
      "Statement": [
      {
        "Sid": "RDSAccess",
        "Effect": "Allow",
        "Action": [
            "rds-data:ExecuteSql",
            "rds-data:BatchExecuteStatement",
            "rds-data:BeginTransaction",
            "rds-data:CommitTransaction",
            "rds-data:RollbackTransaction",
            "rds-data:ExecuteStatement"
        ],
        "Resource": [
            "arn:aws:rds:*:*:db:*",

        ]
      },
      {
        "Effect": "Allow",
        "Action": [
            "logs:CreateLogGroup",
            "logs:CreateLogStream",
            "logs:PutLogEvents"
        ],
        "Resource": "arn:aws:logs:*:*:*"
      }
      ]
    })
  }
}