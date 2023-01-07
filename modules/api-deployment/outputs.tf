output "stage_id" {
    description = "ID of the Stage."
    value       = aws_api_gateway_stage.this.id
}

output "stage_arn" {
    description = "ARN of the Stage."
    value       = aws_api_gateway_stage.this.arn
}

output "invoke_url" {
    description = "URL to invoke the API pointing to the stage."
    value       = aws_api_gateway_stage.this.invoke_url
}

output "execution_arn" {
    description = "Execution ARN to be used in lambda_permission's source_arn when allowing API Gateway to invoke a Lambda function."
    value       = aws_api_gateway_stage.this.execution_arn
}