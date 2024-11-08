-- 1. Create 3 Stored Procedures :- For your project create three stored procedures and emphasize how or why they would be used
-- Procedure 1 : Add a Song to A Playlist
CREATE PROCEDURE AddPlaylistSong
  @playlist_id VARCHAR(50),
  @track_id VARCHAR(50)
AS
BEGIN
  INSERT INTO playlist_songs(playlist_id, track_id)
  VALUES (@playlist_id, @track_id);
END;

-- Procedure 2 : Adding an Album's songs to a Playlist
CREATE PROCEDURE AddPlaylistAlbum
  @playlist_id VARCHAR(50),
  @album_id VARCHAR(50)
AS
BEGIN
  INSERT INTO playlist_songs(playlist_id, track_id)
  VALUES (@playlist_id,
    (SELECT track_id
    FROM album_songs
    WHERE album_id = @album_id)); --CHECK THAT THIS WORKS
END;

-- Procedure 3 : Removing an artist's songs from a playlist
CREATE PROCEDURE ArtistPanicButton
  @playlist_id VARCHAR(50),
  @artist_id VARCHAR(50)
AS
BEGIN
  DELETE 
  FROM playlist_songs
  WHERE track_id IN (
    SELECT track_id 
    FROM song_artists
    WHERE artist_id = @artist_id
  )
END;


-- 2. Create 3 functions :- For your project create three functions and emphasize how or why they would be used
-- Function 1 : Sum a Playlist's songs' lengths
CREATE FUNCTION PlaylistLength (@playlist_id INT)
RETURNS INT
AS
BEGIN
  DECLARE @lengthSum INT;
  
  SELECT @lengthSum = SUM(duration_ms)
  FROM playlist_songs P
  INNER JOIN Song S ON P.track_id = S.track_id
  WHERE P.playlist_id = @playlist_id;
  
  RETURN @lengthSum;
END;
GO
  
-- Function 2 : Count an artist's published songs 
CREATE FUNCTION SongCount (@artist_id INT)
RETURNS INT
AS
BEGIN
  DECLARE @count INT;
  SELECT @count = COUNT(track_id)
  FROM song_artists
  WHERE artist_id = @artist_id;
  RETURN @count;
END;
GO
  
-- Function 3 : Get an Album's total duration
CREATE FUNCTION AlbumLength (@album_id INT)
RETURNS INT
AS
BEGIN
  DECLARE @total_dur INT;
  SELECT @total_dur = SUM(S.duration_ms)
  FROM album_songs A
  INNER JOIN Song S ON A.track_id = S.track_id
  WHERE album_id = @album_id
  
  RETURN @total_dur;
END;


-- 3. Create 3 views :- For your project create three views for any 3 tables
-- View 1 : Show each User's Playlists, the number of songs, and their durations
CREATE VIEW UserPlaylistView AS
SELECT 
  user_id,
  playlist_name,
  playlist_description,
  (
    SELECT COUNT(*)
    FROM playlist_songs
    WHERE playlist_id = P.playlist_id
  ) AS playlist_song_count,
  Spotify_Project.PlaylistLength(P.playlist_id)
FROM user_playlist U
INNER JOIN [User] N ON U.user_id = N.user_id
INNER JOIN Playlist P ON U.playlist_id = P.playlist_id
GROUP BY [User], playlist_name;

-- View 2 : Show All Artists' Name, followers, image, song-count to viewer for browsing
CREATE VIEW UserArtistBrowse
SELECT
  artist_name,
  follower_count,
  artist_image_uri,
  (
    SELECT COUNT (*)
    FROM song_artists
    INNER JOIN Song ON song_artists.track_id = Song.track_id
  ) AS artist_song_count
FROM Artist;
-- View 3 : List all Genres, and Albums for each Genre
CREATE VIEW AlbumsInGenre AS
SELECT
  album_genres.genre as Genre
  Album.album_name as AlbumName
FROM
  album_genres
JOIN
  Album on album_genres.album_id = Album.album_id
ORDER BY
  album_genres.genre, Album.album_name;

-- 4. Create 1 Trigger :- For your project create one Trigger associated with any type of action between the referenced tables(primary-foreign key relationship tables)
-- Trigger to delete song from user_songs when it’s deleted from all playlists of a user
CREATE TRIGGER DeleteUserSongOnPlaylistRemoval
ON playlist_songs
AFTER DELETE
AS
BEGIN
    DELETE us
    FROM user_songs us
    JOIN deleted d ON us.track_id = d.track_id
    WHERE NOT EXISTS (
        SELECT 1
        FROM playlist_songs ps
        JOIN user_playlist up ON ps.playlist_id = up.playlist_id
        WHERE up.user_id = us.user_id
          AND ps.track_id = us.track_id
    );
END;


-- 5. Implement 1 Column Encryption :- For any 1 column in your table, implement the column encryption for security purposes


-- 6. Create 3 non-clustered indexes :- create 3 non-clustered indexes on your tables.
