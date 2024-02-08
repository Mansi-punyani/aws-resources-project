#############################
## SSH Keys
#############################

module "ssh_keys_vpc_a" {
  source = "./modules/ssh_keys"

  vpc_id     = module.vpc-a.vpc_id

  keys = {
      "id_rsa" = {}
  }

  properties = merge(local.properties, tomap({
      keys_dir    = "keys",
      algorithm   = "RSA",
      rsa_bits    = "4096",
#     ecdsa_curve = "P521",
  }))

  tags = local.tags


}
