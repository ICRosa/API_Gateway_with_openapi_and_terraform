
# Free tier RDS
resource "aws_db_instance" "tasks" {
  identifier              = "tasks-db-toapi"
  allocated_storage       = 20
  engine                  = "postgres"
  engine_version          = "13.3"
  instance_class          = "db.t4g.micro"
  db_name                 = "tasks"
  username                = "postgres"
  password                = "12345678"
  publicly_accessible     = true
  skip_final_snapshot     = true
}

output "db_endpoint" {
  value = aws_db_instance.tasks.endpoint
}