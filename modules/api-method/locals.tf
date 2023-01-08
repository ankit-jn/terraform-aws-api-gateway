locals {
    integration_request_parameters = {for param in var.integration_request_parameters: 
                                format("integration.request.querystring.%s", param) => format("method.request.querystring.%s", param) }
    integration_request_headers = {for header in var.integration_request_headers: 
                                format("integration.request.header.%s", header) => format("method.request.header.%s", header) } 
}