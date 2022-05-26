# Subnet
resource "aws_subnet" "subnet" {
  vpc_id                  = var.vpc_id
  cidr_block              = element(var.cidrs, count.index)
  availability_zone       = element(var.zones, count.index)
  count                   = length(var.cidrs)
  map_public_ip_on_launch = var.map_public_ip_on_launch

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Name         = "${var.name}.${element(var.zones, count.index)}.public"
    Environment  = var.env
    Provisioner  = "Terraform"
  }
}

# Routes
resource "aws_route_table" "rtb" {
  vpc_id           = var.vpc_id
  count            = length(var.cidrs)

  tags = {
    Name         = "${var.name}.${element(var.zones, count.index)}.public"
    Environment  = var.env
    Provisioner  = "Terraform"
  }
}

resource "aws_route_table_association" "rtba" {
  subnet_id      = element(aws_subnet.subnet.*.id, count.index)
  route_table_id = element(aws_route_table.rtb.*.id, count.index)
  count          = length(var.cidrs)

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_route" "igw" {
  route_table_id         = element(aws_route_table.rtb.*.id, count.index)
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = var.igw_id
  count                  = length(var.cidrs)

  depends_on = [
    aws_route_table.rtb,
  ]

  lifecycle {
    create_before_destroy = true
  }
}

