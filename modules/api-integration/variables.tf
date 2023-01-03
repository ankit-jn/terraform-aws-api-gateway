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

variable "responses" {
    description = <<EOF
List of response configuration map to be used with Integration:

status_code: HTTP Status Code
http_method: HTTP Method
EOF
    type    = any
}