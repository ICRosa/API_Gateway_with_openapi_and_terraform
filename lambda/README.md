# Lambda :small_orange_diamond:

### Lambdas
The lambdas a received by a dictionary from main, then with a for each they are created using the function inside [task_orm.py](upload-lambda/tasks_orm.py) with the name corresponding to the dict key.

### Layer

 - One layer is created from a expected python file inside [SQLalchemy_AWSPsycopg2](SQLalchemy_AWSPsycopg2/). <b style='color:#f44040'> Unzip the [SQLalchemy_AWSPsycopg2.zip](SQLalchemy_AWSPsycopg2/SQLalchemy_AWSPsycopg2.zip) to expose the python file in this directory </b>

 - In case you prefer you can use pip install from [requirements-lambda.txt](requirements-lambda.txt)

### Create Table

There is a lambda invocation that runs with terraform apply and create the table.

### Cloudwatch

The role assigned to the lambdas allows them to log on cloudwatch, their log group name is "/aws/lambda/{Function_Name}"