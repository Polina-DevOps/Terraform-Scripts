# Request a spot instance at $0.03

resource "aws_spot_instance_request" "cheap_worker" {
  count                   = length(var.SERVERS_VAR)
  ami                     = "ami-074df373d6bafa625"
  spot_price              = "0.03"
  instance_type           = "t2.micro"
  wait_for_fulfillment    = true
  vpc_security_group_ids = [aws_security_group.allow_roboshop_tcp]

  tags = {
    Name = element(var.SERVERS_VAR,count.index )
  }
}

## AWS Security Group Creation

resource "aws_security_group" "allow_roboshop_tcp" {
  name        = "allow_roboshop_tcp"
  description = "Allow TLS inbound traffic"

  ingress {
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name             = "allow_roboshop_tcp"
  }
}

## To Assign Name Tags

resource "aws_ec2_tag" "robhop_server_tags" {
  depends_on =       [aws_route53_record.roboshop_DNS_Ser]
  count              = length(var.SERVERS_VAR)
  resource_id        = element(aws_spot_instance_request.cheap_worker.*.spot_instance_id,count.index )
  key                = "Name"
  value              = element(var.SERVERS_VAR,count.index )
}

## To define route53 DNS entries

resource "aws_route53_record" "roboshop_DNS_Ser" {
  count              = length(var.SERVERS_VAR)
  zone_id            = "Z039980724SLMJM27D0IM"
  name               = element(var.SERVERS_VAR,count.index )
  type               = "A"
  ttl                = "300"
  records            = [element(aws_spot_instance_request.cheap_worker.*.private_ip,count.index )]
}

## To define shell scripts

resource "null_resource" "shellscript_define" {
  provisioner "remote-exec" {
    count            = length(var.SERVERS_VAR)
    connection {
      type           = "ssh"
      host           = element(aws_spot_instance_request.cheap_worker.*.private_ip,count.index )
      user           = "centos"
      password       = "DevOps321"
    }
    inline = [
      "cd /home/centos",
      "git clone https://github.com/Polina-DevOps/Shell-Scripts.git",
      "cd /home/Shell-Scripts/Roboshop-Init",
      "sudo make ${element(var.SERVERS_VAR,count.index )}"
    ]
  }
}