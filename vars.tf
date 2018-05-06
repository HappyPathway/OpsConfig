variable "count" {
    default = 3
}

variable "system_user" {
    default = "admin"
}

variable "system_password" {
    default = "admin"
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

variable "azure_subscription" {} 
variable "azure_tenant" {}
variable "azure_client" {} 
variable "azure_secret" {}

variable "service_name" {
    default = "consul-cluster"
}
