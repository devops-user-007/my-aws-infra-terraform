# Subnets

# Create DMZ Subnets in Multiple AZ
# DMZ subnet 1
resource "aws_subnet" "dmz_subnet_1" {
	vpc_id = "${ aws_vpc.vpc_prod.id }"
	cidr_block = "192.168.0.0/23"
	map_public_ip_on_launch = "true"
	availability_zone = "us-east-2a"
	
	tags {
		Name = "dmz_subnet_1"
	}
}

# DMZ subnet 2
resource "aws_subnet" "dmz_subnet_2" {
	vpc_id = "${ aws_vpc.vpc_prod.id }"
	cidr_block = "192.168.2.0/23"
	map_public_ip_on_launch = "true"
	availability_zone = "us-east-2b"

	tags {
		Name = "dmz_subnet_2"
	}
}


# Public subnets in Multi AZ
resource "aws_subnet" "public_subnet_1" {
	vpc_id = "${ aws_vpc.vpc_prod.id }"
	cidr_block = "192.168.4.0/23"
	map_public_ip_on_launch = "true"
	availability_zone = "us-east-2a"
	
	tags {
		Name = "public_subnet_1"
	}
}

resource "aws_subnet" "public_subnet_2" {
	vpc_id = "${ aws_vpc.vpc_prod.id }"
	cidr_block = "192.168.6.0/23"
	map_public_ip_on_launch = "true"
	availability_zone = "us-east-2b"

	tags {
		Name = "public_subnet_2"
	}
}


# Private subnets in Multi AZ
resource "aws_subnet" "private_subnet_1" {
	vpc_id = "${ aws_vpc.vpc_prod.id }"
	cidr_block = "192.168.8.0/23"
	availability_zone = "us-east-2a"

	tags {
		Name = "private_subnet_1"
	}
}

resource "aws_subnet" "private_subnet_2" {
	vpc_id = "${ aws_vpc.vpc_prod.id }"
	cidr_block = "192.168.10.0/23"
	availability_zone = "us-east-2b"
 
	tags {
		Name = "private_subnet_2"
	}
}
