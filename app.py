# Import the necessary modules
from flask import Flask, request, redirect, render_template, url_for
from flask_sqlalchemy import SQLAlchemy
import os
import datetime
import boto3

app = Flask(__name__)
version = "1.7.1"

user = os.environ.get("POSTGRES_USER")
# pw = os.environ.get("POSTGRES_PASSWORD")
pw = "kitskat2023"
host = os.environ.get("POSTGRES_HOST")
db_name = os.environ.get("POSTGRES_DATABASE_NAME")
DB_URL = f"postgresql+psycopg2://{user}:{pw}@{host}/{db_name}"

app.config["SQLALCHEMY_DATABASE_URI"] = DB_URL
app.config["SQLALCHEMY_TRACK_MODIFICATIONS"] = False

db = SQLAlchemy(app)

client = boto3.client(
    'ses', 
    region_name= os.environ.get("AWS_REGION_NAME"),
    aws_access_key_id = os.environ.get("AWS_ACCESS_NAME"),
    aws_secret_access_key = os.environ.get("AWS_KEY_NAME")
)

# client = boto3.client(
    
#     'ses',
#     region_name="eu-west-1",
#     aws_access_key_id="AKIARL2VXNIUVUTN5QRV",
#     aws_secret_access_key="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"
# )

class User(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    firstname = db.Column(db.String, unique=True, nullable=False)
    lastname = db.Column(db.String)
    email = db.Column(db.String)
    password = db.Column(db.String)
    city = db.Column(db.String)

# Place db.create_all() inside the if __name__ == '__main__': block
if __name__ == '__main__':
    with app.app_context():
        db.create_all()

@app.route('/')
def index():
    users = User.query.all()
    return render_template('index.html', users=users, gmt_dt=datetime.datetime.utcnow())

# ... (rest of your routes)

if __name__ == '__main__':
    app.run(debug=True)
