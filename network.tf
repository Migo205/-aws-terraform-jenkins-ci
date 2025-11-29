
#Getting the list of the available AZs in our region
data "aws_availability_zones" "available_zones" {
  state = "available"
}

# Create Internet Gateway
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.my_vpc.id
  tags = {
    Name = "igw"
  }
}
# Create the Public Subnet
resource "aws_subnet" "public" {
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = var.public_subnet_cidr
  availability_zone = data.aws_availability_zones.available_zones.names[0]
  tags = {
    Name = "public_subnet"
  }
}
# Create route table for the public subnet and associate it with the public subnet
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
  tags = {
    Name      = "project_public_rtb"
    Terraform = "true"
  }
}
  


# Create route table associations to the public subnet
resource "aws_route_table_association" "a_rt" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public_rt.id
  depends_on     = [aws_subnet.public]
}


# Creating an Elastic IP 
resource "aws_eip" "ec2_eip" {
  domain = "vpc"
  instance = aws_instance.jenkins_instance.id
  tags = {
    Name = "eip_jenkins"
  }
}