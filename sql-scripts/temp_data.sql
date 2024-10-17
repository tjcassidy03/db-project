USE Spotify_Project
GO

-- User insert
INSERT INTO [User] (user_id, email, display_name, image_uri, product)
VALUES ('user123', 'user123@example.com', 'John Doe', 'http://example.com/image123.jpg', 'premium');

-- Playlist insert
INSERT INTO Playlist (playlist_id, playlist_name, playlist_description, followers)
VALUES ('playlist456', 'My Favorite Playlist', 'A collection of my favorite songs', 10);

-- Album insert
INSERT INTO Album (album_id, album_name, art_uri, release_date, total_tracks, popularity)
VALUES ('album789', 'Greatest Hits', 'http://example.com/album789.jpg', '2023-01-01', 15, 85);

-- Song insert
INSERT INTO Song (track_id, track_name, duration_ms)
VALUES ('track012', 'Hit Song', 240000);

-- Artist insert
INSERT INTO Artist (artist_id, artist_name, follower_count, artist_image_uri)
VALUES ('artist345', 'Famous Band', 500000, 'http://example.com/artist345.jpg');

-- user_playlist insert
INSERT INTO user_playlist (user_id, playlist_id)
VALUES ('user123', 'playlist456');

-- user_songs insert
INSERT INTO user_songs (user_id, track_id)
VALUES ('user123', 'track012');

-- user_albums insert
INSERT INTO user_albums (user_id, album_id)
VALUES ('user123', 'album789');

-- playlist_images insert
INSERT INTO playlist_images (playlist_id, image_uri)
VALUES ('playlist456', 'http://example.com/playlist456_image1.jpg');

-- playlist_songs
INSERT INTO playlist_songs (playlist_id, track_id)
VALUES ('playlist456', 'track012');

-- album_songs
INSERT INTO album_songs (track_id, album_id)
VALUES ('track012', 'album789');

-- album_artists
INSERT INTO album_artists (album_id, artist_id)
VALUES ('album789', 'artist345');

-- album_genres
INSERT INTO album_genres (album_id, genre)
VALUES ('album789', 'Rock');

-- song_artists
INSERT INTO song_artists (track_id, artist_id)
VALUES ('track012', 'artist345');
