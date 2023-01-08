variable "api_gateway_name" {
    description = "The name of the Rest API Gateway"
    type        = string
}

variable "rest_api_id" {
    description = "ID of the associated REST API."
    type        = string
}

variable "api_keys" {
    description = <<EOF
List of API Keys configuration map:

name: (Required) API Key Name.
description: (Optional) Description of the API Key.
enabled: (Optional) Flag to decide if API Key can be used by the Callers.
value: (Optional) Value of the API Key.
tags: (Option) A map of tags assigned to this key.
EOF
    type        = map(any)
}

variable "authorizers" {
    description = <<EOF
List of Authorizers configuration map:

name: (Required) Name of the Authorizer.
type: (Optional) Type of the authorizer, Default: TOKEN
authorizer_uri: (Optional, required for type TOKEN/REQUEST) Authorizer's Uniform Resource Identifier (URI).
identity_source: (Optional) Source of the identity in an incoming request.
authorizer_credentials: (Optional) Credentials required for the authorizer.
authorizer_result_ttl_in_seconds: (Optional) TTL of cached authorizer results in seconds. Defaults to 300.
identity_validation_expression: (Optional) Validation expression for the incoming identity.
provider_arns: (Optional, required for type COGNITO_USER_POOLS) List of the Amazon Cognito user pool ARNs.
EOF
    type        = map(any)
}

variable "default_tags" {
    description = "A map of tags assigned to all the API Gateway resources."
    type        = map(string)
}