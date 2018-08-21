# CREATE ROUTE TABLE
resource "aws_route_table" "dmz_rt" {
	vpc_id = "${ aws_vpc.vpc_prod.id }"
	
	route {
		cidr_block = "0.0.0.0/0"
		gateway_id = "${ aws_internet_gateway.igw_prod.id }"
	}

	tags {
		Name = "dmz_rt"
	}
}

resource "aws_route_table" "public_rt" {
	vpc_id = "${ aws_vpc.vpc_prod.id }"
	
	route {
		cidr_block = "0.0.0.0/0"
		gateway_id = "${ aws_internet_gateway.igw_prod.id }"
	}

	tags {
		Name = "public_rt"
	}
}

# CREATE ROUTE TABLE ASSOCIATION
resource "aws_route_table_association" "dmz_rt_subnet_1" {
	route_table_id = "${ aws_route_table.dmz_rt.id }"
	subnet_id = "${ aws_subnet.dmz_subnet_1.id }"
}

resource "aws_route_table_association" "dmz_rt_subnet_2" {
	route_table_id = "${ aws_route_table.dmz_rt.id }"
	subnet_id = "${ aws_subnet.dmz_subnet_2.id }"
}

resource "aws_route_table_association" "public_rt_subnet_1" {
	route_table_id = "${ aws_route_table.public_rt.id }"
	subnet_id = "${ aws_subnet.public_subnet_1.id }"
}

resource "aws_route_table_association" "public_rt_subnet_2" {
	route_table_id = "${ aws_route_table.public_rt.id }"
	subnet_id = "${ aws_subnet.public_subnet_2.id }"
}
