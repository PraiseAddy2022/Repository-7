// route table private subnet allows traffic from the internet to go through the natgateway

resource "aws_route_table" "rtprivate" {
    vpc_id = aws_vpc.my-vpc.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_nat_gateway.nat.id
    }
  
}
// route table public allows traffic from the internet goes through the internet gateway
resource "aws_route_table" "rtpublic" {
    vpc_id = aws_vpc.my-vpc.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.gw.id

    }
  
}
// public route table association

resource "aws_route_table_association" "rta1" {
    subnet_id = aws_subnet.public1.id
    route_table_id = aws_route_table.rtpublic.id
  
}
resource "aws_route_table_association" "rta2" {
    subnet_id = aws_subnet.public2.id
    route_table_id = aws_route_table.rtpublic.id
  
}
// private route table association

resource "aws_route_table_association" "rta3" {
    subnet_id = aws_subnet.private1.id 
    route_table_id = aws_route_table.rtprivate.id
  
}
resource "aws_route_table_association" "rta4" {
    subnet_id = aws_subnet.private1.id 
    route_table_id = aws_route_table.rtprivate.id
  
}