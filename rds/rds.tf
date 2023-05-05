variable "db_port" {
  description = "Database port"
  type        = number
  default     = 5432
}

variable "db_user" {
  description = "Database user"
  type        = string
  default     = "postgres"
}

variable "db_pass" {
  description = "Database password"
  type        = string
  default     = "12345678"
}

variable "db_dbname" {
  description = "Database database name"
  type        = string
  default     = "postgres"
}

variable "db_engine" {
  description = " database engine"
  type        = string
  default     = "postgres"
}

# Free tier RDS
resource "aws_db_instance" "tasks" {
  identifier              = "tasks-db-toapi"
  allocated_storage       = 20
  engine                  = var.db_engine
  engine_version          = "13.3"
  instance_class          = "db.t4g.micro"
  db_name                 = var.db_dbname
  username                = var.db_user
  password                = var.db_pass
  port                    = var.db_port
  publicly_accessible     = true
  skip_final_snapshot     = true
}

output "db_endpoint" {
  value = aws_db_instance.tasks.endpoint
}