# Database Systems Final Project

This is the repo for our group's project, which is a manager for a users' Spotify accounts.

Our group consists of:
* Thomas Cassidy
* Jack Nickerson
* Ian Douglas

When running code in the P5 directory, first create a virtual environment, and pip install the requirements.txt file. 
You need to also create a .env file containing the password for the mysql database. 
To use the API, first run "flask run" in the terminal, and then use postman accordingly.


dummy data for adding users, put in body of postman:
{
  "user_id": "12345",
  "email": "test@example.com",
  "display_name": "John Doe",
  "image_uri": "http://example.com/image.jpg",
  "product": "premium"
}

add this to header in postman:
Content-Type: application/json

