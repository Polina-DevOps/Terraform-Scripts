## To create AWS Security group

resource "aws_security_group" "allow_all_jul" {
  name        		= "allow_all_jul"
  description 		= "Allow SSH inbound traffic"

  ingress {
    description     = "SSH from VPC"
    from_port       = 0
    to_port         = 1000
    protocol        = "tcp"
    cidr_blocks     = ["0.0.0.0/0"]
  }

  egress {
    from_port       = 0
    to_port         = 1000
    protocol        = "tcp"
    cidr_blocks     = ["0.0.0.0/0"]
  }

  tags 				= {
    Name 			= "allow_all_jul"
  }
}

output "SG_ID" {
  value = aws_security_group.allow_all_jul.id
}