variable "iam_role_arn" {
  type = string
}

variable "db_host" {
  type = string
}

variable "db_port" {
  type = number
}

variable "db_user" {
  type = string
}

variable "db_pass" {
  type = string
}

variable "db_dbname" {
  type = string
}

variable "tasks" {
  type = map(map(any)) 
}
