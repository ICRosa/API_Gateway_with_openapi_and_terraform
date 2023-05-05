

module "iam" {
  source = "./iam"
}

module "lambda" {
  source = "./lambda"
  
  tasks = {
    add_task = {
     
      timeout = 80,
      memory_size = 128,
    
      },
    list_task = {
     
      timeout = 80,
      memory_size = 128,
    
      },
    get_task = {
     
      timeout = 80,
      memory_size = 128,
    
      },
    edit_task = {
     
      timeout = 80,
      memory_size = 128,
    
      },
    delete_task = {
     
      timeout = 80,
      memory_size = 128,
    
      },
    create_table = {}

  }
  iam_role_arn = module.iam.iam_role_arn
  db_host      = module.rds.db_endpoint
  db_port      = var.db_port
  db_user      = var.db_user
  db_pass      = var.db_pass
  db_dbname    = var.db_dbname
}

module "apigateway" {
  source = "./apigateway"

  lambda_addtask_invokearn    = module.lambda.arns["add_task"]
  lambda_listtask_invokearn   = module.lambda.arns["list_task"]
  lambda_gettask_invokearn    = module.lambda.arns["get_task"]
  lambda_edittask_invokearn   = module.lambda.arns["edit_task"]
  lambda_deletetask_invokearn = module.lambda.arns["delete_task"]

  lambda_names = module.lambda.lambda_names
}

module "rds" {
  source = "./rds"

  db_port   = var.db_port
  db_user   = var.db_user
  db_pass   = var.db_pass
  db_dbname = var.db_dbname
  db_engine = var.db_engine

}

