variable "count" {
    default = 3
}

variable "datadog_key" {
    default = "zzz"
}

variable "ddog_install_script" {
    default = "https://raw.githubusercontent.com/DataDog/datadog-agent/master/cmd/agent/install_script.sh"
}

variable "datadog_monitor" {
    default = true
}

variable "consul_cluster" {
    default = "consul-westus"
}

variable "triggers" {
    type = "list"
}

variable "service_name" {
    default = "consul-cluster"
}

variable "env" {}

variable "hosts" {
    type = "list" 
}

variable "consul_address" {
    default = "consul.ops.happypathway.com:8500"
}

variable "consul_dc" {
    default = "dc1"
}

variable "dependencies" {}