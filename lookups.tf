# Access a key in Consul
data "vault_generic_secret" "credentials" {
    path = "secret/credentials"
}

data "consul_keys" "aws_infra" {
  
  key {
    name    = "subnet_id"
    path    = "services/${var.env}/${var.service_name}/subnet_id"
    default = ""
  }
  
  key {
    name    = "security_group"
    path    = "services/${var.env}/${var.service_name}/security_group"
    default = ""
  }
  
  key {
    name    = "ami"
    path    = "services/${var.env}/${var.service_name}/${var.service_version}/ami"
    default = ""
  }

  key {
    name    = "instance_type"
    path    = "services/${var.env}/${var.service_name}/instance_type"
    default = ""
  }

  key {
    name    = "key_pair"
    path    = "services/${var.env}/${var.service_name}/key_pair"
    default = ""
  }

  key {
    name    = "instance_user"
    path    = "services/${var.env}/${var.service_name}/instance_user"
    default = ""
  }

  key {
    name    = "dns_name"
    path    = "services/${var.env}/${var.service_name}/dns_name"
    default = ""
  }

  key {
    name    = "dns_zone"
    path    = "services/${var.env}/${var.service_name}/dns_zone"
    default = ""
  }

  key {
    name    = "private_zone"
    path    = "services/${var.env}/${var.service_name}/private_zone"
    default = ""
  }
}