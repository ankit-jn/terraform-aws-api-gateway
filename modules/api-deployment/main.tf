resource aws_api_gateway_deployment "this" {
    rest_api_id = var.rest_api_id 
    description = var.description
    
    triggers = var.deployment_triggers 

    lifecycle {
        create_before_destroy = true
    }
}

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

resource aws_api_gateway_method_settings "this" {

    for_each = { for method_setting in var.method_settings: method_setting.path => method_setting }

    rest_api_id = var.rest_api_id
    stage_name  = var.stage_name
    method_path = each.key

    settings {
        metrics_enabled = try(each.value.metrics_enabled, false)
        logging_level = try(each.value.logging_level, "OFF")
        data_trace_enabled = try(each.value.data_trace_enabled, false)
        throttling_burst_limit = try(each.value.throttling_burst_limit, -1)
        throttling_rate_limit = try(each.value.throttling_rate_limit, -1)
        caching_enabled = try(each.value.caching_enabled, false)
        cache_ttl_in_seconds = try(each.value.cache_ttl_in_seconds, null)
        cache_data_encrypted = try(each.value.cache_data_encrypted, null)
        require_authorization_for_cache_control = try(each.value.require_authorization_for_cache_control, null)
        unauthorized_cache_control_header_strategy = try(each.value.unauthorized_cache_control_header_strategy, null)
    }

    depends_on = [
        aws_api_gateway_stage.this
    ]
}