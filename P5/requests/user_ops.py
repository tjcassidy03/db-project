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
