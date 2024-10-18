USE Spotify_Project
GO

-- User insert
INSERT INTO [User] (user_id, email, display_name, image_uri, product)
VALUES ('1', 'Edmund_Thistleton_87@example.com', 'Edmund_Thistleton_87', 'http://example.com/default_img.jpg', 'premium'),
  ('2', 'Agatha_Winthrop_23@example.com', 'Agatha_Winthrop_23', 'http://example.com/default_img.jpg', 'free'),
  ('3', 'Lavinia_Pembroke_45@example.com', 'Lavinia_Pembroke_45', 'http://example.com/default_img.jpg', 'premium'),
  ('4', 'Percival_Hargrove_16@example.com', 'Percival_Hargrove_16', 'http://example.com/default_img.jpg', 'free'),
  ('5', 'Isadora_Blackwood_32@example.com', 'Isadora_Blackwood_32', 'http://example.com/default_img.jpg', 'premium'),
  ('6', 'Archibald_Worthington_91@example.com', 'Archibald_Worthington_91', 'http://example.com/default_img.jpg', 'free'),
  ('7', 'Beatrice_Featherstone_58@example.com', 'Beatrice_Featherstone_58', 'http://example.com/default_img.jpg', 'premium'),
  ('8', 'Thaddeus_Wainwright_74@example.com', 'Thaddeus_Wainwright_74', 'http://example.com/default_img.jpg', 'free'),
  ('9', 'Henrietta_St._Clair_09@example.com', 'Henrietta_St._Clair_09', 'http://example.com/default_img.jpg', 'premium'),
  ('10', 'Reginald_Ashcombe_68@example.com', 'Reginald_Ashcombe_68', 'http://example.com/default_img.jpg', 'free'),
  ('11', 'Cordelia_Merriweather_30@example.com', 'Cordelia_Merriweather_30', 'http://example.com/default_img.jpg', 'premium'),
  ('12', 'Sebastian_Albright_12@example.com', 'Sebastian_Albright_12', 'http://example.com/default_img.jpg', 'free'),
  ('13', 'Ophelia_Harrington_56@example.com', 'Ophelia_Harrington_56', 'http://example.com/default_img.jpg', 'premium'),
  ('14', 'Mortimer_Lacey_83@example.com', 'Mortimer_Lacey_83', 'http://example.com/default_img.jpg', 'free'),
  ('15', 'Evangeline_Fairchild_27@example.com', 'Evangeline_Fairchild_27', 'http://example.com/default_img.jpg', 'premium'),
  ('16', 'Alistair_Ravenswood_04@example.com', 'Alistair_Ravenswood_04', 'http://example.com/default_img.jpg', 'free'),
  ('17', 'Genevieve_Fitzwilliam_69@example.com', 'Genevieve_Fitzwilliam_69', 'http://example.com/default_img.jpg', 'premium'),
  ('18', 'Horatio_Kingsley_21@example.com', 'Horatio_Kingsley_21', 'http://example.com/default_img.jpg', 'free'),
  ('19', 'Arabella_Pemberton_77@example.com', 'Arabella_Pemberton_77', 'http://example.com/default_img.jpg', 'premium'),
  ('20', 'Augustus_Thorne_55@example.com', 'Augustus_Thorne_55', 'http://example.com/default_img.jpg', 'free'),
  ('21', 'Seraphina_Lancaster_80@example.com', 'Seraphina_Lancaster_80', 'http://example.com/default_img.jpg', 'premium'),
  ('22', 'Maximilian_Brackenridge_19@example.com', 'Maximilian_Brackenridge_19', 'http://example.com/default_img.jpg', 'free'),
  ('23', 'Constance_Trelawney_38@example.com', 'Constance_Trelawney_38', 'http://example.com/default_img.jpg', 'premium'),
  ('24', 'Octavius_Featherstonehaugh_62@example.com', 'Octavius_Featherstonehaugh_62', 'http://example.com/default_img.jpg', 'free'),
  ('25', 'Winifred_Waverly_10@example.com', 'Winifred_Waverly_10', 'http://example.com/default_img.jpg', 'premium'),
  ('26', 'Morticia_Ravenscroft_42@example.com', 'Morticia_Ravenscroft_42', 'http://example.com/default_img.jpg', 'free'),
  ('27', 'Eustace_Whitmore_90@example.com', 'Eustace_Whitmore_90', 'http://example.com/default_img.jpg', 'premium'),
  ('28', 'Lucinda_Ashford_17@example.com', 'Lucinda_Ashford_17', 'http://example.com/default_img.jpg', 'free'),
  ('29', 'Phineas_Wroth_49@example.com', 'Phineas_Wroth_49', 'http://example.com/default_img.jpg', 'premium'),
  ('30', 'Clarissa_Eldridge_11@example.com', 'Clarissa_Eldridge_11', 'http://example.com/default_img.jpg', 'free');
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
