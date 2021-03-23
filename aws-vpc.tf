//Create Primary VPC
resource "aws_vpc" "primary" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    Name = "moosterhof-mongodb-vpc"

    owner         = "moosterhof"
    se-region     = "apj"
    purpose       = "demo"
    ttl           = "24"
    terraform     = "true"
    tfe-workspace = "mongodb-atlas-hashicorp"
  }
}

//Create IGW
resource "aws_internet_gateway" "primary" {
  vpc_id = aws_vpc.primary.id
  tags = {
    Name = "moosterhof-mongodb-igw"

    owner         = "moosterhof"
    se-region     = "apj"
    purpose       = "demo"
    ttl           = "24"
    terraform     = "true"
    tfe-workspace = "mongodb-atlas-hashicorp"
  }
}

//Route Table
resource "aws_route" "primary-internet_access" {
  route_table_id         = aws_vpc.primary.main_route_table_id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.primary.id
}

//Subnet-A
resource "aws_subnet" "primary-az1" {
  vpc_id                  = aws_vpc.primary.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "${var.aws_region}a"
  tags = {
    Name = "moosterhof-mongodb-subnet"

    owner         = "moosterhof"
    se-region     = "apj"
    purpose       = "demo"
    ttl           = "24"
    terraform     = "true"
    tfe-workspace = "mongodb-atlas-hashicorp"
  }
}

//Subnet-B
resource "aws_subnet" "primary-az2" {
  vpc_id                  = aws_vpc.primary.id
  cidr_block              = "10.0.2.0/24"
  map_public_ip_on_launch = false
  availability_zone       = "${var.aws_region}b"
  tags = {
    Name = "moosterhof-mongodb-subnet"

    owner         = "moosterhof"
    se-region     = "apj"
    purpose       = "demo"
    ttl           = "24"
    terraform     = "true"
    tfe-workspace = "mongodb-atlas-hashicorp"
  }
}

/*Security-Group
Ingress - Port 80 -- limited to instance
          Port 22 -- Open to ssh without limitations
Egress  - Open to All*/

resource "aws_security_group" "primary_default" {
  name_prefix = "default-"
  description = "Default security group for all instances in ${aws_vpc.primary.id}"
  vpc_id      = aws_vpc.primary.id
  ingress {
    from_port = 0
    to_port   = 0
    protocol  = "tcp"
    cidr_blocks = [
      "0.0.0.0/0",
    ]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "moosterhof-mongodb-sg"

    owner         = "moosterhof"
    se-region     = "apj"
    purpose       = "demo"
    ttl           = "24"
    terraform     = "true"
    tfe-workspace = "mongodb-atlas-hashicorp"
  }
}
