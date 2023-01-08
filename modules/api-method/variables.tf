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

variable "method_request_headers" {
    description = "The map of Headers where key is header name and value indicates if the header is required."
    type        = map(bool)
}

variable "method_query_string_parameters" {
    description = "The map of Query String Parameters where key is Parameter name and value indicates if the parameter is required."
    type        = map(bool)
}

variable "method_responses" {
    description = <<EOF
List of response configuration map to be used with Method:

status_code: HTTP Status Code
response_headers: The map of headers where key is the header name and value indicates if the header is mandatory.
response_models: Map of API models used for response's content type where key is the content type and value is model's name.
EOF
    type    = any
}

variable "integration_http_method" {
    description = "Integration HTTP Method."
    type        = string
}

variable "integration_type" {
    description = "Integration Input's type."
    type        = string
}

variable "integration_connection_type" {
    description = "Integration Input's type."
    type        = string
}

variable "integration_connection_id" {
    description = "ID of the VpcLink used for the integration."
    type        = string
}

variable "integration_uri" {
    description = "Input's URI. Required if type is AWS, AWS_PROXY, HTTP or HTTP_PROXY."
    type        = string
}

variable "integration_credentials" {
    description = "Credentials required for the integration."
    type        = string
}

variable "integration_request_content_handling" {
    description = "How to handle request payload content type conversions."
    type        = string
}

variable "integration_cache_namespace" {
    description = "Integration's cache namespace."
    type        = string
}

variable "integration_timeout" {
    description = "Custom timeout between 50 and 29,000 milliseconds."
    type        = number
}

variable "integration_passthrough_behavior" {
    description = "(Optional) Integration passthrough behavior."
    type        = string
}

variable "integration_request_templates" {
    description = "(Optional) Map of the integration's request templates."
    type        = map(string)
}

variable "integration_request_headers" {
    description = "The list of request headers that should be passed to the backedn responser."
    type        = map(string)
}

variable "integration_request_parameters" {
    description = "The list of request query string parameters that should be passed to the backedn responser."
    type        = map(string)
}

variable "integration_cache_parameters" {
    description = "(Optional) List of cache key parameters for the integration."
    type        = list(string)
}

variable "integration_responses" {
    description = <<EOF
List of response configuration map to be used with Integration:

status_code: HTTP Status Code
http_method: HTTP Method
selection_pattern: (Optional) Regular expression pattern used to choose an integration response based on the response from the backend.
content_handling: (Optional) How to handle request payload content type conversions.
response_headers: (Optional) The list of headers that can be read from the backend responses.
response_templates:(Optional) Map of templates used to transform the integration response body.
EOF
    type    = any
}
