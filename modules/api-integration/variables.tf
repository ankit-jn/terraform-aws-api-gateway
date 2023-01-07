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

variable "integration_http_method" {
    description = "Integration HTTP Method."
    type        = string
}

variable "integration_type" {
    description = "Integration Input's type."
    type        = string
}

variable "connection_type" {
    description = "Integration Input's type."
    type        = string
}

variable "connection_id" {
    description = "ID of the VpcLink used for the integration."
    type        = string
}

variable "uri" {
    description = "Input's URI. Required if type is AWS, AWS_PROXY, HTTP or HTTP_PROXY."
    type        = string
}

variable "credentials" {
    description = "Credentials required for the integration."
    type        = string
}

variable "request_content_handling" {
    description = "How to handle request payload content type conversions."
    type        = string
}

variable "cache_namespace" {
    description = "Integration's cache namespace."
    type        = string
}

variable "timeout" {
    description = "Custom timeout between 50 and 29,000 milliseconds."
    type        = number
}

variable "passthrough_behavior" {
    description = "(Optional) Integration passthrough behavior."
    type        = string
}

variable "request_templates" {
    description = "(Optional) Map of the integration's request templates."
    type        = map(string)
}

variable "request_headers" {
    description = "The list of request headers that should be passed to the backedn responser."
    type        = map(string)
}

variable "request_parameters" {
    description = "The list of request query string parameters that should be passed to the backedn responser."
    type        = map(string)
}

variable "cache_parameters" {
    description = "(Optional) List of cache key parameters for the integration."
    type        = list(string)
}

variable "responses" {
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
