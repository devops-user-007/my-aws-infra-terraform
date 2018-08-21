resource "aws_instance" "public_instance_1" {
	ami = "ami-0cf31d971a3ca20d6"
	instance_type = "t2.micro"

	# VPC subnet
	subnet_id = "${ aws_subet.public_subnet_1.id }"

	# Security Group
	vpc_security_group_ids = "${ aws_security_group.allow_ssh_sg.id }"

	# public ssh key
	key_name = "${ aws_key_pair.mykeypair.key_name }"	
	
}
