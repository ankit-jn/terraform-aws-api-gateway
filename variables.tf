###################################################
## API Gateway
###################################################
variable "create_api" {
    description = "Flag to decide if API Gateway should be provisioned."
    type        = bool
    default     = true
}

variable "name" {
    description = "(Required) The name of the Rest API Gateway"
    type        = string
}

variable "description" {
    description = "(Optional) Description of the REST API Gateway."
    type        = string
    default     = null
}

variable "api_key_source" {
    description = "(Optional) Source of the API key for requests."
    type        = string
    default     = "HEADER"

    validation {
        condition = contains(["HEADER", "AUTHORIZER"], var.api_key_source)
        error_message = "Valid values for `api_key_source` are `HEADER` and `AUTHORIZER`."
    }
}

variable "binary_media_types" {
    description = "(Optional) List of binary media types supported by the REST API."
    type        = list(string)
    default     = ["UTF-8-encoded"]
}

variable "minimum_compression_size" {
    description = "(Optional) Minimum response size to compress for the REST API."
    type        = number
    default     = -1

    validation {
        condition = var.minimum_compression_size >= -1 && var.var.minimum_compression_size <= 10485760
        error_message = "Allowed values for `minimum_compression_size` between -1 and 10485760 (10MB). Setting a value greater than -1 will enable compression, -1 disables compression." 
    }
}

variable "endpoint_type" {
    description = "Endpoint Type."
    type        = string
    default     = "EDGE"

    validation {
        condition = contains(["EDGE", "REGIONAL", "PRIVATE"], var.endpoint_type)
        error_message = "Valid values for `endpoint_type` are `EDGE`, `REGIONAL`, and `PRIVATE`."
    }
}

variable "vpc_endpoint_ids" {
    description = "(Optional) Set of VPC Endpoint identifiers if `endpoint_type` is set as `PRIVATE`."
    type        = set(string)
    default     = []
}

variable "disable_execute_api_endpoint" {
    description = "(Optional) Flag to decide whether clients can invoke API by using the default execute-api endpoint."
    type        = bool
    default     = false
}

variable "default_tags" {
    description = "(Optional) A map of tags assigned to all the API Gateway resources."
    type        = map(string)
    default     = {}
}

###################################################
## API Models
###################################################
variable "models" {
    description = <<EOF
The list of Models configuration map to provision.

name: Name of the model
description: Description of the model
content_type: Content type of the model, default: `application/json`
schema: Schema of the model in a JSON form.

EOF
    type    = any
    default = []
}

###################################################
## API Resource
###################################################
variable "create_resource" {
    description = "Flag to decide if API resource should be provisioned."
    type        = bool
    default     = false
}

variable "parent_resource_id" {
    description = "(Optional) ID of the parent API resource; Default will be set to `root_resource_id` of Rest API gateway."
    type        = string
    default     = null
}

variable "path_part" {
    description = "(Required, if `create_resource` is set `true`) Last path segment of this API resource."
    type        = string
    default     = null
}

###################################################
## API Resource Method
###################################################
variable "create_method" {
    description = "Flag to decide if AI resource method should be provisioned."
    type        = bool
    default     = false
}

variable "resource_id" {
    description = "(Required, if `create_resource` is set `false`) API resource ID."
    type        = string
    default     = null
}

variable "http_method" {
    description = "(Required, if `create_method` is set `true`) HTTP Method."
    type        = string
    default     = null

    validation {
        condition = var.api_method == null ? true : contains(["GET", "POST", "PUT", "DELETE", "HEAD", "OPTIONS", "ANY"], var.api_method)
        error_message = "Valid values for `api_method` are `GET`, `POST`, `PUT`, `DELETE`, `HEAD`, `OPTIONS` or `ANY`."
    }
}

variable "authorization" {
    description = "(Optional) Type of authorization used for the method."
    type        = string
    default     = "NONE"

    validation {
        condition = contains(["NONE", "CUSTOM", "AWS_IAM", "COGNITO_USER_POOLS"], var.authorization)
        error_message = "Valid values for `authorization` are `NONE`, `CUSTOM`, `AWS_IAM`, `COGNITO_USER_POOLS`."
    }
}

variable "authorizer_id" {
    description = "(Optional) Authorizer id to be used when the authorization is `CUSTOM` or `COGNITO_USER_POOLS`."
    type        = string
    default     = null
}

variable "authorization_scopes" {
    description = "(Optional) Authorization scopes used when the authorization is `COGNITO_USER_POOLS`."
    type        = list(string)
    default     = []
}

variable "api_key_required" {
    description = "(Optional) Flag to decide if the method requires an API key."
    type        = bool
    default     = false
}

variable "validate_request_body" {
    description = "(Optional) Flag to decide whether to validate request body."
    type        = bool
    default     = false
}

variable "validate_request_parameters" {
    description = "(Optional) Flag to decide whether to validate request parameters."
    type        = bool
    default     = false
}

variable "operation_name" {
    description = "(Optional) Function name that will be given to the method when generating an SDK through API Gateway."
    type        = string
    default     = null
}

variable "request_models" {
    description = "Map of the API models used for the request's content type where key is the content type and value is model's name."
    type        = map(string)
    default     = {}
}

variable "request_headers" {
    description = "The map of Headers where key is header name and value indicates if the header is required."
    type        = map(bool)
    default     = {}
}

variable "query_string_parameters" {
    description = "The map of Query String Parameters where key is Parameter name and value indicates if the parameter is required."
    type        = map(bool)
    default     = {}
}

variable "request_headers" {
    description = "The map of Headers where key is header name and value indicates if the header is required."
    type        = map(bool)
    default     = {}
}

variable "responses" {
    description = <<EOF
List of response configuration map to be used with Method:

status_code: HTTP Status Code
response_headers: (Optional) The map of headers where key is the header name and value indicates if the header is mandatory.
response_models: (Optional) Map of API models used for response's content type where key is the content type and value is model's name.
EOF
    type    = any
    default = [] 
}