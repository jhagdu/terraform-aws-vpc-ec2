//Creating Internet Gateway
resource "aws_internet_gateway" "int_gw" {
  vpc_id = "${aws_vpc.my_vpc.id}"

  tags = {
    Name = "Internet GW"
  }
}

//Creating Route Table for Internet GW
resource "aws_route_table" "route_table" {
  vpc_id = "${aws_vpc.my_vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.int_gw.id}"
  }

  tags = {
    Name = "Route Table"
  }
}

//Associating Route Table with Public Subnet
resource "aws_route_table_association" "a" {
  subnet_id      = "${aws_subnet.public_subnet.id}"
  route_table_id = "${aws_route_table.route_table.id}"
}
