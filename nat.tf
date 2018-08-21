# Create elastic ip for nat gateway
# Create NAT gateway
# Associate NAT gateway to subnets

# Elastic IP
resource "aws_eip" "nat_eip_1" {
	vpc = true
}

resource "aws_eip" "nat_eip_2" {
	vpc = true
}

# Create NAT Gateway
resource "aws_nat_gateway" "nat_gw_1" {
	# Assign Elastic IP
	allocation_id = "${ aws_eip.nat_eip_1.id }"
	subnet_id = "${ aws_subnet.public_subnet_1.id }"
	
	# Assign Internet Gateway
	depends_on = [ "aws_internet_gateway.igw_prod" ]
}

resource "aws_nat_gateway" "nat_gw_2" {
	# Assign Elastic IP
	allocation_id = "${ aws_eip.nat_eip_2.id }"
	subnet_id = "${ aws_subnet.public_subnet_2.id }"

	# Assign Internet Gateway
	depends_on = [ "aws_internet_gateway.igw_prod" ]
}


# Add NAT to private route
resource "aws_route_table" "private_rt_1" {
	vpc_id = "${ aws_vpc.vpc_prod.id }"
	
	route {
		cidr_block = "0.0.0.0/0"
		nat_gateway_id = "${ aws_nat_gateway.nat_gw_1.id }"
	}

	tags {
		Name = "private_rt_1"
	}
}

resource "aws_route_table" "private_rt_2" {
	vpc_id = "${ aws_vpc.vpc_prod.id }"
	
	route {
		cidr_block = "0.0.0.0/0"
		nat_gateway_id = "${ aws_nat_gateway.nat_gw_2.id }"
	}

	tags {
		Name = "private_rt_2"
	}
}


resource "aws_route_table_association" "private_rta_1" {
	subnet_id = "${ aws_subnet.private_subnet_1.id }"
	route_table_id = "${ aws_route_table.private_rt_1.id }"
}

resource "aws_route_table_association" "private_rta_2" {
	subnet_id = "${ aws_subnet.private_subnet_2.id }"
	route_table_id = "${ aws_route_table.private_rt_2.id }"
}
