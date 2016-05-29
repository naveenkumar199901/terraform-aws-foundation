resource "template_file" "init-snippet" {
    template = "${path.module}/snippet.tpl"
    vars {
        consul_secret_key = "${var.consul_secret_key}"
        consul_client_token = "${var.consul_client_token}"
        consul_webui = "${var.consul_webui}"
        datacenter = "${var.datacenter}"
        disable_remote_exec = "${var.disable_consul_remote_exec}"
        init_prefix = "${var.init_prefix}"
        init_suffix = "${var.init_suffix}"
        leader_dns = "${var.leader_dns}"
        log_prefix = "${var.log_prefix}"
        log_level = "${var.log_level}"
        retry_interval = "${var.retry_interval}"
    }
}
output "init_snippet" {
    value = "${template_file.init-snippet.rendered}"
}
