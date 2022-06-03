resource "aws_eip" "public_a" {
  vpc = true

  tags = {
    Name = "Public EIP A"
  }
}

resource "aws_eip" "public_b" {
  vpc = true

  tags = {
    Name = "Public EIP B"
  }
}

resource "aws_eip" "public_c" {
  vpc = true

  tags = {
    Name = "Public EIP C"
  }
}