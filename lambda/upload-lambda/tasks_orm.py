import os
import json
import datetime
import sqlalchemy
from sqlalchemy.orm import sessionmaker
from sqlalchemy.ext.declarative import declarative_base
from typing import Optional
from uuid import UUID
from sqlalchemy.sql import text



# Configure the SQLAlchemy engine to connect to the RDS instance
engine = sqlalchemy.create_engine(os.getenv("db_DSN"))
Session = sessionmaker(bind=engine)
Base = declarative_base()


class Task(Base):
    __tablename__ = 'tasks'

    id = sqlalchemy.Column(sqlalchemy.String, primary_key=True, server_default=text("gen_random_uuid()"))
    task = sqlalchemy.Column(sqlalchemy.String(255), nullable=False)
    description = sqlalchemy.Column(sqlalchemy.String(255), nullable=False)
    done = sqlalchemy.Column(sqlalchemy.Boolean, nullable=False, default=False)
    made_on = sqlalchemy.Column(sqlalchemy.DateTime, nullable=False, default=datetime.datetime.utcnow)
    done_on = sqlalchemy.Column(sqlalchemy.DateTime, nullable=True)

    def to_dict(self):
        return {
            'id': str(self.id),
            'task': self.task,
            'description': self.description,
            'done': self.done,
            'made_on': self.made_on.strftime('%Y-%m-%dT%H:%M:%S.%f'),
            'done_on': (
                self.done_on.strftime('%Y-%m-%dT%H:%M:%S.%f')
                if self.done_on is not None else None
            )
        }
        
        
        
        
def create_table(event, context):        
    inspector = sqlalchemy.inspect(engine)
    try:
        table_names = inspector.get_table_names()
    except Exception as e:
        return f"Error: {e}"
        
    if 'tasks' in table_names:
        return "Table already exists"
        
    else:
        Base.metadata.create_all(bind=engine, checkfirst=True, tables=[Task.__table__])
        return "Table created successfully"

def add_task(event, context):

    #grants that there is a body to add
    try:
        data   = json.loads(event['body'])
    except:
        return {
        'statusCode': 400,
        'body': "Error while getting 'body' params, make sure you have passed the json formated params"
    }

    # Defines the body as the new row 
    session = Session()
    task = Task(
        task=data['task'],
        description=data['description'],
        done= True if data.get('done') else False,
        done_on=datetime.datetime.utcnow() if data.get('done') else None
    )
    session.add(task)


    # Commits
    session.commit()
    
    return {
        'statusCode': 201,
        'headers': {
            'Content-Type': 'application/json',
        },
        'body': json.dumps(task.to_dict()),
    }


def list_task(event, context):
    session = Session()
    try:
        tasks = session.query(Task).order_by(Task.made_on.asc()).all()
    except:
        return {
        'statusCode': 404,

        'body': "Table not found"
    }
    body = [task.to_dict() for task in tasks]

    return {
        'statusCode': 200,
        'headers': {
            'Content-Type': 'application/json',
        },
        'body': json.dumps(body),
    }



def get_task(event, context):
    session = Session()
    task = session.query(Task).get(event['pathParameters']['id'])
    print(task)
    if task is None:
        return {'statusCode': 404,
                'body': "id not found"}

    return {
        'statusCode': 200,
        'headers': {
            'Content-Type': 'application/json',
        },
        'body': json.dumps(task.to_dict()),
    }


def edit_task(event, context):
    try:
        data    = json.loads(event['body'])
    except:
        return {
        'statusCode': 400,
        'body': "Error while getting 'body' params, make sure you have passed the json formated params"
    }
        
    session = Session()
    task = session.query(Task).get(event['pathParameters']['id'])

    if task is None:
        return {'statusCode': 404,
                'body': "id not found"}
        
        
    for attribute, value in data.items():
        setattr(task, attribute, value)

        
    task.done_on = datetime.datetime.utcnow() if data.get('done') else None
    session.commit()
    
    return {
        'statusCode': 200,
        'headers': {
            'Content-Type': 'application/json',
        },
        'body': json.dumps(task.to_dict()),
    }

def delete_task(event, context):
    session = Session()
    task = session.query(Task).get(event['pathParameters']['id'])
    if task is None:
        return {'statusCode': 404,
                'body': "id not found"}
    session.delete(task)
    session.commit()
    
    return {'statusCode': 200}
