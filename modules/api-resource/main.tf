resource aws_api_gateway_resource "this" {
    rest_api_id = var.rest_api_id
    parent_id   = var.parent_resource_id
    path_part   = var.path_part 
}