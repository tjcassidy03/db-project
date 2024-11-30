from flask import Blueprint, request, jsonify, redirect, session
import mysql.connector
from app import db
from dotenv import load_dotenv
import os
import urllib.parse
import requests
from datetime import datetime

load_dotenv()

CLIENT_ID = os.getenv("CLIENT_ID")
CLIENT_SECRET = os.getenv("CLIENT_SECRET")
REDIRECT_URI = 'http://127.0.0.1:5000/callback'
AUTH_URL = 'https://accounts.spotify.com/authorize'
TOKEN_URL = 'https://accounts.spotify.com/api/token'
API_BASE_URL = 'https://api.spotify.com/v1/'

db_password = os.getenv('DB_PASSWORD')
db_user = os.getenv('DB_USERNAME')
db = os.getenv('DB')
db_host = os.getenv('DB_HOST')

mydb = mysql.connector.connect (
    host = db_host,
    user = db_user,
    password = db_password,
    database = db
)

mycursor = mydb.cursor()

home_route = Blueprint('home_route', __name__)

@home_route.route('/')
def welcome():
    return "Welcome to my Spotify App <a href='/login'>Login with Spotify</a>"

@home_route.route('/login')
def login():
    scope = 'user-read-private user-read-email user-library-read'
    params = {
        'client_id': CLIENT_ID,
        'response_type': 'code',
        'scope': scope,
        'redirect_uri': REDIRECT_URI,
        'show_dialog': True
    }
    
    auth_url = f"{AUTH_URL}?{urllib.parse.urlencode(params)}"

    return redirect(auth_url)

@home_route.route('/callback')
def callback():
    if 'error' in request.args:
        return jsonify({"error": request.args['error']})
    
    if 'code' in request.args:
        req_body = {
            'code': request.args['code'],
            'grant_type': 'authorization_code',
            'redirect_uri': REDIRECT_URI,
            'client_id': CLIENT_ID,
            'client_secret': CLIENT_SECRET
        }

        response = requests.post(TOKEN_URL, data=req_body)
        token_info = response.json()

        session['access_token'] = token_info['access_token']
        session['refresh_token'] = token_info['refresh_token']
        session['expires_at'] = datetime.now().timestamp() + token_info['expires_in']
    
        return redirect("/home")
    
@home_route.route("/home")
def home():
    if 'access_token' not in session:
        return redirect("/login")
    
    if datetime.now().timestamp() > session['expires_at']:
        return redirect("/refresh-token")
    
    return "<a href='/update-database-songs'>Update Database Songs</a></br><a href='/users'>Users</a></br>"

@home_route.route("/update-database-songs")
def update_database_songs():
    if 'access_token' not in session:
        return redirect("/login")
    if datetime.now().timestamp() > session['expires_at']:
        return redirect("/refresh-token")
    
    headers = {
        'Authorization': f"Bearer {session['access_token']}"
    }

    next_url = "https://api.spotify.com/v1/me/tracks?offset=0&limit=50"
    song_sql = """INSERT INTO Song (track_id, track_name, duration_ms) 
    VALUES (%s, %s, %s) 
    ON DUPLICATE KEY UPDATE 
    track_name = VALUES(track_name),
    duration_ms = VALUES(duration_ms)"""
    val = []

    while next_url:
        response = requests.get(next_url, headers=headers)
        tracks = response.json()
        if "error" in tracks:
            return f"Error fetching tracks: {tracks['error']['message']}"
        for item in tracks.get('items', []):
            track = item.get('track', {})
            if track:
                track_id = track.get('id')
                track_name = track.get('name')
                duration_ms = track.get('duration_ms')
                if track_id and track_name and duration_ms is not None:
                    val.append((track_id, track_name, duration_ms))
        next_url = tracks.get('next')
        
    if val:
        mycursor.executemany(song_sql, val)
        mydb.commit()
        return f"{mycursor.rowcount} songs were inserted into the database.<br><a href='/home'>Go Home</a>"
    else:
        return "No songs to insert into the database.<br><a href='/home'>Go Home</a>"

@home_route.route("/refresh-token")
def refresh_token():
    if 'refresh_token' not in session:
        return redirect("/login")
    
    if datetime.now().timestamp() > session['expires_at']:
        req_body = {
            'grant_type': 'refresh_token',
            'refresh_token': session['refresh_token'],
            'client_id': CLIENT_ID,
            'client_secret': CLIENT_SECRET
        }
        
        response = requests.post(TOKEN_URL, data=req_body)
        new_token_info = response.json()

        session['access_token'] = new_token_info['access_token']
        session['expires_at'] = datetime.now().timestamp() + new_token_info['expires_in']

        return redirect('/home')