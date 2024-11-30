from flask import Blueprint, request, jsonify
from models import Playlist
from app import db

playlist_routes = Blueprint('playlist_routes', __name__)

playlist_routes.route('/playlists', methods=['GET'])
def get_playlists():
    playlists = Playlist.query.all()
    results = [{'playlist_id':playlist.playlist_id, 'playlist_name':playlist.playlist_name, 'playlist_description':playlist.playlist_description, 'followers': playlist.followers} for playlist in playlists]
    return jsonify(results), 200

playlist_routes.route('/playlists', methods=['POST'])
def create_playlist():
    data = request.get_json()
    if not data.get('playlist_id'):
        return jsonify({'error':'must input a playlist_id!'}), 400

    playlist = Playlist(
        playlist_id = data['playlist_id'],
        playlist_name = data.get('playlist_name'),
        playlist_description = data.get('playlist_description'),
        followers = data.get('followers')
    )

    db.session.add(playlist)
    db.session.commit()
    return jsonify({'message':'playlist created successfully!'}), 200

playlist_routes.route('/playlists/<int:playlist_id>', methods=['PUT'])
def update_playlist(playlist_id):
    data = request.get_json()
    playlist = data.query.get(playlist_id)

    if not playlist:
        return jsonify({'error':'playlist not found!'}), 404
    
    if 'playlist_id' in data:
        playlist.playlist_id = data['playlist_id']
    if 'playlist_name' in data:
        playlist.playlist_name = data['playlist_name']
    if 'playlist_description' in data:
        playlist.playlist_description = data['playlist_description']
    if 'followers' in data:
        playlist.followers = data['followers']
    db.session.commit()
    return jsonify({'message':'playlist updated successfully!'}), 200

playlist_routes.route('/playlists/<int:playlist_id>', method=['DELETE'])
def delete_playlist(playlist_id):
    data = request.get_json()
    playlist = data.query.get(playlist_id)

    if not playlist:
        return jsonify({'error':'playlist not found!'}), 404
    
    db.session.delete(playlist)
    db.session.commit()
    return jsonify({'message':'playlist deleted successfully!'}), 200