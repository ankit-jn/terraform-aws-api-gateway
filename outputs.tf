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