from flask import Flask
from flask_sqlalchemy import SQLAlchemy
from dotenv import load_dotenv
import os

load_dotenv()

password = os.getenv('DB_PASSWORD')
db_user = os.getenv('DB_USERNAME')
db = os.getenv('DB')
db_host = os.getenv('DB_HOST')

app = Flask(__name__)
app.config['SQLALCHEMY_DATABASE_URI'] = f'mysql+pymysql://{db_user}:{password}@{db_host}/{db}'

db = SQLAlchemy(app)

from my_requests.user_ops import user_routes
app.register_blueprint(user_routes)

from my_requests.artist_ops import artist_ops
app.register_blueprint(artist_ops)

from my_requests.album_ops import album_ops
app.register_blueprint(album_ops)

from my_requests.playlist_ops import playlist_ops
app.register_blueprint(playlist_ops)

from my_requests.song_ops import song_ops
app.register_blueprint(song_ops)

if __name__ == "__main__":
    app.run(debug=True)
