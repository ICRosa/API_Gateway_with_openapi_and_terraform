
variable "pg_port" {
  description = "PostgreSQL port"
  type        = number
  default     = 5432
}

variable "pg_user" {
  description = "PostgreSQL user"
  type        = string
  default     = "postgres"
}

variable "pg_pass" {
  description = "PostgresSQL password"
  type        = string
  default     = "12345678"
}

variable "pg_dbname" {
  description = "PostgreSQL database name"
  type        = string
  default     = "postgres"
}

variable "access_key" {
  description = "AWS Acces_key"
}

variable "secret_key" {
  description = "AWS secret_key"
}