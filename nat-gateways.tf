resource "aws_nat_gateway" "public_a" {
  allocation_id = aws_eip.public_a.id
  subnet_id     = aws_subnet.public_a.id

  depends_on = [
    aws_eip.public_a,
    aws_subnet.public_a
  ]

  tags = {
    Name = "Public NAT A"
  }
}

resource "aws_nat_gateway" "public_b" {
  allocation_id = aws_eip.public_b.id
  subnet_id     = aws_subnet.public_b.id

  depends_on = [
    aws_eip.public_b,
    aws_subnet.public_b
  ]

  tags = {
    Name = "Public NAT B"
  }
}

resource "aws_nat_gateway" "public_c" {
  allocation_id = aws_eip.public_c.id
  subnet_id     = aws_subnet.public_c.id

  depends_on = [
    aws_eip.public_c,
    aws_subnet.public_c
  ]

  tags = {
    Name = "Public NAT C"
  }
}