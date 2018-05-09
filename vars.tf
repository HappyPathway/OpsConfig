variable "count" {
    default = 3
}

variable "ddog_install_script" {
    default = "https://raw.githubusercontent.com/DataDog/datadog-agent/master/cmd/agent/install_script.sh"
}

variable "datadog_monitor" {
    default = true
}

variable "triggers" {
    type = "list"
}

variable "service_name" {
    default = "consul-cluster"
}

variable "service_version" {}

variable "env" {}

variable "hosts" {
    type = "list" 
}

variable "consul_address" {
    default = "consul.ops.happypathway.com:8500"
}

variable "vault_address" {
    default = "http://54.209.49.254:8200"
}

variable "consul_dc" {
    default = "dc1"
}