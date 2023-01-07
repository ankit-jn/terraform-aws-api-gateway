locals {
    request_parameters = {for param in var.request_parameters: 
                                format("integration.request.querystring.%s", param) => format("method.request.querystring.%s", param) }
    request_headers = {for header in var.request_headers: 
                                format("integration.request.header.%s", header) => format("method.request.header.%s", header) } 
}