###################################################
## Control Flags
###################################################
variable "create_api" {
    description = "Flag to decide if API Gateway should be provisioned."
    type        = bool
    default     = true
}

variable "create_resource" {
    description = "Flag to decide if API resource should be provisioned."
    type        = bool
    default     = false
}

variable "create_method" {
    description = "Flag to decide if API resource method should be provisioned."
    type        = bool
    default     = false
}

variable "create_deployment" {
    description = "Flag to decide if API deployment is configured."
    type        = bool
    default     = false
}

###################################################
## API Gateway
###################################################
variable "name" {
    description = "(Required) The name of the Rest API Gateway."
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
## API Security
###################################################
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
    default     = []
}

variable "authorizers" {
    description = <<EOF
List of Authorizers configuration map:

name: (Required) Name of the Authorizer.
type: (Optional) Type of the authorizer, Default: TOKEN
authorizer_uri: (Optional, required for type TOKEN/REQUEST) Authorizer's Uniform Resource Identifier (URI).
identity_source: (Optional) Source of the identity in an incoming request.
authorizer_credentials: (Optional) Credentials required for the authorizer.
authorizer_result_ttl_in_seconds: (Optional) TTL of cached authorizer results in seconds. Defaults to 300.
identity_validation_expression: (Optional) Validation expression for the incoming identity.
provider_arns: (Optional, required for type COGNITO_USER_POOLS) List of the Amazon Cognito user pool ARNs.
EOF
    type        = map(any)
    default     = []
}

###################################################
## API Resource
###################################################
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

variable "method_authorization" {
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
    description = "(Optional) Map of the API models used for the request's content type where key is the content type and value is model's name."
    type        = map(string)
    default     = {}
}

variable "method_request_headers" {
    description = "(Optional) The map of Headers where key is header name and value indicates if the header is required."
    type        = map(bool)
    default     = {}
}

variable "method_query_string_parameters" {
    description = "(Optional) The map of Query String Parameters where key is Parameter name and value indicates if the parameter is required."
    type        = map(bool)
    default     = {}
}

###################################################
## API Resource Method Response
###################################################
variable "method_responses" {
    description = <<EOF
List of response configuration map to be used with Method:

status_code: HTTP Status Code
response_headers: (Optional) The map of headers where key is the header name and value indicates if the header is mandatory.
response_models: (Optional) Map of API models used for response's content type where key is the content type and value is model's name.
EOF
    type    = any
    default = [] 
}

###################################################
## API Resource Method Integration
###################################################
variable "integration_http_method" {
    description = "(Required, if `integration_type` is set `AWS`, `AWS_PROXY`, `HTTP` or `HTTP_PROXY`) Integration HTTP Method."
    type        = string
    default     = null

    validation {
        condition = var.integration_http_method == null ? true : contains(["GET", "POST", "PUT", "DELETE", "HEAD", "OPTIONS", "ANY"], var.integration_http_method)
        error_message = "Valid values for `integration_http_method` are `GET`, `POST`, `PUT`, `DELETE`, `HEAD`, `OPTIONS` or `ANY`."
    }
}

variable "integration_type" {
    description = "(Required, if `create_method` is set `true`) Integration Input's type."
    type        = string
    default     = null

    validation {
        condition = var.integration_type == null ? true : contains(["AWS", "AWS_PROXY", "HTTP", "HTTP_PROXY", "MOCK"], var.integration_type)
        error_message = "Valid values for `integration_type` are `AWS`, `AWS_PROXY`, `HTTP`, `HTTP_PROXY` or `MOCK`."
    }
}

variable "integration_connection_type" {
    description = "(Optional) Integration Connection Type."
    type        = string
    default     = "Internet"

    validation {
        condition = contains(["Internet", "VPC_LINK"], var.integration_connection_type)
        error_message = "Valid values for `integration_connection_type` are `Internet` or `VPC_LINK`."
    }
}

variable "integration_connection_id" {
    description = "(Optional) ID of the VpcLink used for the integration."
    type        = string
    default     = null
}

variable "integration_uri" {
    description = "(Optional) Input's URI. Required if type is AWS, AWS_PROXY, HTTP or HTTP_PROXY."
    type        = string
    default     = null
}

variable "integration_credentials" {
    description = "(Optional) Credentials required for the integration."
    type        = string
    default     = null
}

variable "integration_request_content_handling" {
    description = "(Optional) How to handle request payload content type conversions."
    type        = string
    default     = null

    validation {
        condition = var.integration_content_handling == null ? true : contains(["CONVERT_TO_BINARY", "CONVERT_TO_TEXT"], var.integration_content_handling)
        error_message = "Valid values for `integration_content_handling` are `CONVERT_TO_BINARY` or `CONVERT_TO_TEXT`."
    }
}

variable "integration_cache_namespace" {
    description = "(Optional) Integration's cache namespace."
    type        = string
    default     = null
}

variable "integration_timeout" {
    description = "(Optional) Custom timeout between 50 and 29,000 milliseconds."
    type        = number
    default     = 29000

    validation {
        condition = var.integration_timeout >= 50 && var.var.integration_timeout <= 29000
        error_message = "Allowed values for `integration_timeout` between 50 and 29000 (both inclusive)." 
    }
}

variable "integration_passthrough_behavior" {
    description = "(Optional) Integration passthrough behavior."
    type        = string
    default     = null

    validation {
        condition = var.passthrough_behavior == null ? true : contains(["WHEN_NO_MATCH", "WHEN_NO_TEMPLATES", "NEVER"], var.passthrough_behavior)
        error_message = "Valid values for `passthrough_behavior` are `WHEN_NO_MATCH`, `WHEN_NO_TEMPLATES` or `NEVER`."
    }
}

variable "integration_request_templates" {
    description = "(Optional) Map of the integration's request templates."
    type        = map(string)
    default     = {}
}

variable "integration_request_headers" {
    description = "(Optional) The list of request headers that should be passed to the backedn responser."
    type        = map(string)
    default     = {}
}

variable "integration_request_parameters" {
    description = "(Optional) The list of request query string parameters that should be passed to the backedn responser."
    type        = map(string)
    default     = {}
}

variable "integration_cache_parameters" {
    description = "(Optional) List of cache key parameters for the integration."
    type        = list(string)
    default     = []
}

###################################################
## API Resource Method Integration Response
###################################################
variable "integration_responses" {
    description = <<EOF
List of response configuration map to be used with Method Integration:

status_code: HTTP Status Code
http_method: HTTP Method
selection_pattern: (Optional) Regular expression pattern used to choose an integration response based on the response from the backend.
content_handling: (Optional) How to handle request payload content type conversions.
response_headers: (Optional) The list of headers that can be read from the backend responses.
response_templates:(Optional) Map of templates used to transform the integration response body.
EOF
    type    = any
    default = [] 
}

###################################################
## API Deployment
###################################################
variable "deployment_description" {
    description = "(Optional) Description of the deployment"
    type        = string
    default     = null 
}

variable "deployment_triggers" {
    description = "(Optional) Map of arbitrary keys and values that, when changed, will trigger a redeployment."
    type        = map(string)
    default     = {}
}

variable "stage_name" {
    description = "(Required, if `create_deployment` is set `true`) Name of the stage to create with this deployment."
    type        = string
    default     = null
}

variable "stage_description" {
    description = "(Optional) (Optional) Description of the stage."
    type        = string
    default     = null
}

variable "cache_cluster_enabled" {
    description = "(Optional) Whether a cache cluster is enabled for the stage."
    type        = bool
    default     = false
}

variable "cache_cluster_size" {
    description = "(Optional) Size of the cache cluster for the stage, if enabled."
    type        = number
    default     = 0.5
}

variable "xray_tracing_enabled" {
    description = "(Optional) Whether active tracing with X-ray is enabled."
    type        = bool
    default     = false
}

variable "client_certificate_id" {
    description = "(Optional) Identifier of a client certificate for the stage."
    type        = string
    default     = null
}

variable "documentation_version" {
    description = "(Optional) Version of the associated API documentation."
    type        = string
    default     = null
}

variable "stage_variables" {
    description = "(Optional) Map that defines the stage variables."
    type        = map(string)
    default     = {}
}

variable "canary_deployment" {
    description = "(Optional) Flag to decide whether canary deployment exist."
    type        = bool
    default     = false
}

variable "canary_traffic_percentage" {
    desctipyion = "(Optional) Percent 0.0 - 100.0 of traffic to divert to the canary deployment."
    type        = number
    default     = 0.0
}

variable "use_stage_cache" {
    description = "(Optional) Whether the canary deployment uses the stage cache."
    type        = bool
    default     = false
}

variable "canary_variables" {
    description = "(Optional) Map of overridden stage variables (including new variables) for the canary deployment."
    type        = map(string)
    default     = {}
}

variable "enable_access_logs" {
    description = "(Optional) Whether enables access logs for the API stage."
    type        = bool
    default     = false
}

variable "access_log_destination" {
    description = "(Required if `enable_access_logs` is set `true`) ARN of the CloudWatch Logs log group or Kinesis Data Firehose delivery stream to receive access logs."
    type        = string
    defauult    = null
}

variable "access_log_format" {
    description = "(Required if `enable_access_logs` is set `true`) Formatting and values recorded in the logs."
    type        = string
    defauult    = null
}

varible "method_settings" {
    description = <<EOF
List of API Gateway Stage Method Settings configuration Map:

path: (Required) Method path defined as {resource_path}/{http_method} for an individual method override, or */* for overriding all methods in the stage.

metrics_enabled: (Optional) Whether Amazon CloudWatch metrics are enabled for this method.
logging_level: (Optional) Logging level for this method, which effects the log entries pushed to Amazon CloudWatch Logs. The available levels are OFF, ERROR, and INFO.
data_trace_enabled: (Optional) Whether data trace logging is enabled for this method, which effects the log entries pushed to Amazon CloudWatch Logs.
throttling_burst_limit: (Optional) Throttling burst limit. Default: -1 (throttling disabled).
throttling_rate_limit: (Optional) Throttling rate limit. Default: -1 (throttling disabled).
caching_enabled: (Optional) Whether responses should be cached and returned for requests. A cache cluster must be enabled on the stage for responses to be cached.
cache_ttl_in_seconds: (Optional) Time to live (TTL), in seconds, for cached responses. The higher the TTL, the longer the response will be cached.
cache_data_encrypted: (Optional) Whether the cached responses are encrypted.
require_authorization_for_cache_control: (Optional) Whether authorization is required for a cache invalidation request.
unauthorized_cache_control_header_strategy: (Optional) How to handle unauthorized requests for cache invalidation.
EOF

    type = list(map(any))
    default = []
}

variable "vpc_links" {
    description = <<EOF
List of VPC Links configuration Map:

name: (Required) Name used to label and identify the VPC link.
description: (Optional) Description of the VPC link.
target_arns: (Required, ForceNew) List of network load balancer arns in the VPC targeted by the VPC link. Currently AWS only supports 1 target.
tags: (Optional) Key-value map of resource tags.
EOF
    type        = any
    default     = []
}