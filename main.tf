resource "null_resource" "ops_config" {
  
  count = "${var.count}"
  # Changes to any instance of the cluster requires re-provisioning
  triggers {
    cluster_instance_ids = "${join(",", var.triggers)}"
  }

  # Bootstrap script can run on any instance of the cluster
  # So we just choose the first in this case
  connection {
      type     = "ssh"
      host     = "${element(var.hosts, count.index)}"
      user     = "${var.system_user}"
      password = "${var.system_password}"
  }

  provisioner "file" {
      source = "${path.module}/files/requirements.txt"
      destination = "/tmp/requirements.txt"
  }

  provisioner "file" {
      source = "${path.module}/playbooks"
      destination = "/tmp/playbooks"
  }

  provisioner "remote-exec" {
      inline = [
          "sudo apt-get update",
          "sudo apt-get install -y python-pip",
          "sudo pip install -r /tmp/requirements.txt"
      ]
  }

  provisioner "remote-exec" {
    inline = [
      "curl ${var.ddog_install_script} | sudo DD_API_KEY=${var.datadog_key} bash",
      "sudo ansible-playbook /tmp/playbooks/datadog_agent.yaml -e datadog_api_key=${var.datadog_key} -e service_name=${var.service_name}",
      "sudo ansible-playbook /tmp/playbooks/consul_agent.yaml -c local -e env=${var.env} -e consul_cluster=${var.consul_cluster} -e azure_subscription=${var.azure_subscription} -e azure_tenant=${var.azure_tenant} -e azure_client=${var.azure_client} -e azure_secret=${var.azure_secret} -e service_name=${var.service_name} -e service_port=${var.service_port}",
      "rm -rf /tmp/playbooks"
    ]
  }
}