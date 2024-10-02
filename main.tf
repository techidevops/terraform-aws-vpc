resource "aws_vpc" "main" {
  cidr_block       = var.vpc_cidr
  enable_dns_hostnames = var.enable_dns_hostnames
  tags = merge(
    var.common_tags,
    var.vpc_tags,
    {
        Name = local.resource_name
    }
  )
}

# Internet Gateway
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = merge(
    var.common_tags,
    var.igw_tags,
    {
        Name = local.resource_name
    }
  )
}

# Public subnet creation

    resource "aws_subnet" "public" {
      count = length(var.public_subnet_cidrs)
      vpc_id     = aws_vpc.main.id
      cidr_block = var.public_subnet_cidrs[count.index]
      availability_zone = local.az_names[count.index]
      map_public_ip_on_launch = "true"
      tags = merge(
        var.common_tags,
        var.public_subnet_tags,
        {
            Name = "${local.resource_name}-public-${local.az_names[count.index]}"
        }
      )
    }

# Private Subnet creation

# Public subnet creation

    resource "aws_subnet" "private" {
      count = length(var.private_subnet_cidrs)
      vpc_id     = aws_vpc.main.id
      cidr_block = var.private_subnet_cidrs[count.index]
      availability_zone = local.az_names[count.index]
      tags = merge(
        var.common_tags,
        var.private_subnet_tags,
        {
            Name = "${local.resource_name}-private-${local.az_names[count.index]}"
        }
      )
    }

# Database subnet creation

    resource "aws_subnet" "database" {
      count = length(var.database_subnet_cidrs)
      vpc_id     = aws_vpc.main.id
      cidr_block = var.database_subnet_cidrs[count.index]
      availability_zone = local.az_names[count.index]
      tags = merge(
        var.common_tags,
        var.database_subnet_tags,
        {
            Name = "${local.resource_name}-database-${local.az_names[count.index]}"
        }
      )
    }

# DB Subnet group for RDS

resource "aws_db_subnet_group" "default" {
  name = local.resource_name
  subnet_ids = aws_subnet.database[*].id

  tags = merge(
    var.common_tags,
    var.db_subnet_group_tags,
    {
        Name = local.resource_name
    }
  )
}

# Elastic IP

resource "aws_eip" "nat" {
  domain = "vpc"
}

resource "aws_nat_gateway" "main" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public[0].id

  tags = merge(
    var.common_tags,
    var.nat_gateway_tags,
    {
        Name = local.resource_name
    }
  )

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.main]
}
