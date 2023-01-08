output "api_keys" {
    description = "The API key details."
    value = { for key in var.api_keys: 
                            key.name => {
                                            id = aws_api_gateway_rest_api.this[key.name].id
                                            arn = aws_api_gateway_rest_api.this[key.name].arn
                                            value = aws_api_gateway_rest_api.this[key.name].value
                                        } }
}

output "api_authorizers" {
    description = "The API Gateway Authorizer details."
    value = { for authorizer in var.authorizers: 
                            authorizer.name => {
                                            id = aws_api_gateway_authorizer.this[authorizer.name].id
                                            arn = aws_api_gateway_authorizer.this[authorizer.name].arn
                                        } }
}