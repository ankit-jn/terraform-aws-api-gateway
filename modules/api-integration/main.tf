resource aws_api_gateway_integration "this" {
    rest_api_id = var.rest_api_id
    resource_id = var.resource_id
    http_method = var.http_method

    integration_http_method = var.integration_http_method
    type = var.integration_type
    connection_type = var.connection_type
    connection_id = var.connection_id
    uri = var.uri
    credentials = var.credentials
    content_handling = var.content_handling
    cache_namespace = var.cache_namespace
    timeout_milliseconds = var.timeout

    integration_passthrough_behavior = var.passthrough_behavior
    request_templates = var.request_templates
    request_parameters = merge(local.request_parameters, local.request_headers)
    cache_parameters = var.cache_parameters
}

resource aws_api_gateway_integration_response "this" {
    for_each = { for response in var.responses: response.status_code => repsonse }

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