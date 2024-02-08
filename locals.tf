locals {
    tags = {
        Terraform   = "true"
        Environment = "${var.environment}"
    }

    user_data = <<-EOT
      #!/bin/bash
      echo "Hello"
      yum update
      yum install nginx
      systemctl enable nginx && systemctl start nginx
      nginx -t
      systemctl restart nginx
    EOT

    properties = {
        account_id  = data.aws_caller_identity.caller.account_id,
        environment = "${var.environment}",
        project     = "${var.project}"
    }
}


