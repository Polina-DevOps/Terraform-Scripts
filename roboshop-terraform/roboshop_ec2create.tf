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