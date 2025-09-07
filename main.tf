resource "aws_vpc" "my-vpc" {
  cidr_block = "172.120.0.0/16" // class B 65k
  enable_dns_hostnames = true
  enable_dns_support = true
  instance_tenancy = "default" // sharing the tenance with others / dedicated means private

  tags = {
    Name = "utc-vpc"
    env  = "Dev"
    app-name = "utc"
    Team = "utc"
    created_by = "Praise"

  }
}

// Internetgateway - this allows the vpc to get traffic/ internet from the internet, if not added vpc stays private
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.my-vpc.id

  tags = {
    Name = "dev-wdp-IGW"
  }
}

// public subnet
resource "aws_subnet" "public1" {
  vpc_id     = aws_vpc.my-vpc.id
  cidr_block = "172.120.1.0/24" // class c 254 ips
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "utc-public-sub1"
  }
}

resource "aws_subnet" "public2" {
  vpc_id     = aws_vpc.my-vpc.id
  cidr_block = "172.120.2.0/24" // class c 254 ips
  availability_zone = "us-east-1b"
  map_public_ip_on_launch = true
  tags = {
    Name = "utc-public-sub2"
  }
}

// private subnet
resource "aws_subnet" "private1" {
  vpc_id     = aws_vpc.my-vpc.id
  cidr_block = "172.120.3.0/24" // class c 254 ips
  availability_zone = "us-east-1a"

  tags = {
    Name = "utc-private-sub1"
  }
}

resource "aws_subnet" "private2" {
  vpc_id     = aws_vpc.my-vpc.id
  cidr_block = "172.120.4.0/24" // class c 254 ips
  availability_zone = "us-east-1b"

  tags = {
    Name = "utc-private-sub2"
  }
}

//nat gateway alloes server in the private subnet get can reach out to external port and resources and internet

resource "aws_eip" "eip" {
}

resource "aws_nat_gateway" "nat" {
    allocation_id = aws_eip.eip.id 
    subnet_id = aws_subnet.public1.id
    tags = {
      Name = "utc-NAT"
    }
  
}
