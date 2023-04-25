
#Output the Lambdas arns by the input name
output "arns" {
    value = {
        for x, y in var.tasks : x => "${aws_lambda_function.main[x].invoke_arn}"
        }
}

output "lambda_names" {
  value = {
        for x, y in var.tasks : x => "${aws_lambda_function.main[x].function_name}"
        }
}