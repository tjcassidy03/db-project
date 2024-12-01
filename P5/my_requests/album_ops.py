from flask import Blueprint, request, jsonify
from models import Album
from app import db

album_routes = Blueprint('album_routes', __name__)

@album_routes.route('/albums', methods=['GET'])
def get_albums():
    albums = Album.query.all()
    result = [{'album_id':album.album_id, 'album_name':album.album_name,'art_uri':album.art_uri,'release_date':album.release_date} for album in albums]
    return jsonify(result), 200

@album_routes.route('/albums', methods=['POST'])
def create_album():
    data = request.get_json()
    if not data.get('album_id'):
        return jsonify({'error':'album_id needed!'}), 400

    new_album = Album(
            album_id = data['album_id'],
            album_name = data.get('album_name'),
            art_uri = data.get('art_uri'),
            release_date = data.get('release_date'),
            total_tracks = data.get('total_tracks')
    )

    db.session.add(new_album)
    db.session.commit()
    return jsonify({'message':'album created successfully!'}), 201

@album_routes.route('/albums/<int:album_id>', methods=['PUT'])
def update_album(album_id):
    data = request.get_json()
    album = Album.query.get(album_id)
    if not album:
        return jsonify({'error':'album not found'}), 404
    
    if 'album_name' in data:
        album.album_name = data['album_name']
    if 'art_uri' in data:
        album.art_uri = data['art_uri']
    if 'release_date' in data:
        album.release_date = data['release_date']
    if 'total_tracks' in data:
        album.total_tracks = data['total_tracks']

    db.session.commit()
    return jsonify({'message':'album updated successfully!'}), 200

@album_routes.route('/albums/<int:album_id>', methods=['DELETE'])
def delete_album(album_id):
    album = Album.query.get(album_id)

    if not album:
        return jsonify({'error':'album not found'}), 404
    
    db.session.delete(album)
    db.session.commit()
    return jsonify({'message':'album deleted successfully!'}), 200
