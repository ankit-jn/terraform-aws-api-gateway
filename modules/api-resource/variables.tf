variable "rest_api_id" {
    description = "ID of the associated REST API."
    type        = string
}

variable "parent_resource_id" {
    description = "ID of the parent API resource."
    type        = string
}

variable "path_part" {
    description = "Last path segment of this API resource."
    type        = string
}