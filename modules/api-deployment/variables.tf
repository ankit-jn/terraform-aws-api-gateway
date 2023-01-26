variable "api_gateway_name" {
    description = "The name of the Rest API Gateway"
    type        = string
}

variable "rest_api_id" {
    description = "ID of the associated REST API."
    type        = string
}

variable "description" {
    description = "Description of the deployment"
    type        = string
}

variable "deployment_triggers" {
    description = "Map of arbitrary keys and values that, when changed, will trigger a redeployment."
    type        = map(string)
}

variable "stage_name" {
    description = "Name of the stage to create with this deployment."
    type        = string
}

variable "stage_description" {
    description = "Description of the stage."
    type        = string
}

variable "cache_cluster_enabled" {
    description = "Whether a cache cluster is enabled for the stage."
    type        = bool
}

variable "cache_cluster_size" {
    description = "Size of the cache cluster for the stage, if enabled."
    type        = number
}

variable "xray_tracing_enabled" {
    description = "Whether active tracing with X-ray is enabled."
    type        = bool
}

variable "default_tags" {
    description = "A map of tags assigned to all the API Gateway resources."
    type        = map(string)
}

 variable "client_certificate_id" {
    description = "Identifier of a client certificate for the stage."
    type        = string
}

variable "documentation_version" {
    description = "Version of the associated API documentation."
    type        = string
}

variable "stage_variables" {
    description = "Map that defines the stage variables."
    type        = map(string)
}

variable "canary_deployment" {
    description = "Flag to decide whether canary deployment exist."
    type        = bool
}

variable "canary_traffic_percentage" {
    desctipyion = "Percent 0.0 - 100.0 of traffic to divert to the canary deployment."
    type        = number
}

variable "use_stage_cache" {
    description = "Whether the canary deployment uses the stage cache."
    type        = bool
}

variable "canary_variables" {
    description = "(Optional) Map of overridden stage variables (including new variables) for the canary deployment."
    type        = map(string)
}

variable "enable_access_logs" {
    description = "(Optional) Whether enables access logs for the API stage."
    type        = bool
}

variable "access_log_destination" {
    description = "ARN of the CloudWatch Logs log group or Kinesis Data Firehose delivery stream to receive access logs."
    type        = string
}

variable "access_log_format" {
    description = "Formatting and values recorded in the logs."
    type        = string
}

variable "method_settings" {
    description = "List of API Gateway Stage Method Settings configuration Map"
    type = list(map(any))
}