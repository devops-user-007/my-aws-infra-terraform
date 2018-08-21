resource "aws_internet_gateway" "igw_prod" {
	vpc_id = "${ aws_vpc.vpc_prod.id }"
	
	tags {
		Name = "igw_prod"
	}
}
