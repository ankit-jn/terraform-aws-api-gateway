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
    
}