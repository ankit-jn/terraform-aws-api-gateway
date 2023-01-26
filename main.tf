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
    
    api_keys    = var.api_keys
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
    
    ## Method Request
    authorization = var.method_authorization 
    authorizer_id = var.authorizer_id
    authorization_scopes = var.authorization_scopes

    api_key_required = var.api_key_required
    
    validate_request_body       = var.validate_request_body
    validate_request_parameters = var.validate_request_parameters

    operation_name = var.operation_name
    request_models = var.request_models
    
    method_request_headers = var.method_request_headers
    method_query_string_parameters = var.method_query_string_parameters
    
    ## Method Response
    method_responses = var.method_responses
    
    ## Integration Request
    integration_http_method = var.integration_http_method
    integration_type = var.integration_type
    integration_connection_type = var.integration_connection_type
    integration_connection_id = var.integration_connection_id
    integration_uri = var.integration_uri
    integration_credentials = var.integration_credentials
    integration_content_handling = var.integration_request_content_handling
    integration_cache_namespace = var.integration_cache_namespace
    integration_timeout = var.integration_timeout
    
    integration_passthrough_behavior = var.integration_passthrough_behavior
    
    integration_request_templates = var.integration_request_templates
    integration_request_headers = var.integration_request_headers
    integration_request_parameters = var.integration_request_parameters
    integration_cache_parameters = var.integration_cache_parameters
    
    ## Integration Response
    integration_responses = var.responses

    depends_on = [
        module.api_models
    ]
}

module "api_deployment" {
    source = "./modules/api-deployment"

    count = var.create_deployment ? 1 : 0

    api_gateway_name = var.name
    rest_api_id = local.rest_api_id

    description = var.deployment_description
    
    triggers = var.deployment_triggers
    
    stage_name = var.stage_name
    stage_description = var.stage_description
    stage_variables = var.stage_variables

    canary_deployment = var.canary_deployment
    canary_traffic_percentage = var.canary_traffic_percentage
    use_stage_cache = var.use_stage_cache
    canary_variables = var.canary_variables

    cache_cluster_enabled = var.cache_cluster_enabled
    cache_cluster_size = var.cache_cluster_size
    
    xray_tracing_enabled = var.xray_tracing_enabled
    client_certificate_id = var.client_certificate_id
    documentation_version = var.documentation_version
    
    enable_access_logs = var.enable_access_logs
    access_log_destination = var.access_log_destination
    access_log_format = var.access_log_format

    method_settings = var.method_settings
    
    default_tags = var.default_tags
}

resource aws_api_gateway_vpc_link "this" {
    for_each = { for vpc_link in var.vpc_links: vpc_link.name => vpc_link }

    name        = each.key
    description = lookup(each.value, "description", each.key)
    target_arns = each.value.target_arns

    tags = merge({ "Name" = each.key }, 
                        lookup(each.value, "tags", {}), 
                        var.default_tags)
}