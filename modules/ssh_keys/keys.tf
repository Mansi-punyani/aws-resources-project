resource "tls_private_key" "ssh_key" {
  for_each = var.keys

  algorithm   = lookup(each.value, "algorithm", lookup(var.properties, "algorithm", "ED25519"))
  rsa_bits    = lookup(each.value, "rsa_bits", lookup(var.properties, "rsa_bits", null))
  ecdsa_curve = lookup(each.value, "ecdsa_curve", lookup(var.properties, "ecdsa_curve", null))
}

resource "local_file" "ssh_private_key" {
  for_each = var.keys

  filename        = lookup(each.value, "keys_dir", lookup(var.properties, "keys_dir", null)) != null ? "${path.root}/${lookup(each.value, "keys_dir", lookup(var.properties, "keys_dir", null))}/${each.key}" : "${path.root}/${each.key}"
  content         = tls_private_key.ssh_key[each.key].private_key_pem
  file_permission = "0400"
}

resource "local_file" "ssh_public_key" {
  for_each = var.keys

  filename        = lookup(each.value, "keys_dir", lookup(var.properties, "keys_dir", null)) != null ? "${path.root}/${lookup(each.value, "keys_dir", lookup(var.properties, "keys_dir", null))}/${each.key}.pub" : "${path.root}/${each.key}.pub"
  content         = tls_private_key.ssh_key[each.key].public_key_openssh
  file_permission = "0644"
}

resource "aws_key_pair" "ssh_key" {
  for_each = var.keys

  key_name        = "${var.properties["project"]}-${var.properties["environment"]}-${each.key}"
  public_key      = tls_private_key.ssh_key[each.key].public_key_openssh

  key_name_prefix = lookup(each.value, "key_name_prefix", lookup(var.properties, "key_name_prefix", null))

  tags = merge(var.common_tags, merge(var.tags, {Name = "${var.properties["project"]} ${var.properties["environment"]} ${each.key}"}))
}