resource aws_api_gateway_api_key "this" {

    for_each = { for key in var.api_keys: key.name => key }

    name        = each.key
    description = lookup(each.value, "description", each.key)
    enabled     = lookup(each.value, "enabled", true)
    value       = lookup(each.value, null)
    
    tags = merge({ "Name" = each.key }, 
                        { "API Gateway" = var.api_gateway_name }, 
                        lookup(each.value, "tags", {}), 
                        var.default_tags)
}

resource aws_api_gateway_authorizer "this" {

    for_each = { for authorizer in var.authorizers: authorizer.name => authorizer }

    name                   = each.key
    rest_api_id            = local.rest_api_id
    
    type = try(each.value.type, "TOKEN")
    authorizer_uri = try(each.value.authorizer_uri, null)
    identity_source = try(each.value.identity_source, "method.request.header.Authorization")
    authorizer_credentials = try(each.value.authorizer_credentials, null)
    authorizer_result_ttl_in_seconds = try(each.value.authorizer_result_ttl_in_seconds, 300)
    identity_validation_expression = try(each.value.identity_validation_expression, null)
    provider_arns = try(each.value.provider_arns, null)
}