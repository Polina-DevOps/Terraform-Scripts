## To create AWS Security group
resource "aws_security_group" "test_allow_SSH" {
  name        		= "test_allow_SSH"
  description 		= "Allow SSH inbound traffic"

  ingress {
    description     = "SSH from VPC"
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    cidr_blocks     = ["0.0.0.0/0"]
  }

  egress {
    from_port       = 22
    to_port         = 22
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }

  tags 				= {
    Name 			= "test_allow_SSH"
  }
}

output "sg-attributres" {
  value	= 	"test_allow_SSH"
}