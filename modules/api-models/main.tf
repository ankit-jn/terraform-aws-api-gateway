resource aws_api_gateway_model "this" {
    rest_api_id  = var.rest_api_id
    name         = var.name
    description  = coalesce(var.description, var.name)
    
    content_type = var.content_type
    schema = var.schema
}