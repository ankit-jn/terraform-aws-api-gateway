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
EOF
    type        = map(any)
}

variable "default_tags" {
    description = "A map of tags assigned to all the API Gateway resources."
    type        = map(string)
}