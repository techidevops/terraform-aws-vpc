# Terraform AWS VPC Module Customised

This module is going to create the following resoources. For HA we are going to get frist AZ

* VPC
* Internet Gateway associated with VPC
* 2 Public Subnets
* 2 Private Subnets
* 2 Database subnets
* EIP
* NAT Gateway
* Public Route table
* Private Route table
* Database route table
* Rotues
* Route table assosicate with subnets
* Peering with default VPC (if required)
* Perring routes in acceptor and requestor route table

# Inputs

* Project_name (Mandatory) : User supply their project name
* environemt (Manadatory) : User must supply enviroment name
* vpc_cidr (Mandatory) : User must supply their VPC CIDR
* eanble_dns_hostname (Optional) : default = true
* common_tags (Optional) : default is empty , user can suply in list(string) format
* vpc_tags (Optinal): default is empty , user can suply in list(string) fromat
* igw_tags (Optinal): default is empty , user can suply in list(string) fromat
* public_subnet_cidrs (manadotry) : User must supply 2 valid subnet CIDR.
* private_subnet_cidrs (manadotry) : User must supply 2 valid subnet CIDR.
* database_subnet_cidrs (manadotry) : User must supply 2 valid subnet CIDR.
* db_subnet_group_tags (optional): default is empty , user can suply in list(string) fromat.
* nat_gateway_tags (optional): default is empty , user can suply in list(string) fromat.
* public_route_table_tags (optional): default is empty , user can suply in list(string) fromat.
* private_route_table_tags (optional): default is empty , user can suply in list(string) fromat.
* database_route_table_tags (optional): default is empty , user can suply in list(string) fromat.
* vpc_peering_tags (optional): default is empty , user can suply in list(string) fromat.
* is_peering_required_tags (optional): default is empty , user can suply in list(string) fromat.


# Outputs

* vpc_id : VPC ID Created
* public_subnet_ids : list of 2 public subnet ids created
* private_subnet_ids : list of 2 private subnet ids created
* database_subnet_ids : list of 2 database subnet ids created



