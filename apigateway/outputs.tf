# API endpoint
output "main_url" {

  value = aws_api_gateway_deployment.deployment.invoke_url

}
