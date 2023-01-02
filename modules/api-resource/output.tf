output "id" {
    description = "Resource's identifier."
    value       = var.create_resource ? aws_api_gateway_resource.this[0].id : null
}

output "path" {
    description = "Complete path for the API resource, including all parent paths."
    value       = var.create_resource ? aws_api_gateway_resource.this[0].path : null
}