resource "aws_eip" "public_a" {
  vpc = true

  tags = {
    Name = "Public EIP A"
  }

  depends_on = [
    aws_internet_gateway.gw
  ]
}

resource "aws_eip" "public_b" {
  vpc = true

  tags = {
    Name = "Public EIP B"
  }

  depends_on = [
    aws_internet_gateway.gw
  ]
}

resource "aws_eip" "public_c" {
  vpc = true

  tags = {
    Name = "Public EIP C"
  }

  depends_on = [
    aws_internet_gateway.gw
  ]
}