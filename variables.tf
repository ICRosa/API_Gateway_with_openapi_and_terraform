
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

variable "access_key" {
  description = "AWS Acces_key"
}

variable "secret_key" {
  description = "AWS secret_key"
}