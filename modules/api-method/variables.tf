variable "rest_api_id" {
    description = "ID of the associated REST API."
    type        = string
}

variable "resource_id" {
    description = "API resource ID."
    type        = string
}

variable "http_method" {
    description = "HTTP Method."
    type        = string
}

variable "authorization" {
    description = "Type of authorization used for the method."
    type        = string
}

variable "authorizer_id" {
    description = "Authorizer id to be used when the authorization is `CUSTOM` or `COGNITO_USER_POOLS`."
    type        = string
}

variable "authorization_scopes" {
    description = "Authorization scopes used when the authorization is `COGNITO_USER_POOLS`."
    type        = list(string)
}

variable "api_key_required" {
    description = "Flag to decide if the method requires an API key."
    type        = bool
}

variable "validate_request_body" {
    description = "Flag to decide whether to validate request body."
    type        = bool
}

variable "validate_request_parameters" {
    description = "Flag to decide whether to validate request parameters."
    type        = bool
}

variable "operation_name" {
    description = "Function name that will be given to the method when generating an SDK through API Gateway."
    type        = string
}

variable "request_models" {
    description = "Map of the API models used for the request's content type where key is the content type and value is model's name."
    type        = map(string)
}

variable "request_headers" {
    description = "The map of Headers where key is header name and value indicates if the header is required."
    type        = map(bool)
}

variable "query_string_parameters" {
    description = "The map of Query String Parameters where key is Parameter name and value indicates if the parameter is required."
    type        = map(bool)
}

variable "responses" {
    description = <<EOF
List of response configuration map to be used with Method:

status_code: HTTP Status Code
response_headers: The map of headers where key is the header name and value indicates if the header is mandatory.
response_models: Map of API models used for response's content type where key is the content type and value is model's name.
EOF
    type    = any
}