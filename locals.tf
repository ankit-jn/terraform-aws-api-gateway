locals {

    rest_api_id = var.create_api ? module.rest_api[0].id : data.aws_api_gateway_rest_api.this[0].id
    root_resource_id = var.create_api ? module.rest_api[0].root_resource_id : data.aws_api_gateway_rest_api.this[0].root_resource_id
    resource_id = var.create_resource ? module.api_resource[0].id : var.resource_id
}