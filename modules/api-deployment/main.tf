resource aws_api_gateway_stage "this" {
    stage_name = var.stage_name
    description = var.stage_description
    variables = var.stage_variables

    deployment_id = aws_api_gateway_deployment.this.id

    cache_cluster_enabled = var.cache_cluster_enabled
    cache_cluster_size = var.cache_cluster_size

    xray_tracing_enabled = var.xray_tracing_enabled
    client_certificate_id = var.client_certificate_id
    
    documentation_version = var.documentation_version

    dynamic "canary_settings" {
        for_each = var.canary_deployment ? [1] : []

        content {
            percent_traffic = var.canary_traffic_percentage
            use_stage_cache = var.use_stage_cache
            stage_variable_overrides = var.canary_variables
        }
    }
    
    dynamic "access_log_settings" {
        for_each = var.enable_access_logs ? [1] : []

        content {
            destination_arn = var.access_log_destination
            format = var.access_log_format
        }
    }

    tags = merge({"Name" = var.stage_name}, 
                        { "API Gateway" = var.api_gateway_name }, 
                        var.default_tags)
}


resource aws_api_gateway_deployment "this" {
    rest_api_id = var.rest_api_id 
    description = var.description
    
    triggers = var.deployment_triggers 

    lifecycle {
        create_before_destroy = true
    }
}