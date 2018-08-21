resource "aws_security_group" "sg_allow_ssh" {
	vpc_id = "${ aws_vpc.vpc_prod.id }"
	name = "sg_allow_ssh"
	description = "Allow ssh only"

	egress {
		cidr_blocks = [ "0.0.0.0/0" ]
		from_port = 0
		to_port = 0
		protocol = "ssh"
	}

	ingress {
		cidr_blocks = [ "0.0.0.0/0" ]
		from_port = 22
		to_port = 22
		protocol = "ssh"
	}

	tags {
		Name = "sg_allow_ssh"
	}
}
