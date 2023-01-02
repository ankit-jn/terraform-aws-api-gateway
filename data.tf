data aws_api_gateway_rest_api "this" {
    count = var.create_api ? 0 : 1

    name = var.name
}