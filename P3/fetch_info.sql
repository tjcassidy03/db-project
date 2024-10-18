USE Spotify_Project;
GO

-- 1. Query to fetch the number of playlists belonging to each user
SELECT [User].display_name, 
       (SELECT COUNT(user_playlist.playlist_id) 
        FROM user_playlist 
        WHERE user_playlist.user_id = [User].user_id) AS playlist_count
FROM [User];

-- -- 2. Query to fetch the number of songs in each users' playlists
SELECT [User].display_name, 
       Playlist.playlist_name, 
       (SELECT AVG(Song.duration_ms)
        FROM playlist_songs
        JOIN Song ON playlist_songs.track_id = Song.track_id
        WHERE playlist_songs.playlist_id = Playlist.playlist_id) AS avg_duration
FROM user_playlist
JOIN Playlist ON user_playlist.playlist_id = Playlist.playlist_id
JOIN [User] ON user_playlist.user_id = [User].user_id;


-- -- 3. Query to see the most common artist in user playlists
SELECT TOP 1 Artist.artist_name, COUNT(song_artists.artist_id) AS artist_frequency
FROM user_playlist
JOIN playlist_songs ON user_playlist.playlist_id = playlist_songs.playlist_id
JOIN song_artists ON playlist_songs.track_id = song_artists.track_id
JOIN Artist ON song_artists.artist_id = Artist.artist_id
GROUP BY song_artists.artist_id, Artist.artist_name
ORDER BY artist_frequency DESC;

-- -- 4. Query to see most common genre for albums
SELECT TOP 1 album_genres.genre, COUNT(album_genres.genre) AS genre_count
FROM user_albums
JOIN album_genres ON user_albums.album_id = album_genres.album_id
GROUP BY album_genres.genre
ORDER BY genre_count DESC;

-- -- -- 5. Query to get the average duration of songs in users' playlists
SELECT [User].display_name, Playlist.playlist_name, AVG(Song.duration_ms) AS avg_duration
FROM user_playlist
JOIN playlist_songs ON user_playlist.playlist_id = playlist_songs.playlist_id
JOIN [User] ON user_playlist.user_id = [User].user_id
JOIN Song ON playlist_songs.track_id = Song.track_id
JOIN Playlist ON user_playlist.playlist_id = Playlist.playlist_id
GROUP BY [User].display_name, Playlist.playlist_name;

-- -- -- 6. Query to get the average popularity of albums saved by users
SELECT [User].display_name, AVG(Album.popularity) AS avg_popularity
FROM user_albums
JOIN Album ON user_albums.album_id = Album.album_id
JOIN [User] ON user_albums.user_id = [User].user_id
GROUP BY [User].display_name, user_albums.user_id;


-- -- -- 7. Query to get the most common artist for all user saved songs
SELECT TOP 1 Artist.artist_name, COUNT(song_artists.artist_id) AS artist_count
FROM user_songs
JOIN song_artists ON user_songs.track_id = song_artists.track_id
JOIN Artist ON song_artists.artist_id = Artist.artist_id
GROUP BY song_artists.artist_id, Artist.artist_name
ORDER BY artist_count DESC;

-- -- -- 8. Query to get average follower count of artists in a user playlist
SELECT [User].display_name, Playlist.playlist_name, AVG(Artist.follower_count) AS avg_follower_count
FROM user_playlist
JOIN playlist_songs ON user_playlist.playlist_id = playlist_songs.playlist_id
JOIN song_artists ON playlist_songs.track_id = song_artists.track_id
JOIN Artist ON song_artists.artist_id = Artist.artist_id
JOIN [User] ON user_playlist.user_id = [User].user_id
JOIN Playlist ON user_playlist.playlist_id = Playlist.playlist_id
GROUP BY [User].display_name, Playlist.playlist_name;


-- -- -- 9. Query to get most popular artist, by follower count, in a user playlist
SELECT TOP 1 Playlist.playlist_name, Artist.artist_name, MAX(Artist.follower_count) AS max_follower_count
FROM user_playlist
JOIN playlist_songs ON user_playlist.playlist_id = playlist_songs.playlist_id
JOIN song_artists ON playlist_songs.track_id = song_artists.track_id
JOIN Artist ON song_artists.artist_id = Artist.artist_id
JOIN Playlist ON user_playlist.playlist_id = Playlist.playlist_id
GROUP BY Playlist.playlist_name, Artist.artist_name;

-- -- -- 10. Query to get least popular artist, by follower count, in a user playlist
SELECT TOP 1 Playlist.playlist_name, Artist.artist_name, MIN(Artist.follower_count) AS min_follower_count
FROM user_playlist
JOIN playlist_songs ON user_playlist.playlist_id = playlist_songs.playlist_id
JOIN song_artists ON playlist_songs.track_id = song_artists.track_id
JOIN Artist ON song_artists.artist_id = Artist.artist_id
JOIN Playlist ON user_playlist.playlist_id = Playlist.playlist_id
GROUP BY Playlist.playlist_name, Artist.artist_name;
