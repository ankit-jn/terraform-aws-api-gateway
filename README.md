## ARJ-Stack: AWS API Gateway Terraform module

A Terraform module for managing AWS API Gatway resources

### Resources

This module features the following components to be provisioned:

-  API Gateway Rest API [[aws_api_gateway_rest_api](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/api_gateway_rest_api)]

### Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.2.5 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.22.0 |

### Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 4.22.0 |

### Examples

Refer [Configuration Examples](https://github.com/arjstack/terraform-aws-examples/tree/main/aws-api-gateway) for effectively utilizing this module.

### Inputs
---

#### Control Flags

| Name | Description | Type | Default | Required |
|:------|:------|:------|:------|:------:|
| <a name="create_api"></a> [create_api](#input\_create\_api) | Flag to decide if API Gateway should be provisioned. | `bool` | `true` | no |
| <a name="create_resource"></a> [create_resource](#input\_create\_resource) | Flag to decide if API resource should be provisioned. | `bool` | `false` | no |
| <a name="create_method"></a> [create_method](#input\_create\_method) | Flag to decide if API resource method should be provisioned. | `bool` | `false` | no |
| <a name="create_deployment"></a> [create_deployment](#input\_create\_deployment) | Flag to decide if API deployment is configured. | `bool` | `false` | no |

#### API Gateway

| Name | Description | Type | Default | Required |
|:------|:------|:------|:------|:------:|
| <a name="name"></a> [name](#input\_name) | The name of the Rest API Gateway. | `string` |  | yes |
| <a name="description"></a> [description](#input\_description) | Description of the REST API Gateway. | `string` | `null` | no |
| <a name="api_key_source"></a> [api_key_source](#input\_api\_key\_source) | Source of the API key for requests. | `string` | `"HEADER"` | no |
| <a name="binary_media_types"></a> [binary_media_types](#input\_binary\_media\_types) | List of binary media types supported by the REST API. | `list(string)` | `["UTF-8-encoded"]` | no |
| <a name="minimum_compression_size"></a> [minimum_compression_size](#input\_minimum\_compression\_size) | Minimum response size to compress for the REST API. | `number` | `-1` | no |
| <a name="endpoint_type"></a> [endpoint_type](#input\_endpoint\_type) | Endpoint Type. | `string` | `"EDGE"` | no |
| <a name="vpc_endpoint_ids"></a> [vpc_endpoint_ids](#input\_vpc\_endpoint\_ids) | Set of VPC Endpoint identifiers if `endpoint_type` is set as `PRIVATE`. | `set(string)` | `[]` | no |
| <a name="disable_execute_api_endpoint"></a> [disable_execute_api_endpoint](#input\_disable\_execute\_api\_endpoint) | Flag to decide whether clients can invoke API by using the default execute-api endpoint. | `bool` | `false` | no |
| <a name="default_tags"></a> [default_tags](#input\_default\_tags) | A map of tags assigned to all the API Gateway resources. | `map(string)` | `{}` | no |

#### API Models

| Name | Description | Type | Default | Required |
|:------|:------|:------|:------|:------:|
| <a name="models"></a> [models](#models) | The list of Models configuration map to provision. | `any` | `[]` | no |

#### API Security

| Name | Description | Type | Default | Required |
|:------|:------|:------|:------|:------:|
| <a name="api_keys"></a> [api_keys](#api\_key) | List of API Keys configuration map. | `map(any)` | `[]` | no |
| <a name="authorizers"></a> [authorizers](#authorizer) | List of Authorizers configuration map. | `map(any)` | `[]` | no |

#### API Resource

- `path_part` is required only if control flag `create_resource` is set `true`.
- Default will for `parent_resource_id` will be set to `root_resource_id` of Rest API gateway.

| Name | Description | Type | Default | Required |
|:------|:------|:------|:------|:------:|
| <a name="parent_resource_id"></a> [parent_resource_id](#input\_parent\_resource\_id) | ID of the parent API resource;  | `string` | `null` | no |
| <a name="path_part"></a> [path_part](#input\_path\_part) | Last path segment of this API resource. | `string` | `null` | yes |

#### API Resource Method

- `resource_id` is required if `create_resource` is set `false`.
- `http_method` is required only if control flag `create_method` is set `true`.

| Name | Description | Type | Default | Required |
|:------|:------|:------|:------|:------:|
| <a name="resource_id"></a> [resource_id](#input\_resource\_id) | API resource ID. | `string` | `null` | no |
| <a name="http_method"></a> [http_method](#input\_http\_method) | HTTP Method. | `string` | `null` | yes |
| <a name="method_authorization"></a> [method_authorization](#input\_method\_authorization) | Type of authorization used for the method. | `string` | `"NONE"` | no |
| <a name="authorizer_id"></a> [authorizer_id](#input\_authorizer\_id) | Authorizer id to be used when the authorization is `CUSTOM` or `COGNITO_USER_POOLS`. | `string` | `null` | no |
| <a name="authorization_scopes"></a> [authorization_scopes](#input\_authorization\_scopes) | Authorization scopes used when the authorization is `COGNITO_USER_POOLS`. | `list(string)` | `[]` | no |
| <a name="api_key_required"></a> [api_key_required](#input\_api\_key\_required) | Flag to decide if the method requires an API key. | `bool` | `false` | no |
| <a name="validate_request_body"></a> [validate_request_body](#input\_validate\_request\_body) | Flag to decide whether to validate request body. | `bool` | `false` | no |
| <a name="validate_request_parameters"></a> [validate_request_parameters](#input\_validate\_request\_parameters) | Flag to decide whether to validate request parameters. | `bool` | `false` | no |
| <a name="operation_name"></a> [operation_name](#input\_operation\_name) | Function name that will be given to the method when generating an SDK through API Gateway. | `string` | `null` | no |
| <a name="request_models"></a> [request_models](#input\_request\_models) | Map of the API models used for the request's content type where key is the content type and value is model's name. | `map(string)` | `{}` | no |
| <a name="method_request_headers"></a> [method_request_headers](#input\_method\_request\_headers) | The map of Headers where key is header name and value indicates if the header is required. | `map(bool)` | `{}` | no |
| <a name="method_query_string_parameters"></a> [method_query_string_parameters](#input\_method\_query\_string\_parameters) | The map of Query String Parameters where key is Parameter name and value indicates if the parameter is required. | `map(bool)` | `{}` | no |
| <a name="method_responses"></a> [method_responses](#method\_response) | List of response configuration map to be used with Method. | `any` | `[]` | no |

#### API Resource Method Integration

- `integration_type` is required only if control flag `create_method` is set `true`.

| Name | Description | Type | Default | Required |
|:------|:------|:------|:------|:------:|
| <a name="integration_http_method"></a> [integration_http_method](#input\_integration\_http\_method) | Integration HTTP Method. | `string` | `null` | no |
| <a name="integration_type"></a> [integration_type](#input\_integration\_type) | Integration Input's type. | `string` | `null` | no |
| <a name="integration_connection_type"></a> [integration_connection_type](#input\_integration\_connection\_type) | Integration Connection Type. | `string` | `"Internet"` | no |
| <a name="integration_connection_id"></a> [integration_connection_id](#input\_integration\_connection\_id) | ID of the VpcLink used for the integration. | `string` | `null` | no |
| <a name="integration_uri"></a> [integration_uri](#input\_integration\_uri) | Input's URI. Required if `integration_type` is `AWS`, `AWS_PROXY`, `HTTP` or `HTTP_PROXY`. | `string` | `null` | no |
| <a name="integration_credentials"></a> [integration_credentials](#input\_integration\_credentials) | Credentials required for the integration. | `string` | `null` | no |
| <a name="integration_request_content_handling"></a> [integration_request_content_handling](#input\_integration\_request\_content\_handling) | How to handle request payload content type conversions. | `string` | `null` | no |
| <a name="integration_cache_namespace"></a> [integration_cache_namespace](#input\_integration\_cache\_namespace) | Integration's cache namespace. | `string` | `null` | no |
| <a name="integration_timeout"></a> [integration_timeout](#input\_integration\_timeout) | Custom timeout between 50 and 29,000 milliseconds. | `number` | `29000` | no |
| <a name="integration_passthrough_behavior"></a> [integration_passthrough_behavior](#input\_integration\_passthrough\_behavior) | Integration passthrough behavior. | `string` | `null` | no |
| <a name="integration_request_templates"></a> [integration_request_templates](#input\_integration\_request\_templates) | Map of the integration's request templates. | `map(string)` | `{}` | no |
| <a name="integration_request_headers"></a> [integration_request_headers](#input\_integration\_request\_headers) | The list of request headers that should be passed to the backedn responser. | `map(string)` | `{}` | no |
| <a name="integration_request_parameters"></a> [integration_request_parameters](#input\_integration\_request\_parameters) | The list of request query string parameters that should be passed to the backedn responser. | `map(string)` | `{}` | no |
| <a name="integration_cache_parameters"></a> [integration_cache_parameters](#input\_integration\_cache\_parameters) | List of cache key parameters for the integration. | `list(string)` | `[]` | no |
| <a name="integration_responses"></a> [integration_responses](#integration\_response) | List of response configuration map to be used with Method Integration. | `any` | `[]` | no |

#### API Deployment

- `integration_type` is required only if control flag `create_method` is set `true`.

| Name | Description | Type | Default | Required |
|:------|:------|:------|:------|:------:|
| <a name="deployment_description"></a> [deployment_description](#input\_deployment\_description) | Description of the deployment | `string` | `null` | no |
| <a name="deployment_triggers"></a> [deployment_triggers](#input\_deployment\_triggers) | Map of arbitrary keys and values that, when changed, will trigger a redeployment. | `map(string)` | `{}` | no |

#### API Stage

- `stage_name` is required only if control flag `create_deployment` is set `true`.
- `access_log_destination` and `access_log_format` are required if control flag `enable_access_logs` is set `true`.

| Name | Description | Type | Default | Required |
|:------|:------|:------|:------|:------:|
| <a name="stage_name"></a> [stage_name](#input\_stage\_name) | Name of the stage to create with this deployment. | `string` | `null` | yes |
| <a name="stage_description"></a> [stage_description](#input\_stage\_description) | Description of the stage. | `string` | `null` | no |
| <a name="cache_cluster_enabled"></a> [cache_cluster_enabled](#input\_cache\_cluster\_enabled) | Whether a cache cluster is enabled for the stage. | `bool` | `false` | no |
| <a name="cache_cluster_size"></a> [cache_cluster_size](#input\_cache\_cluster\_size) | Size of the cache cluster for the stage, if `cache_cluster_enabled` is set `true`. | `number` | `0.5` | no |
| <a name="xray_tracing_enabled"></a> [xray_tracing_enabled](#input\_xray\_tracing\_enabled) | Whether active tracing with X-ray is enabled. | `bool` | `false` | no |
| <a name="client_certificate_id"></a> [client_certificate_id](#input\_client\_certificate\_id) | Identifier of a client certificate for the stage. | `string` | `null` | no |
| <a name="documentation_version"></a> [documentation_version](#input\_documentation\_version) | Version of the associated API documentation. | `string` | `null` | no |
| <a name="stage_variables"></a> [stage_variables](#input\_stage\_variables) | Map that defines the stage variables. | `map(string)` | `{}` | no |
| <a name="enable_access_logs"></a> [enable_access_logs](#input\_enable\_access\_logs) | Whether enables access logs for the API stage. | `bool` | `false` | no |
| <a name="access_log_destination"></a> [access_log_destination](#input\_access\_log\_destination) | ARN of the CloudWatch Logs log group or Kinesis Data Firehose delivery stream to receive access logs. | `string` | `null` | no |
| <a name="access_log_format"></a> [access_log_format](#input\_access\_log\_format) | Formatting and values recorded in the logs. | `string` | `null` | no |
| <a name="canary_deployment"></a> [canary_deployment](#input\_canary\_deployment) | Flag to decide whether canary deployment exist. | `bool` | `false` | no |
| <a name="canary_traffic_percentage"></a> [canary_traffic_percentage](#input\_canary\_traffic\_percentage) | Percent 0.0 - 100.0 of traffic to divert to the canary deployment. | `number` | `0.0` | no |
| <a name="use_stage_cache"></a> [use_stage_cache](#input\_use\_stage\_cache) | Whether the canary deployment uses the stage cache. | `bool` | `false` | no |
| <a name="canary_variables"></a> [canary_variables](#input\_canary\_variables) | Map of overridden stage variables (including new variables) for the canary deployment. | `map(string)` | `{}` | no |

### Nested Configuration Maps:  

#### Models

| Name | Description | Type | Default | Required |
|:------|:------|:------|:------|:------:|
| <a name="name"></a> [name](#input\_name) | Name of the model | `string` |  | yes |
| <a name="description"></a> [description](#input\_description) | Description of the model | `string` | `null` | no |
| <a name="content_type"></a> [content_type](#input\_content\_type) | Content type of the model | `string` | `"application/json"` | no |
| <a name="schema"></a> [schema](#input\_schema) | Schema of the model in a JSON form | `string` |  | yes |

#### api_key

| Name | Description | Type | Default | Required |
|:------|:------|:------|:------|:------:|
| <a name="name"></a> [name](#input\_name) | API Key Name. | `string` |  | yes |
| <a name="description"></a> [description](#input\_description) | Description of the API Key. | `string` | `null` | no |
| <a name="enabled"></a> [enabled](#input\_enabled) | Flag to decide if API Key can be used by the Callers. | `bool` | `true` | no |
| <a name="value"></a> [value](#input\_value) | Value of the API Key. | `string` | `null` | no |
| <a name="tags"></a> [tags](#input\_tags) | A map of tags assigned to this key. | `map(string)` | `{}` | no |

#### authorizer

| Name | Description | Type | Default | Required |
|:------|:------|:------|:------|:------:|
| <a name="name"></a> [name](#input\_name) | Name of the Authorizer. | `string` |  | yes |

#### method_response

| Name | Description | Type | Default | Required |
|:------|:------|:------|:------|:------:|
| <a name="status_code"></a> [status_code](#input\_status\_code) | HTTP Status Code | `string` |  | yes |
| <a name="response_headers"></a> [response_headers](#input\_response\_headers) | The map of headers where key is the header name and value indicates if the header is mandatory. | `map(bool)` | `{}` | no |
| <a name="response_models"></a> [response_models](#input\_response\_models) | Map of API models used for response's content type where key is the content type and value is model's name. | `map(string)` | `{}` | no |

#### integration_response

| Name | Description | Type | Default | Required |
|:------|:------|:------|:------|:------:|
| <a name="status_code"></a> [status_code](#input\_status\_code) | HTTP Status Code | `string` |  | yes |
| <a name="http_method"></a> [http_method](#input\_http\_method) | HTTP Method | `string` |  | yes |
| <a name="selection_pattern"></a> [selection_pattern](#input\_selection\_pattern) | Regular expression pattern used to choose an integration response based on the response from the backend. | `string` | `null` | no |
| <a name="content_handling"></a> [content_handling](#input\_content\_handling) | How to handle request payload content type conversions. | `string` | `null` | no |
| <a name="response_headers"></a> [response_headers](#input\_response\_headers) | The list of headers that can be read from the backend responses. | `list(string)` | `[]` | no |
| <a name="response_templates"></a> [response_templates](#input\_response\_templates) | Map of templates used to transform the integration response body where key is the content type and value is template string. | `map(string)` |  | no |

### Outputs

| Name | Type | Description |
|:------|:------|:------|
| <a name="id"></a> [id](#output\_id) | `string` | ID of Rest API Gateway. |
| <a name="arn"></a> [arn](#output\_arn) | `string` | ARN of Rest API Gateway. |
| <a name="api_execution_arn"></a> [api_execution_arn](#output\_api\_execution\_arn) | `string` | API Gateway Execution ARN part to be used in lambda_permission's source_arn when allowing API Gateway to invoke a Lambda function. |
| <a name="root_resource_id"></a> [root_resource_id](#output\_root\_resource\_id) | `string` | Resource ID of the REST API's root. |
| <a name="resource_id"></a> [resource_id](#output\_resource\_id) | `string` | Resource's identifier. |
| <a name="resource_path"></a> [resource_path](#output\_resource\_path) | `string` | Complete path for the API resource, including all parent paths. |
| <a name="api_keys"></a> [api_keys](#output\_api\_keys) | `map(map(string))` | The API key details. |
| <a name="stage_id"></a> [stage_id](#output\_stage\_id) | `string` | ID of the Stage. |
| <a name="stage_arn"></a> [stage_arn](#output\_stage\_arn) | `string` | ARN of the Stage. |
| <a name="invoke_url"></a> [invoke_url](#output\_invoke\_url) | `string` | URL to invoke the API pointing to the stage. |
| <a name="deployment_execution_arn"></a> [deployment_execution_arn](#output\_deployment\_execution\_arn) | `string` | Deployment Execution ARN to be used in lambda_permission's source_arn when allowing API Gateway to invoke a Lambda function. |

### Authors

Module is maintained by [Ankit Jain](https://github.com/ankit-jn) with help from [these professional](https://github.com/arjstack/terraform-aws-api-gateway/graphs/contributors).