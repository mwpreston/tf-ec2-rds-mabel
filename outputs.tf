output "instance_endpoint" {
  value       = join("", aws_db_instance.db.*.endpoint)
  description = "DNS Endpoint of the instance"
}
output "file_contents" {
  value       = data.template_file.userdata.rendered
  description = "Template file"
}
