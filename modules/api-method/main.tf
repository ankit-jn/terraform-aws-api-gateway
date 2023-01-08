resource aws_api_gateway_method "this" {
    rest_api_id = var.rest_api_id
    resource_id = var.resource_id
    http_method = var.http_method

    authorization = var.authorization
    authorizer_id = contains(["Custom", "COGNITO_USER_POOLS"], var.authorization) ? var.authorizer_id : null
    authorization_scopes = var.authorization == "COGNITO_USER_POOLS" ? var.authorization_scopes : null

    api_key_required = var.api_key_required
    request_validator_id = (var.validate_request_body 
                                || var.validate_request_parameters) ? aws_api_gateway_request_validator.this[0].id : null

    operation_name = var.operation_name
    request_models = var.request_models

    request_headers = { for header, flag in var.method_request_headers: 
                                format("method.request.header.%s", header) => flag }
    query_string_parameters = { for param, flag in var.method_query_string_parameters: 
                                format("method.request.querystring.%s", param) => flag }
}

resource aws_api_gateway_request_validator "this" {
    count = (var.validate_request_body || var.validate_request_parameters) ? 1 : 0

    name        = format("%s-%s-%s-validator", var.rest_api_id, var.resource_id, var.api_method)
    rest_api_id = var.rest_api_id
    
    validate_request_body       = var.validate_request_body
    validate_request_parameters = var.validate_request_parameters
}

resource aws_api_gateway_method_response "this" {
    for_each = { for response in var.method_responses: response.status_code => repsonse }

    rest_api_id = var.rest_api_id
    resource_id = var.resource_id
    http_method = aws_api_gateway_method.this.http_method
    status_code = each.key
    response_models = try(each.value.response_models, {})
    request_headers = { for header, flag in try(each.value.response_headers, {}): 
                                format("method.response.header.%s", header) => flag }
}

resource aws_api_gateway_integration "this" {
    rest_api_id = var.rest_api_id
    resource_id = var.resource_id
    http_method = var.http_method

    integration_http_method = var.integration_http_method
    type = var.integration_type
    connection_type = var.integration_connection_type
    connection_id = var.integration_connection_id
    uri = var.integration_uri
    credentials = var.integration_credentials
    content_handling = var.integration_content_handling
    cache_namespace = var.integration_cache_namespace
    timeout_milliseconds = var.integration_timeout

    integration_passthrough_behavior = var.integration_passthrough_behavior
    request_templates = var.integration_request_templates
    request_parameters = merge(local.integration_request_parameters, local.integration_request_headers)
    cache_parameters = var.integration_cache_parameters
}

resource aws_api_gateway_integration_response "this" {
    for_each = { for response in var.integration_responses: response.status_code => repsonse }

    rest_api_id = var.rest_api_id
    resource_id = var.resource_id
    http_method = each.value.http_method
    status_code = each.key

    selection_pattern = lookup(each.value, "selection_pattern", null) 
    content_handling = lookup(each.value, "content_handling", null)
    request_headers = { for header in try(each.value.response_headers, []): 
                                format("method.response.header.%s", header) => format("integration.response.header.%s", header) }
    response_templates = lookup(each.value, "response_templates", null)
}