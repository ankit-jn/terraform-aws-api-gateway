resource aws_api_gateway_integration "this" {
    rest_api_id = var.rest_api_id
    resource_id = var.resource_id
    http_method = var.http_method
}


resource aws_api_gateway_integration_response "this" {
    for_each = { for response in var.responses: response.status_code => repsonse }

    rest_api_id = var.rest_api_id
    resource_id = var.resource_id
    http_method = each.value.http_method
    status_code = each.key
}