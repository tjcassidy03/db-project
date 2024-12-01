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
    
    return """<a href='/update-database-songs'>Update Database Songs</a></br>
        <a href='/users'>Users</a></br>
        <a href='/songs'>Songs</a></br>
        <a href='/playlists'>Playlists</a></br>
        <a href='/artists'>Artists</a></br>
        <a href='/album'>Album</a></br>"""


def process_track(track, me_id, headers, mycursor):
    song_sql = """INSERT INTO Song (track_id, track_name, duration_ms) 
                VALUES (%s, %s, %s) 
                ON DUPLICATE KEY UPDATE 
                track_name = VALUES(track_name),
                duration_ms = VALUES(duration_ms)"""
    user_songs_sql = """INSERT INTO user_songs (user_id, track_id) 
                VALUES (%s, %s) 
                ON DUPLICATE KEY UPDATE 
                user_id = VALUES(user_id),
                track_id = VALUES(track_id)"""
    album_sql = """INSERT INTO Album (album_id, album_name, art_uri, release_date, total_tracks) 
                VALUES (%s, %s, %s, %s, %s) 
                ON DUPLICATE KEY UPDATE
                album_name = VALUES(album_name),
                art_uri = VALUES(art_uri),
                release_date = VALUES(release_date),
                total_tracks = VALUES(total_tracks)"""
    album_songs_sql = """INSERT INTO album_songs (track_id, album_id) 
                VALUES (%s, %s) 
                ON DUPLICATE KEY UPDATE 
                track_id = VALUES(track_id),
                album_id = VALUES(album_id)"""
    song_artists_sql = """INSERT INTO song_artists (track_id, artist_id) 
                VALUES (%s, %s) 
                ON DUPLICATE KEY UPDATE 
                track_id = VALUES(track_id),
                artist_id = VALUES(artist_id)"""
    user_albums_sql = """INSERT INTO user_albums (user_id, album_id) 
                VALUES (%s, %s) 
                ON DUPLICATE KEY UPDATE 
                user_id = VALUES(user_id),
                album_id = VALUES(album_id)"""
    artist_sql = """INSERT INTO Artist (artist_id, artist_name, follower_count, artist_image_uri) 
                VALUES (%s, %s, %s, %s) 
                ON DUPLICATE KEY UPDATE
                artist_name = VALUES(artist_name),
                follower_count = VALUES(follower_count),
                artist_image_uri = VALUES(artist_image_uri)"""
    album_artists_sql = """INSERT INTO album_artists (album_id, artist_id) 
            VALUES (%s, %s) 
            ON DUPLICATE KEY UPDATE 
            album_id = VALUES(album_id),
            artist_id = VALUES(artist_id)"""
    
    if track:
        track_id = track.get('id')
        track_name = track.get('name')
        duration_ms = track.get('duration_ms')

        # Song table
        mycursor.execute(song_sql, (track_id, track_name, duration_ms))
        # user_songs table
        mycursor.execute(user_songs_sql, (me_id, track_id))

        album = track.get('album', {})
        album_id = album.get('id')
        album_name = album.get('name')
        album_images = album.get('images', [])
        album_image_uri = album_images[0]['url'] if album_images else None
        release_date = album.get('release_date')
        total_tracks = album.get('total_tracks')

        # Album table
        mycursor.execute(album_sql, (album_id, album_name, album_image_uri, release_date, total_tracks))
        # album_songs table
        mycursor.execute(album_songs_sql, (track_id, album_id))
        # user_albums table
        mycursor.execute(user_albums_sql, (me_id, album_id))

        artists = album.get('artists', [])
        for artist in artists:
            response = requests.get(artist.get('href'), headers=headers)
            artist = response.json()
            artist_images = artist.get('images', [])
            artist_image_uri = artist_images[0]['url'] if artist_images else None
            artist_id = artist.get('id')
            artist_name = artist.get('name')
            followers = artist.get('followers', {})
            follower_count = followers.get('total') if followers else None

            # Artist table
            mycursor.execute(artist_sql, (artist_id, artist_name, follower_count, artist_image_uri))
            # album_artists table
            mycursor.execute(album_artists_sql, (album_id, artist_id))
            # song_artists table
            mycursor.execute(song_artists_sql, (track_id, artist_id))


@home_route.route("/update-database-songs")
def update_database_songs():
    if 'access_token' not in session:
        return redirect("/login")
    if datetime.now().timestamp() > session['expires_at']:
        return redirect("/refresh-token")

    headers = {
        'Authorization': f"Bearer {session['access_token']}"
    }

    # Spotify User API call
    response = requests.get("https://api.spotify.com/v1/me/", headers=headers)
    me = response.json()
    me_id = me.get('id')
    me_email = me.get('email')
    me_display_name = me.get('display_name')
    me_image = me.get('images', [])
    me_image_uri = me_image[0]['url'] if me_image else None
    me_product = me.get('product')
    user_sql = """INSERT INTO User (user_id, email, display_name, image_uri, product)
                VALUES (%s, %s, %s, %s, %s)
                ON DUPLICATE KEY UPDATE
                email = VALUES(email),
                display_name = VALUES(display_name),
                image_uri = VALUES(image_uri),
                product = VALUES(product)"""
    # User table
    mycursor.execute(user_sql, (me_id, me_email, me_display_name, me_image_uri, me_product))

    song_next_url = "https://api.spotify.com/v1/me/tracks?offset=0&limit=50"
    song_sql = """INSERT INTO Song (track_id, track_name, duration_ms) 
                VALUES (%s, %s, %s) 
                ON DUPLICATE KEY UPDATE 
                track_name = VALUES(track_name),
                duration_ms = VALUES(duration_ms)"""
    
    album_sql = """INSERT INTO Album (album_id, album_name, art_uri, release_date, total_tracks) 
                VALUES (%s, %s, %s, %s, %s) 
                ON DUPLICATE KEY UPDATE
                album_name = VALUES(album_name),
                art_uri = VALUES(art_uri),
                release_date = VALUES(release_date),
                total_tracks = VALUES(total_tracks)"""
    artist_sql = """INSERT INTO Artist (artist_id, artist_name, follower_count, artist_image_uri) 
                VALUES (%s, %s, %s, %s) 
                ON DUPLICATE KEY UPDATE
                artist_name = VALUES(artist_name),
                follower_count = VALUES(follower_count),
                artist_image_uri = VALUES(artist_image_uri)"""
    playlist_sql = """INSERT INTO Playlist (playlist_id, playlist_name, playlist_description, followers)
                VALUES (%s, %s, %s, %s)
                ON DUPLICATE KEY UPDATE
                playlist_name = VALUES(playlist_name),
                playlist_description = VALUES(playlist_description),
                followers = VALUES(followers)"""
    playlist_next_url = "https://api.spotify.com/v1/me/playlists?offset=0&limit=50"

    user_songs_sql = """INSERT INTO user_songs (user_id, track_id) 
                VALUES (%s, %s) 
                ON DUPLICATE KEY UPDATE 
                user_id = VALUES(user_id),
                track_id = VALUES(track_id)"""
    album_artists_sql = """INSERT INTO album_artists (album_id, artist_id) 
                VALUES (%s, %s) 
                ON DUPLICATE KEY UPDATE 
                album_id = VALUES(album_id),
                artist_id = VALUES(artist_id)"""
    album_songs_sql = """INSERT INTO album_songs (track_id, album_id) 
                VALUES (%s, %s) 
                ON DUPLICATE KEY UPDATE 
                track_id = VALUES(track_id),
                album_id = VALUES(album_id)"""
    playlist_images_sql = """INSERT INTO playlist_images (playlist_id, image_uri) 
                VALUES (%s, %s) 
                ON DUPLICATE KEY UPDATE 
                playlist_id = VALUES(playlist_id),
                image_uri = VALUES(image_uri)"""
    playlist_songs_sql = """INSERT INTO playlist_songs (playlist_id, track_id) 
                VALUES (%s, %s) 
                ON DUPLICATE KEY UPDATE 
                playlist_id = VALUES(playlist_id),
                track_id = VALUES(track_id)"""
    song_artists_sql = """INSERT INTO song_artists (track_id, artist_id) 
                VALUES (%s, %s) 
                ON DUPLICATE KEY UPDATE 
                track_id = VALUES(track_id),
                artist_id = VALUES(artist_id)"""
    user_albums_sql = """INSERT INTO user_albums (user_id, album_id) 
                VALUES (%s, %s) 
                ON DUPLICATE KEY UPDATE 
                user_id = VALUES(user_id),
                album_id = VALUES(album_id)"""
    user_playlist_sql = """INSERT INTO user_playlist (user_id, playlist_id) 
                VALUES (%s, %s) 
                ON DUPLICATE KEY UPDATE 
                user_id = VALUES(user_id),
                playlist_id = VALUES(playlist_id)"""

    while song_next_url:
        response = requests.get(song_next_url, headers=headers)
        tracks = response.json()
        for item in tracks.get('items', []):
            track = item.get('track', {})
            process_track(track, me_id, headers, mycursor)
        song_next_url = tracks.get('next')
    
    while playlist_next_url:
        response = requests.get(playlist_next_url, headers=headers)
        playlists = response.json()
        for item in playlists.get('items', []):
            response = requests.get(item.get('href'), headers=headers)
            playlist = response.json()
            playlist_id = playlist.get('id')
            playlist_name = playlist.get('name')
            playlist_description = playlist.get('description')
            playlist_followers = playlist.get('followers', {})
            playlist_follower_count = playlist_followers.get('total') if playlist_followers else None
            # Playlist table
            mycursor.execute(playlist_sql, (playlist_id, playlist_name, playlist_description, playlist_follower_count))
            # playlist_images table
            playlist_images = playlist.get('images', [])
            if playlist_images:
                for image in playlist_images:
                    mycursor.execute(playlist_images_sql, (playlist_id, image.get('url')))
            # playlist_songs table
            playlist_tracks = playlist.get('tracks', {})
            for item in playlist_tracks.get('items', []):
                track = item.get('track')
                process_track(track, me_id, headers, mycursor)
                mycursor.execute(playlist_songs_sql, (playlist_id, track.get('id')))
            # user_playlists table
            mycursor.execute(user_playlist_sql, (me_id, playlist_id))
        playlist_next_url = playlists.get('next')

    mydb.commit()
    return f"Changes were made to the database.<br><a href='/home'>Go Home</a>"


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