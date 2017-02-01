/**
 *## This module contains helper resources and scripts for using credstash.
 *
 * You can use this module to create reader/writer policies, which together
 * with use `grant.sh` script will let a IAM Role be able read/write credentials
 * by using credstash. It also includes helper commands for getting/putting
 * credentials up into DynamoDB
 */


data "template_file" "credstash-get-cmd" {
  template = "/usr/local/bin/credstash -r ${var.region == "" ? data.aws_region.current.name : var.region} -t ${var.table_name} get"
}

data "template_file" "credstash-put-cmd" {
  template = "/usr/local/bin/credstash -r ${var.region == "" ? data.aws_region.current.name : var.region} -t ${var.table_name} put -k ${var.kms_key_arn}"
}

data "template_file" "credstash-install-snippet" {
  template = <<END_TEMPLATE
apt-get update
apt-get install -y build-essential libssl-dev libffi-dev python-dev python-pip
pip install --upgrade pip
pip install credstash
END_TEMPLATE
}


// Ubuntu bash script snippet for installing credstash
output "install_snippet" {
  value = "${data.template_file.credstash-install-snippet.rendered}"
}
// Credstash get command with region and table values set.
output "get_cmd" {
  value = "${data.template_file.credstash-get-cmd.rendered}"
}
// Credstash put command with region, table and kms key values set.
output "put_cmd" {
  value = "${data.template_file.credstash-put-cmd.rendered}"
}
// Secret Reader policy
output "reader_policy_arn" {
  value = "${aws_iam_policy.reader-policy.arn}"
}
// Secret Writer policy
output "writer_policy_arn" {
  value = "${aws_iam_policy.writer-policy.arn}"
}

