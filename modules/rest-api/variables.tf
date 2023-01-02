variable "name" {
    description = "The name of the Rest API Gateway"
    type        = string
}

variable "description" {
    description = "Description of the REST API Gateway."
    type        = string
}

variable "api_key_source" {
    description = "Source of the API key for requests."
    type        = string
}

variable "binary_media_types" {
    description = "List of binary media types supported by the REST API."
    type        = list(string)
}

variable "minimum_compression_size" {
    description = "Minimum response size to compress for the REST API."
    type        = number
}

variable "endpoint_type" {
    description = "Endpoint Type."
    type        = string
}

variable "vpc_endpoint_ids" {
    description = "Set of VPC Endpoint identifiers if `endpoint_type` is set as `PRIVATE`."
    type        = set(string)
}

variable "disable_execute_api_endpoint" {
    description = "Flag to decide whether clients can invoke API by using the default execute-api endpoint."
    type        = bool
}

variable "default_tags" {
    description = "A map of tags assigned to all the API Gateway resources."
    type        = map(string)
}