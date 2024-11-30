from flask import Blueprint, request, jsonify
from models import Song
from app import db

song_routes = Blueprint('song_routes', __name__)

@song_routes.route('songs/', methods=['GET'])
def get_songs():
    songs = Song.query.all()
    result = [{'track_id': song.song_id, 'track_name':song.track_name,'duration_ms':song.duration_ms} for song in songs]
    return jsonify(result), 200

@song_routes.route('songs/', methods=['POST'])
def create_song():
    data = request.get_json()
    if not data.get('track_id'):
        return jsonify({'error':'track_id required'} ), 400

    new_song = Song(
        track_id = data['track_id'],
        track_name = data.get('track_name'),
        duration_ms = data.get('duration_ms')
    )
    db.session.add(new_song)
    db.session.commit()
    return jsonify ({'message':'Song created Successfully!'}), 201

@song_routes.route('/user/<int:track_id>', methods=['PUT'])
def update_song(track_id):
    data = request.get_json()
    song = Song.query.get(track_id)

    if not song:
        return jsonify({'error' : 'song not found'}), 404
    
    if 'track_name' in data:
        song.track_name = data['track_name']
    if 'duration_ms' in data:
        song.duration_ms = data['duration_ms']
    
    db.session.commit()
    return jsonify ({'message' : 'Song updated Successfully!'}), 200

@song_routes.route('/user/<int:track_id>', methods=['DELETE'])
def delete_song(track_id):
    song = Song.query.get(track_id)

    if not song:
        return jsonify({'error':'song not found'}), 404
    
    db.session.delete(song)
    db.session.commit()
    return jsonify ({'message': 'Song deleted Successfully!'}), 200
    
