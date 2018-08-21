provider "aws" {
	region = "${ var.REGION }"
	profile = "terraform_user"
}
