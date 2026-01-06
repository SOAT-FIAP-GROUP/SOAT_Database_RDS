# --- Security Groups ---
output "sg_rds_id" {
  value       = aws_security_group.rds.id
  description = "The ID of the RDS security group (inbound from EKS)"
}

output "sg_eks_id" {
  value       = aws_security_group.eks.id
  description = "The ID of the EKS security group (outbound to RDS)"
}

# --- DB Subnet Group ---
output "db_subnet_group_name" {
  value       = aws_db_subnet_group.mydb.name
  description = "The name of the DB subnet group"
}

output "db_subnet_group_id" {
  value       = aws_db_subnet_group.mydb.id
  description = "The ID of the DB subnet group"
}

# --- DB Instance Pedido ---
output "db_instance_id_pedido" {
  value       = aws_db_instance.mydb_pedido.id
  description = "The ID of the RDS DB instance"
}

output "db_instance_arn_pedido" {
  value       = aws_db_instance.mydb_pedido.arn
  description = "The ARN of the RDS DB instance"
}

output "db_instance_address_pedido" {
  value       = aws_db_instance.mydb_pedido.address
  description = "The DNS address of the RDS DB instance"
}

output "db_instance_endpoint_pedido" {
  value       = aws_db_instance.mydb_pedido.endpoint
  description = "The full connection endpoint (host:port) of the RDS DB instance"
}

output "db_instance_port_pedido" {
  value       = aws_db_instance.mydb_pedido.port
  description = "The port the RDS DB instance is listening on"
}

output "db_instance_username_pedido" {
  value       = aws_db_instance.mydb_pedido.username
  description = "The master username for the RDS DB instance"
  sensitive   = true
}

# --- DB Instance Produto ---
output "db_instance_id_produto" {
  value       = aws_db_instance.mydb_produto.id
  description = "The ID of the RDS DB instance"
}

output "db_instance_arn_produto" {
  value       = aws_db_instance.mydb_produto.arn
  description = "The ARN of the RDS DB instance"
}

output "db_instance_address_produto" {
  value       = aws_db_instance.mydb_produto.address
  description = "The DNS address of the RDS DB instance"
}

output "db_instance_endpoint_produto" {
  value       = aws_db_instance.mydb_produto.endpoint
  description = "The full connection endpoint (host:port) of the RDS DB instance"
}

output "db_instance_port_produto" {
  value       = aws_db_instance.mydb_produto.port
  description = "The port the RDS DB instance is listening on"
}

output "db_instance_username_produto" {
  value       = aws_db_instance.mydb_produto.username
  description = "The master username for the RDS DB instance"
  sensitive   = true
}
