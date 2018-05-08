# Configure the Consul provider
provider "consul" {
  address    = "${var.consul_address}"
  datacenter = "${var.consul_dc}"
}
