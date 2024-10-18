USE Spotify_Project
GO

-- User insert
INSERT INTO [User] (user_id, email, display_name, image_uri, product)
VALUES ('u_1', 'Edmund_Thistleton_87@example.com', 'Edmund_Thistleton_87', 'http://example.com/default_img.jpg', 'premium'),
  ('u_2', 'Agatha_Winthrop_23@example.com', 'Agatha_Winthrop_23', 'http://example.com/default_img.jpg', 'free'),
  ('u_3', 'Lavinia_Pembroke_45@example.com', 'Lavinia_Pembroke_45', 'http://example.com/default_img.jpg', 'premium'),
  ('u_4', 'Percival_Hargrove_16@example.com', 'Percival_Hargrove_16', 'http://example.com/default_img.jpg', 'free'),
  ('u_5', 'Isadora_Blackwood_32@example.com', 'Isadora_Blackwood_32', 'http://example.com/default_img.jpg', 'premium'),
  ('u_6', 'Archibald_Worthington_91@example.com', 'Archibald_Worthington_91', 'http://example.com/default_img.jpg', 'free'),
  ('u_7', 'Beatrice_Featherstone_58@example.com', 'Beatrice_Featherstone_58', 'http://example.com/default_img.jpg', 'premium'),
  ('u_8', 'Thaddeus_Wainwright_74@example.com', 'Thaddeus_Wainwright_74', 'http://example.com/default_img.jpg', 'free'),
  ('u_9', 'Henrietta_St._Clair_09@example.com', 'Henrietta_St._Clair_09', 'http://example.com/default_img.jpg', 'premium'),
  ('u_10', 'Reginald_Ashcombe_68@example.com', 'Reginald_Ashcombe_68', 'http://example.com/default_img.jpg', 'free'),
  ('u_11', 'Cordelia_Merriweather_30@example.com', 'Cordelia_Merriweather_30', 'http://example.com/default_img.jpg', 'premium'),
  ('u_12', 'Sebastian_Albright_12@example.com', 'Sebastian_Albright_12', 'http://example.com/default_img.jpg', 'free'),
  ('u_13', 'Ophelia_Harrington_56@example.com', 'Ophelia_Harrington_56', 'http://example.com/default_img.jpg', 'premium'),
  ('u_14', 'Mortimer_Lacey_83@example.com', 'Mortimer_Lacey_83', 'http://example.com/default_img.jpg', 'free'),
  ('u_15', 'Evangeline_Fairchild_27@example.com', 'Evangeline_Fairchild_27', 'http://example.com/default_img.jpg', 'premium'),
  ('u_16', 'Alistair_Ravenswood_04@example.com', 'Alistair_Ravenswood_04', 'http://example.com/default_img.jpg', 'free'),
  ('u_17', 'Genevieve_Fitzwilliam_69@example.com', 'Genevieve_Fitzwilliam_69', 'http://example.com/default_img.jpg', 'premium'),
  ('u_18', 'Horatio_Kingsley_21@example.com', 'Horatio_Kingsley_21', 'http://example.com/default_img.jpg', 'free'),
  ('u_19', 'Arabella_Pemberton_77@example.com', 'Arabella_Pemberton_77', 'http://example.com/default_img.jpg', 'premium'),
  ('u_20', 'Augustus_Thorne_55@example.com', 'Augustus_Thorne_55', 'http://example.com/default_img.jpg', 'free'),
  ('u_21', 'Seraphina_Lancaster_80@example.com', 'Seraphina_Lancaster_80', 'http://example.com/default_img.jpg', 'premium'),
  ('u_22', 'Maximilian_Brackenridge_19@example.com', 'Maximilian_Brackenridge_19', 'http://example.com/default_img.jpg', 'free'),
  ('u_23', 'Constance_Trelawney_38@example.com', 'Constance_Trelawney_38', 'http://example.com/default_img.jpg', 'premium'),
  ('u_24', 'Octavius_Featherstonehaugh_62@example.com', 'Octavius_Featherstonehaugh_62', 'http://example.com/default_img.jpg', 'free'),
  ('u_25', 'Winifred_Waverly_10@example.com', 'Winifred_Waverly_10', 'http://example.com/default_img.jpg', 'premium'),
  ('u_26', 'Morticia_Ravenscroft_42@example.com', 'Morticia_Ravenscroft_42', 'http://example.com/default_img.jpg', 'free'),
  ('u_27', 'Eustace_Whitmore_90@example.com', 'Eustace_Whitmore_90', 'http://example.com/default_img.jpg', 'premium'),
  ('u_28', 'Lucinda_Ashford_17@example.com', 'Lucinda_Ashford_17', 'http://example.com/default_img.jpg', 'free'),
  ('u_29', 'Phineas_Wroth_49@example.com', 'Phineas_Wroth_49', 'http://example.com/default_img.jpg', 'premium'),
  ('u_30', 'Clarissa_Eldridge_11@example.com', 'Clarissa_Eldridge_11', 'http://example.com/default_img.jpg', 'free');
-- Playlist insert
INSERT INTO Playlist (playlist_id, playlist_name, playlist_description, followers)
VALUES ('p_1', 'Chill Vibes', 'Chillin Like A Villain', 100),
  ('p_2', 'Feel Good Hits', 'Food for the Soul', 102),
  ('p_3', 'Study Beats', 'For focusing on assignments', 110),
  ('p_4', 'Road Trip Anthems', 'Beats to go', 210),
  ('p_5', 'Party Favorites', 'party mix for high energy', 4310),
  ('p_6', 'Morning Motivation', 'To get you moving', 1210),
  ('p_7', 'Acoustic Relaxation', 'To slow you down', 2398),
  ('p_8', 'Throwback Jams', 'To bring you back', 172),
  ('p_9', 'Late Night Grooves', 'To stay up late for', 1742),
  ('p_10', 'Upbeat Energy', 'To move to', 10),
  ('p_11', 'Indie Discoveries', 'No major record labels', 4832),
  ('p_12', 'Classic Rock Essentials', 'Old but gold', 4720),
  ('p_13', 'Love Songs', 'Valentines Day Hits', 2838),
  ('p_14', 'Weekend Getaway', 'When you want to leave it all behind', 3428),
  ('p_15', 'Instrumental Moods', 'To relax to', 493),
  ('p_16', 'Summer Sounds', 'To enjoy in the sun', 2109),
  ('p_17', 'Coffeehouse Classics', 'When you cant afford any more starbucks', 349),
  ('p_18', 'Mood Booster', 'To lift you up', 218),
  ('p_19', 'All-Time Favorites', 'Not sick of these yet', 32),
  ('p_20', 'Evening Chill', 'To mellow out', 218),
  ('p_21', 'Dance Party', 'To bring up the energy', 439),
  ('p_22', 'Nature Sounds', 'To sleep or relax to', 102),
  ('p_23', 'Happy Tunes', 'To bring your spirits up', 3298),
  ('p_24', 'Retro Revival', '90s kids rejoice', 491),
  ('p_25', 'New Releases', 'The Cutting Edge of music', 9082),
  ('p_26', 'Pop Perfection', 'Theyre top 40 for a reason', 913),
  ('p_27', 'Soulful Sundays', 'To bring your weekend spirits up', 2943),
  ('p_28', 'Heartfelt Ballads', 'To bring you to tears', 139),
  ('p_29', 'Eclectic Mix', 'No Description Necessary.', 4023),
  ('p_30', 'Feel-Good Favorites', 'Let the good times roll', 129);

-- Album insert
INSERT INTO Album (album_id, album_name, art_uri, release_date, total_tracks, popularity)
VALUES ('al_1', 'Echoes of Tomorrow', 'http://example.com/al1.jpg', '1990-01-01', 15, 1),
  ('al_2', 'Midnight Reflections', 'http://example.com/al2.jpg', '1991-02-02', 16, 2),
  ('al_3', 'Celestial Journeys', 'http://example.com/al3.jpg', '1992-03-03', 17, 3),
  ('al_4', 'Whispers in the Wind', 'http://example.com/al4.jpg', '1993-04-04', 18, 4),
  ('al_5', 'Urban Serenade', 'http://example.com/al5.jpg', '1994-05-05', 15, 5),
  ('al_6', 'Faded Dreams', 'http://example.com/al6.jpg', '1995-06-06', 16, 6),
  ('al_7', 'Shadows and Light', 'http://example.com/al7.jpg', '1996-07-07', 17, 7),
  ('al_8', 'Heartbeat Symphony', 'http://example.com/al8.jpg', '1997-08-08', 18, 8),
  ('al_9', 'Timeless Horizons', 'http://example.com/al9.jpg', '1998-09-09', 15, 9),
  ('al_10', 'Lost in Translation', 'http://example.com/al10.jpg', '1999-10-10', 16, 10),
  ('al_11', 'Wanderlust Melodies', 'http://example.com/al11.jpg', '2000-11-11', 17, 20),
  ('al_12', 'Secrets of the Sea', 'http://example.com/al12.jpg', '2001-12-12', 18, 21),
  ('al_13', 'Kaleidoscope Visions', 'http://example.com/al13.jpg', '2002-01-13', 15, 22),
  ('al_14', 'Electric Daydreams', 'http://example.com/al14.jpg', '2003-02-14', 16, 45),
  ('al_15', 'Portraits of Emotion', 'http://example.com/al15.jpg', '2004-03-15', 17, 46),
  ('al_16', 'Rhythm of the Night', 'http://example.com/al16.jpg', '2007-04-16', 18, 47),
  ('al_17', 'Through the Looking Glass', 'http://example.com/al17.jpg', '2008-05-17', 15, 48),
  ('al_18', 'Fragments of Time', 'http://example.com/al18.jpg', '2009-06-18', 16, 49),
  ('al_19', 'Nature’s Canvas', 'http://example.com/al19.jpg', '2010-07-19', 17, 65),
  ('al_20', 'Unwritten Chapters', 'http://example.com/al20.jpg', '2011-08-20', 18, 66),
  ('al_21', 'Celestial Echoes', 'http://example.com/al21.jpg', '2012-09-21', 15, 77),
  ('al_22', 'The Color of Sound', 'http://example.com/al22.jpg', '2013-10-22', 16, 78),
  ('al_23', 'Resonance of Souls', 'http://example.com/al23.jpg', '2014-11-23', 17, 29),
  ('al_24', 'Untamed Spirit', 'http://example.com/al24.jpg', '2015-12-24', 18, 79),
  ('al_25', 'Reflections of a Dreamer', 'http://example.com/al25.jpg', '2016-01-25', 15, 80),
  ('al_26', 'Harmony in Chaos', 'http://example.com/al26.jpg', '2017-02-26', 16, 81),
  ('al_27', 'A Journey Within', 'http://example.com/al27.jpg', '2018-03-27', 17, 82),
  ('al_28', 'Between the Lines', 'http://example.com/al28.jpg', '2019-04-28', 18, 83),
  ('al_29', 'Vintage Vibes', 'http://example.com/al29.jpg', '2022-05-29', 15, 84),
  ('al_30', 'The Art of Stillness', 'http://example.com/al30.jpg', '2024-06-30', 16, 85);

-- Song insert
INSERT INTO Song (track_id, track_name, duration_ms)
VALUES ('t_1', 'Kaleidoscope Skies', 240000),
  ('t_2', 'Midnight Carousel', 300000),
  ('t_3', 'Forgotten Whispers', 200000),
  ('t_4', 'Journey’s End', 180000),
  ('t_5', 'Secrets Unveiled', 120000),
  ('t_6', 'Hazy Reverie', 244000),
  ('t_7', 'Boundless Horizon', 241000),
  ('t_8', 'Starlit Path', 223000),
  ('t_9', 'Echoing Laughter', 298000),
  ('t_10', 'Rusted Memories', 192000),
  ('t_11', 'In the Silence', 241000),
  ('t_12', 'Veil of Dreams', 176000),
  ('t_13', 'Uncharted Waters', 160000),
  ('t_14', 'Fragments of Light', 192000),
  ('t_15', 'Labyrinth of Time', 158000),
  ('t_16', 'Shadowed Heart', 122000),
  ('t_17', 'Velvet Escape', 200000),
  ('t_18', 'Mending the Pieces', 123000),
  ('t_19', 'Dance of the Fireflies', 145000),
  ('t_20', 'Shattered Reflections', 156000),
  ('t_21', 'Infinite Horizons', 178000),
  ('t_22', 'Serpent’s Embrace', 198000),
  ('t_23', 'Solstice Melodies', 190000),
  ('t_24', 'Breathe in the Night', 132000),
  ('t_25', 'Painted Skies', 154000),
  ('t_26', 'Winding Roads', 165000),
  ('t_27', 'Flickering Embers', 176000),
  ('t_28', 'Chasing Rainbows', 198000),
  ('t_29', 'Untold Stories', 192000),
  ('t_30', 'Liquid Gold', 139000);

-- Artist insert
INSERT INTO Artist (artist_id, artist_name, follower_count, artist_image_uri)
VALUES ('ar_1', 'Velvet Echo', 1500000, 'http://example.com/ar1.jpg'),
  ('ar_2', 'Clara Sunshine', 2500000, 'http://example.com/ar2.jpg'),
  ('ar_3', 'Luna Storm', 3500000, 'http://example.com/ar3.jpg'),
  ('ar_4', 'Felix Nightingale', 4500000, 'http://example.com/ar4.jpg'),
  ('ar_5', 'Jasper & The Skylines', 50000000, 'http://example.com/ar5.jpg'),
  ('ar_6', 'Maya Rivers', 502340, 'http://example.com/ar6.jpg'),
  ('ar_7', 'Echo Drift', 503860, 'http://example.com/ar7.jpg'),
  ('ar_8', 'Leo Stone', 534220, 'http://example.com/ar8.jpg'),
  ('ar_9', 'Indigo Vibes', 504300, 'http://example.com/ar9.jpg'),
  ('ar_10', 'Ava Sky', 874000, 'http://example.com/ar10.jpg'),
  ('ar_11', 'Electric Maple', 157000, 'http://example.com/ar11.jpg'),
  ('ar_12', 'Max Ember', 224000, 'http://example.com/ar12.jpg'),
  ('ar_13', 'Cassette Dreams', 123000, 'http://example.com/ar13.jpg'),
  ('ar_14', 'Zoe Moon', 50, 'http://example.com/ar14.jpg'),
  ('ar_15', 'Willow & The Wildflowers', 1000, 'http://example.com/ar15.jpg'),
  ('ar_16', 'Sam Frost', 21000, 'http://example.com/ar16.jpg'),
  ('ar_17', 'The Dreamcatchers', 542000, 'http://example.com/ar17.jpg'),
  ('ar_18', 'Isla Wave', 12384, 'http://example.com/ar18.jpg'),
  ('ar_19', 'Ruby River', 129832, 'http://example.com/ar19.jpg'),
  ('ar_20', 'Jake Cloud', 4872, 'http://example.com/ar20.jpg'),
  ('ar_21', 'The Retro Spectrum', 52314, 'http://example.com/ar21.jpg'),
  ('ar_22', 'Mia Star', 32490, 'http://example.com/ar22.jpg'),
  ('ar_23', 'Ember & Ash', 328712, 'http://example.com/ar23.jpg'),
  ('ar_24', 'Ryan Woods', 12349, 'http://example.com/ar24.jpg'),
  ('ar_25', 'The Electric Ravens', 32167, 'http://example.com/ar25.jpg'),
  ('ar_26', 'Sophie Rain', 5498, 'http://example.com/ar26.jpg'),
  ('ar_27', 'The Starlit Ramblers', 1290, 'http://example.com/ar27.jpg'),
  ('ar_28', 'Oliver Field', 4329, 'http://example.com/ar28.jpg'),
  ('ar_29', 'Dusk Horizon', 12390, 'http://example.com/ar29.jpg'),
  ('ar_30', 'Ella Breeze', 32178, 'http://example.com/ar30.jpg');

-- user_playlist insert
INSERT INTO user_playlist (user_id, playlist_id)
VALUES ('user123', 'playlist456');

-- user_songs insert
INSERT INTO user_songs (user_id, track_id)
VALUES ('user123', 'track012');

-- user_albums insert
INSERT INTO user_albums (user_id, album_id)
VALUES ('user123', 'a');

-- playlist_images insert
INSERT INTO playlist_images (playlist_id, image_uri)
VALUES ('playlist456', 'http://example.com/playlist456_image1.jpg');

-- playlist_songs
INSERT INTO playlist_songs (playlist_id, track_id)
VALUES ('playlist456', 'track012');

-- album_songs
INSERT INTO album_songs (track_id, album_id)
VALUES ('track012', 'a');

-- album_artists
INSERT INTO album_artists (album_id, artist_id)
VALUES ('a', 'artist345');

-- album_genres
INSERT INTO album_genres (album_id, genre)
VALUES ('a', 'Rock');

-- song_artists
INSERT INTO song_artists (track_id, artist_id)
VALUES ('track012', 'artist345');
