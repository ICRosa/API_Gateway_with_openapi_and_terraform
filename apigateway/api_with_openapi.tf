data "template_file" "openapi" {
  template = file("${path.module}/openapi.yaml")

  vars = {
  lambda_addtask_invokearn    = var.lambda_addtask_invokearn
  lambda_listtask_invokearn   = var.lambda_listtask_invokearn
  lambda_gettask_invokearn    = var.lambda_gettask_invokearn
  lambda_edittask_invokearn   = var.lambda_edittask_invokearn
  lambda_deletetask_invokearn = var.lambda_deletetask_invokearn
  }
}

resource "aws_api_gateway_rest_api" "api" {
    name        = "To Do API"
    description = "To do tasks API"
    body = data.template_file.openapi.rendered
    put_rest_api_mode = "merge"

    endpoint_configuration {
        types = ["REGIONAL"]
    }

    fail_on_warnings = true
}

resource "aws_api_gateway_deployment" "deployment" {
  rest_api_id = aws_api_gateway_rest_api.api.id  
}

resource "aws_api_gateway_stage" "main" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  deployment_id = aws_api_gateway_deployment.deployment.id

  stage_name  = "dev"

 }



resource "aws_lambda_permission" "permit" {

  for_each = var.lambda_names

  statement_id  = "AllowAPIGatewayToInvokeFunction"
  action        = "lambda:InvokeFunction"
  function_name = each.value
  principal     = "apigateway.amazonaws.com"

  source_arn    = "${aws_api_gateway_rest_api.api.execution_arn}/*/*"
}