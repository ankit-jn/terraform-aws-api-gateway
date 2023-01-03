module "rest_api" {
    source = "./modules/rest-api"

    count = var.create_api ? 1 : 0

    name = var.name
    description =  coalesce(var.description, format("API Gateway - %s", var.name))
    api_key_source = var.api_key_source
    binary_media_types = var.binary_media_types
    minimum_compression_size = var.minimum_compression_size
    endpoint_type = var.endpoint_type
    vpc_endpoint_ids = var.vpc_endpoint_ids
    disable_execute_api_endpoint = var.disable_execute_api_endpoint

    default_tags = var.default_tags
}

module "api_models" {
    source = "./modules/api-models"

    for_each = { for model in var.models: model.name => model }

    name = each.key
    description = lookup(each.value, "description", null)
    content_type = lookup(each.value, "content_type", "application/json")
    schema = jsonencode(lookup(each.value, "schema"))
}

module "api_security" {
    source = "./modules/api-security"

    api_gateway_name = var.name
    rest_api_id = local.rest_api_id
    
    api_keys = var.api_keys
    authorizers = var.authorizers
    
    default_tags = var.default_tags
}

module "api_resource" {
    source = "./modules/api-resource"

    count = var.create_resource ? 1 : 0

    rest_api_id = local.rest_api_id
    parent_id   = (var.parent_resource_id != null 
                                && var.parent_resource_id != "") ? var.parent_resource_id : local.root_resource_id
    path_part   = var.path_part 
}

module "api_method" {
    source = "./modules/api-method"

    count = var.create_method ? 1 : 0

    rest_api_id = local.rest_api_id
    resource_id = local.resource_id
    http_method  = var.http_method
    
    authorization = var.method_authorization 
    authorizer_id = var.authorizer_id
    authorization_scopes = var.authorization_scopes

    api_key_required = var.api_key_required
    
    validate_request_body       = var.validate_request_body
    validate_request_parameters = var.validate_request_parameters

    operation_name = var.operation_name
    request_models = var.request_models
    
    request_headers = var.method_request_headers
    query_string_parameters = var.method_query_string_parameters

    responses = var.method_responses
    
    depends_on = [
        module.api_models
    ]
}

module "api_integration" {
    source = "./modules/api-integration"

    rest_api_id = local.rest_api_id
    resource_id = local.resource_id
    http_method  = var.http_method

    responses = var.integration_responses

    depends_on = [
        module.api_method
    ]
}