from flask import Flask
from flask_sqlalchemy import SQLAlchemy
from dotenv import load_dotenv
import os

load_dotenv()

password = os.getenv('PASSWORD')

app = Flask(__name__)
app.config['SQLALCHEMY_DATABASE_URI'] = f'mysql+pymysql://root:{password}@localhost/spotify_project'

db = SQLAlchemy(app)

from requests.user_ops import user_routes
app.register_blueprint(user_routes)

if __name__ == "__main__":
    app.run(debug=True)
