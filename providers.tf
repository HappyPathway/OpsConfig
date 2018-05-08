# Configure the Consul provider
provider "consul" {
  address    = "${var.consul_address}"
  datacenter = "${var.consul_dc}"
}

provider "vault" {
  address    = "${var.vault_address}"
}