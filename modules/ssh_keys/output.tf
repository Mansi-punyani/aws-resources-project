output "ssh_private_keys" {
  value = {
    for key, value in var.keys: key => can(tls_private_key.ssh_key[key].private_key_pem) ? tls_private_key.ssh_key[key].private_key_pem : null
  }
}
output "ssh_keys" {
  value = {
    for key, value in var.keys: key => can(aws_key_pair.ssh_key[key].key_name) ? aws_key_pair.ssh_key[key].key_name : null
  }
}