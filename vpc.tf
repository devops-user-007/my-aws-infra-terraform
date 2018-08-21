resource "aws_vpc" "vpc_prod" {
	cidr_block = "192.168.0.0/16"
	instance_tenancy = "default"

	tags {
		Name = "vpc_prod"
	}
}
