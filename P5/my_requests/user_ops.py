from flask import Blueprint, request, jsonify
from models import User
from app import db

user_routes = Blueprint('user_routes', __name__)

@user_routes.route('/users', methods=['GET'])
def get_users():
    users = User.query.all()
    result = [{"user_id": user.user_id, "email": user.email} for user in users]
    return jsonify(result), 200

@user_routes.route('/users', methods=['POST'])
def create_user():
    data = request.get_json()
    if not data.get('user_id'):
        return jsonify({"error": "user_id is required"}), 400

    new_user = User(
        user_id=data['user_id'],
        email=data.get('email'),
        display_name=data.get('display_name'),
        image_uri=data.get('image_uri'),
        product=data.get('product')
    )
    db.session.add(new_user)
    db.session.commit()
    return jsonify({"message": "User created"}), 201


@user_routes.route('/users/<int:user_id>', methods=['PUT'])
def update_user(user_id):
    data = request.get_json()
    user = User.query.get(user_id)

    if not user:
        return jsonify({"error": "User not found"}), 404

    if 'email' in data:
        user.email = data['email']
    if 'display_name' in data:
        user.display_name = data['display_name']
    if 'image_uri' in data:
        user.image_uri = data['image_uri']
    if 'product' in data:
        user.product = data['product']

    db.session.commit()
    return jsonify({"message": "User updated successfully"}), 200

@user_routes.route('/users/<int:user_id>', methods=['DELETE'])
def delete_user(user_id):
    user = User.query.get(user_id)

    if not user:
        return jsonify({"error": "User not found"}), 404

    db.session.delete(user)
    db.session.commit()
    return jsonify({"message": "User deleted successfully"}), 200
