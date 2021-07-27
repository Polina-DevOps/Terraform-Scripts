## To create AWS instance & SG creation

# Request a spot instance at $0.03
resource "aws_spot_instance_request" "cheap_worker" {
  depends_on                = [aws_security_group.roboshop_allowall_tcp]
  count                     = length(var.COMPONENTS)
  ami                       = "ami-074df373d6bafa625"
  spot_price                = "0.0035"
  instance_type             = "t2.micro"
  vpc_security_group_ids    = [aws_security_group.roboshop_allowall_tcp.id]
  wait_for_fulfillment      = true

  tags                      = {
    Name                    = element(var.COMPONENTS,count.index)
  }
}

## AWS Service Group Creation

resource "aws_security_group" "roboshop_allowall_tcp" {
  name                      = "roboshop_allowall_tcp"
  description               = "Allow TCP inbound traffic"

  ingress {
    description             = "TLS from VPC"
    from_port               = 0
    to_port                 = 65535
    protocol                = "tcp"
    cidr_blocks             = ["0.0.0.0/0"]
  }

  egress {
    from_port               = 0
    to_port                 = 65535
    protocol                = "tcp"
    cidr_blocks             = ["0.0.0.0/0"]
    ipv6_cidr_blocks        = ["::/0"]
  }

  tags                      = {
    Name                    = "roboshop_allowall_tcp"
  }
}

## Tag server names

resource "aws_ec2_tag" "robo_server_names" {
  depends_on                = [aws_spot_instance_request.cheap_worker]
  count                     = length(var.COMPONENTS)
  resource_id               = element(aws_spot_instance_request.cheap_worker.*.spot_instance_id, count.index )
  key                       = "Name"
  value                     = element(var.COMPONENTS, count.index )
}

## Define DNS records

resource "aws_route53_record" "roboshop_DNS" {
  count = length(var.COMPONENTS)
  zone_id = "Z039980724SLMJM27D0IM"
  name    = element(var.COMPONENTS,count.index )
  type    = "A"
  ttl     = "300"
  records = [element(aws_spot_instance_request.cheap_worker.*.private_ip,count.index)]
}

##Deploy shell scripts in to the AWS EC2 instances

resource "null_resource" "roboshop_shell_scripts" {
  depends_on                = [aws_route53_record.roboshop_DNS]
  count                     = length(var.COMPONENTS)
  provisioner "remote-exec" {
    connection {
      host                  = element(aws_spot_instance_request.cheap_worker.*.private_ip,count.index)
      user                  = "centos"
      password              = "DevOps321"
    }

    inline = [
            "cd /home/centos",
            "git clone https://github.com/Polina-DevOps/Shell-Scripts.git",
            "cd /home/centos/Shell-Scripts/Roboshop-Init",
            "sudo make ${element(var.COMPONENTS,count.index )}"
    ]
  }
}
