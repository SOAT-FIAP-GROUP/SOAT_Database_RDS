data "terraform_remote_state" "network" {
  backend = "s3"
  config = {
    bucket = local.bucket
    key    = "env:/${terraform.workspace}/network/terraform.tfstate"
    region = local.region
  }
}

data "aws_ssm_parameter" "db_username" {
  name = "SPRING_DATASOURCE_USERNAME"
}

data "aws_ssm_parameter" "db_password" {
  name = "SPRING_DATASOURCE_PASSWORD"
  with_decryption = true
}

resource "aws_security_group" "rds" {
  name        = "${local.local_names[0]}_inbound_rds_from_eks"
  description = "Allow MariaDB inbound traffic at RDS from EKS nodes"
  vpc_id      = data.terraform_remote_state.network.outputs.vpc_id
  tags        = local.tags
  depends_on = [data.terraform_remote_state.network]
}

resource "aws_security_group" "eks" {
  name        = "${local.local_names[0]}_outboud_eks_to_rds"
  description = "Allow MariaDB outbound traffic at EKS nodes to RDS"
  vpc_id      = data.terraform_remote_state.network.outputs.vpc_id
  tags        = local.tags
  depends_on = [data.terraform_remote_state.network]
}

resource "aws_db_subnet_group" "mydb" {
  name       = local.local_names[0]
  subnet_ids = data.terraform_remote_state.network.outputs.private_subnets
  tags       = local.tags
}

# PEDIDO DATABASE
resource "aws_db_instance" "mydb_pedido" {
  identifier             = local.local_names[1]
  instance_class         = "db.t3.micro"
  allocated_storage      = 5
  engine                 = "mariadb"
  username               = data.aws_ssm_parameter.db_username.value
  password               = data.aws_ssm_parameter.db_password.value
  db_subnet_group_name   = aws_db_subnet_group.mydb.name
  vpc_security_group_ids = [aws_security_group.rds.id]
  publicly_accessible    = false
  skip_final_snapshot    = true
  tags                   = local.tags
}


resource "aws_db_instance" "mydb_produto" {
  identifier             = local.local_names[2]
  instance_class         = "db.t3.micro"
  allocated_storage      = 5
  engine                 = "mariadb"
  username               = data.aws_ssm_parameter.db_username.value
  password               = data.aws_ssm_parameter.db_password.value
  db_subnet_group_name   = aws_db_subnet_group.mydb.name
  vpc_security_group_ids = [aws_security_group.rds.id]
  publicly_accessible    = false
  skip_final_snapshot    = true
  tags                   = local.tags
}


resource "aws_db_instance" "mydb_producao" {
  identifier             = local.local_names[3]
  instance_class         = "db.t3.micro"
  allocated_storage      = 5
  engine                 = "mariadb"
  username               = data.aws_ssm_parameter.db_username.value
  password               = data.aws_ssm_parameter.db_password.value
  db_subnet_group_name   = aws_db_subnet_group.mydb.name
  vpc_security_group_ids = [aws_security_group.rds.id]
  publicly_accessible    = false
  skip_final_snapshot    = true
  tags                   = local.tags
}

resource "aws_ssm_parameter" "rds_url_produto" {
  name  = "SPRING_DATASOURCE_URL_PRODUTO"
  type  = "String"
  value = aws_db_instance.mydb_produto.endpoint
}

resource "aws_ssm_parameter" "rds_url_pedido" {
  name  = "SPRING_DATASOURCE_URL_PEDIDO"
  type  = "String"
  value = aws_db_instance.mydb_pedido.endpoint
}

resource "aws_ssm_parameter" "rds_url_producao" {
  name  = "SPRING_DATASOURCE_URL_PRODUCAO"
  type  = "String"
  value = aws_db_instance.mydb_producao.endpoint
}