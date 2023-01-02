resource aws_api_gateway_rest_api "this" {
    name = var.name
    description = coalesce(var.description, format("API Gateway - %s", var.name))

    api_key_source = var.api_key_source
    
    binary_media_types = var.binary_media_types
    minimum_compression_size = var.minimum_compression_size
    
    disable_execute_api_endpoint = var.disable_execute_api_endpoint

    endpoint_configuration {
        types = [var.endpoint_type]
        vpc_endpoint_ids = var.endpoint_type == "PRIVATE" ? var.vpc_endpoint_ids : null
    }
    
    tags = var.tags
}