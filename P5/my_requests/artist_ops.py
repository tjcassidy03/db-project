from flask import Blueprint, request, jsonify
from models import Artist
from app import db

artist_routes = Blueprint('artist_routes', __name__)

@artist_routes.route('/artists', methods=['GET'])
def get_artists():
    artists = Artist.query.all()
    result = [{'artist_id':artist.artist_id, 'artist_name':artist.artist_name, 'follower_count':artist.follower_count, 'artist_image_uri':artist.artist_image_uri} for artist in artists]
    return jsonify(result), 200

@artist_routes.route('/artists', methods=['POST'])
def create_artist():
    data = request.get_json()
    if not data.get('artist_id'):
        return jsonify({'error': 'Need artist_id!'})
    
    new_artist = Artist(
        artist_id = data['artist_id'],
        artist_name = data.get('artist_name'),
        follower_count = data.get('follower_count'),
        artist_image_uri = data.get('artist_image_uri')
    )

    db.session.add(new_artist)
    db.session.commit()
    return jsonify({'message': 'artist created successfully!'}), 200

@artist_routes.route('/artists/<int:artist_id>', methods=['PUT'])
def update_artist(artist_id):
    data = request.get_json()
    artist = Artist.query.get(artist_id)
    if not artist:
        return jsonify({'error':'artist not found!'}), 404

    if 'artist_name' in data:
        artist.artist_name = data['artist_name']
    if 'follower_count' in data:
        artist.follower_count = data['follower_count']
    if 'artist_image_uri' in data:
        artist.artist_image_uri = data['artist_image_uri']

    db.session.commit()
    return jsonify({'message':'artist updated successfully!'}), 200

@artist_routes.route('/artists/<int:artist_id>', methods=['DELETE'])
def delete_artist(artist_id):
    artist = Artist.query.get(artist_id)
    if not artist:
        return jsonify({'error':'artist not found!'}), 404
    
    db.session.delete(artist)
    db.session.commit()
    return jsonify({'message':'artist successfully removed!'}), 200