CREATE DATABASE Spotify_Project;

USE Spotify_Project;

CREATE TABLE `User` (
    user_id VARCHAR(50) NOT NULL,
    email VARCHAR(50),
    display_name VARCHAR(50),
    image_uri VARCHAR(200),
    product VARCHAR(50) NOT NULL,
    CONSTRAINT User_PK PRIMARY KEY (user_id)
);

CREATE TABLE Playlist (
    playlist_id VARCHAR(50) NOT NULL,
    playlist_name VARCHAR(100) NOT NULL,
    playlist_description VARCHAR(300),
    followers INT NOT NULL,
    CONSTRAINT Playlist_PK PRIMARY KEY (playlist_id),
    CONSTRAINT CK_Playlist_Followers CHECK (followers >= 0)
);

CREATE TABLE Album (
    album_id VARCHAR(50) NOT NULL,
    album_name VARCHAR(100) NOT NULL,
    art_uri VARCHAR(200) NOT NULL,
    release_date DATE NOT NULL,
    total_tracks INT NOT NULL,
    CONSTRAINT Album_PK PRIMARY KEY (album_id)
);

CREATE TABLE Song (
    track_id VARCHAR(50) NOT NULL,
    track_name VARCHAR(100) NOT NULL,
    duration_ms INT NOT NULL,
    CONSTRAINT Song_PK PRIMARY KEY (track_id),
    CONSTRAINT CK_Song_Duration CHECK (duration_ms > 0)
);

CREATE TABLE Artist (
    artist_id VARCHAR(50) NOT NULL,
    artist_name VARCHAR(100) NOT NULL,
    follower_count INT NOT NULL,
    artist_image_uri VARCHAR(200),
    CONSTRAINT Artist_PK PRIMARY KEY (artist_id)
);


CREATE TABLE user_playlist
(
    user_id VARCHAR(50) NOT NULL,
    playlist_id VARCHAR(50) NOT NULL,
    CONSTRAINT user_playlist_FK1 FOREIGN KEY (user_id)
    REFERENCES User(user_id) ON DELETE CASCADE,
    CONSTRAINT user_playlist_FK2 FOREIGN KEY (playlist_id)
    REFERENCES Playlist(playlist_id) ON DELETE CASCADE,
    CONSTRAINT user_playlist_PK PRIMARY KEY (user_id, playlist_id)
);

CREATE TABLE user_songs
(
    user_id VARCHAR(50) NOT NULL,
    track_id VARCHAR(50) NOT NULL,
    CONSTRAINT user_songs_FK1 FOREIGN KEY (user_id)
    REFERENCES User(user_id) ON DELETE CASCADE,
    CONSTRAINT user_songs_FK2 FOREIGN KEY (track_id)
    REFERENCES Song(track_id) ON DELETE CASCADE,
    CONSTRAINT user_songs_PK PRIMARY KEY (user_id, track_id)
);

CREATE TABLE user_albums
(
    user_id VARCHAR(50) NOT NULL,
    album_id VARCHAR(50) NOT NULL,
    CONSTRAINT user_albums_FK1 FOREIGN KEY (user_id)
    REFERENCES User(user_id) ON DELETE CASCADE,
    CONSTRAINT user_albums_FK2 FOREIGN KEY (album_id)
    REFERENCES Album(album_id) ON DELETE CASCADE,
    CONSTRAINT user_albums_PK PRIMARY KEY (user_id, album_id)
);

CREATE TABLE playlist_images
(
    playlist_id VARCHAR(50) NOT NULL,
    image_uri VARCHAR(200) NOT NULL,
    CONSTRAINT playlist_images_FK FOREIGN KEY (playlist_id)
    REFERENCES Playlist(playlist_id) ON DELETE CASCADE,
    CONSTRAINT playlist_images_PK PRIMARY KEY (playlist_id, image_uri)
);

CREATE TABLE playlist_songs
(
    playlist_id VARCHAR(50) NOT NULL,
    track_id VARCHAR(50),
    CONSTRAINT playlist_songs_FK1 FOREIGN KEY (playlist_id)
    REFERENCES Playlist(playlist_id) ON DELETE CASCADE,
    CONSTRAINT playlist_songs_FK2 FOREIGN KEY (track_id)
    REFERENCES Song(track_id) ON DELETE CASCADE,
    CONSTRAINT playlist_songs_PK PRIMARY KEY (playlist_id, track_id)
);

CREATE TABLE album_songs
(
    track_id VARCHAR(50) NOT NULL,
    album_id VARCHAR(50) NOT NULL,
    CONSTRAINT album_songs_FK1 FOREIGN KEY (track_id)
    REFERENCES Song(track_id) ON DELETE CASCADE,
    CONSTRAINT album_songs_FK2 FOREIGN KEY (album_id)
    REFERENCES Album(album_id) ON DELETE CASCADE,
    CONSTRAINT album_songs_PK PRIMARY KEY (album_id, track_id)
);

CREATE TABLE album_artists
(
    album_id VARCHAR(50) NOT NULL,  
    artist_id VARCHAR(50) NOT NULL,  
    CONSTRAINT album_artists_FK1 FOREIGN KEY (album_id)
    REFERENCES Album(album_id) ON DELETE CASCADE,
    CONSTRAINT album_artists_FK2 FOREIGN KEY (artist_id)
    REFERENCES Artist(artist_id) ON DELETE CASCADE,
    CONSTRAINT album_artists_PK PRIMARY KEY (artist_id, album_id)  
);

-- NOW DEPRECIATED IN SPOTIFY API
-- CREATE TABLE album_genres
-- (
--     album_id VARCHAR(50) NOT NULL,  
--     genre VARCHAR(100) NOT NULL,  
--     CONSTRAINT album_genres_FK FOREIGN KEY (album_id)
--     REFERENCES Album(album_id),
--     CONSTRAINT album_genres_PK PRIMARY KEY (album_id, genre)  
-- );

CREATE TABLE song_artists
(
    track_id VARCHAR(50) NOT NULL,  
    artist_id VARCHAR(50) NOT NULL,  
    CONSTRAINT song_artists_FK1 FOREIGN KEY (track_id)
    REFERENCES Song(track_id) ON DELETE CASCADE,
    CONSTRAINT song_artists_FK2 FOREIGN KEY (artist_id)
    REFERENCES Artist(artist_id) ON DELETE CASCADE,
    CONSTRAINT song_artists_PK PRIMARY KEY (track_id, artist_id) 
);