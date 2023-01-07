output "id" {
    description = "ID of Rest API Gateway."
    value       = var.create_api ? module.rest_api[0].id : null
}

output "arn" {
    description = "ARN of Rest API Gateway."
    value       = var.create_api ? module.rest_api[0].arn : null
}

output "execution_arn" {
    description = "Execution ARN part to be used in lambda_permission's source_arn when allowing API Gateway to invoke a Lambda function."
    value       = var.create_api ? module.rest_api[0].execution_arn : null
}

output "root_resource_id" {
    description = "Resource ID of the REST API's root."
    value       = var.create_api ? module.rest_api[0].root_resource_id : null
}

output "resource_id" {
    description = "Resource's identifier."
    value       = var.create_resource ? module.api_resource[0].id : null
}

output "resource_path" {
    description = "Complete path for the API resource, including all parent paths."
    value       = var.create_resource ? module.api_resource[0].path : null
}

output "api_keys" {
    description = "The API key details."
    value       = mmodule.api_security.api_keys
}

output "stage_id" {
    description = "ID of the Stage."
    value       = var.create_deployment ? module.api_deployment[0].stage_id : null
}

output "stage_arn" {
    description = "ARN of the Stage."
    value       = var.create_deployment ? module.api_deployment[0].stage_arn : null
}

output "invoke_url" {
    description = "URL to invoke the API pointing to the stage."
    value       = var.create_deployment ? module.api_deployment[0].invoke_url : null
}

output "execution_arn" {
    description = "Execution ARN to be used in lambda_permission's source_arn when allowing API Gateway to invoke a Lambda function."
    value       = var.create_deployment ? module.api_deployment[0].execution_arn : null
}