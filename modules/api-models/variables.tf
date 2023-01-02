variable "rest_api_id" {
    description = "ID of the associated REST API."
    type        = string
}

variable "name" {
    description = "Name of the model."
    type        = string
}

variable "description" {
    description = "Description of the model."
    type        = string
    default     = null
}

variable "content_type" {
    description = "Content type of the model."
    type        = string
}

variable "schema" {
    description = "Schema of the model in a JSON form."
    type        = string
}