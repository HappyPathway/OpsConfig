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
      user     = "${data.consul_keys.aws_infra.var.instance_user}"
  }

  provisioner "file" {
      source = "${path.module}/files/requirements.txt"
      destination = "/tmp/requirements.txt"
  }

  provisioner "file" {
      source = "${path.module}/playbooks"
      destination = "/tmp/opsconfig_playbooks"
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
      "while [ $(top -bn1| grep -q apt; echo $?) == '0' ]; do echo 'apt runing'; sleep 1; done",
      "curl ${var.ddog_install_script} | sudo DD_API_KEY=${data.vault_generic_secret.credentials.data.datadog_key} bash",
      "sudo ansible-playbook /tmp/opsconfig_playbooks/datadog_agent.yaml -e datadog_api_key=${data.vault_generic_secret.credentials.data.datadog_key} -e env=${var.env} -e service_name=${var.service_name}",
      "rm -rf /tmp/playbooks"
    ]
  }
}