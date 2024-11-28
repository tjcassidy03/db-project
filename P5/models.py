from app import db

class User(db.Model):
    __tablename__ = 'User'
    user_id = db.Column(db.String(50), primary_key=True)
    email = db.Column(db.String(50))
    display_name = db.Column(db.String(50))
    image_uri = db.Column(db.String(50))
    product = db.Column(db.String(50), nullable=False)

    playlists = db.relationship('Playlist', secondary='user_playlist', backref='users')
    songs = db.relationship('Song', secondary='user_songs', backref='users')
    albums = db.relationship('Album', secondary='user_albums', backref='users')


class Playlist(db.Model):
    __tablename__ = 'Playlist'
    playlist_id = db.Column(db.String(50), primary_key=True)
    playlist_name = db.Column(db.String(100), nullable=False)
    playlist_description = db.Column(db.String(300))
    followers = db.Column(db.Integer, nullable=False, check_constraint='followers >= 0')

    songs = db.relationship('Song', secondary='playlist_songs', backref='playlists')
    images = db.relationship('PlaylistImage', backref='playlist', lazy=True)


class Album(db.Model):
    __tablename__ = 'Album'
    album_id = db.Column(db.String(50), primary_key=True)
    album_name = db.Column(db.String(100), nullable=False)
    art_uri = db.Column(db.String(50), nullable=False)
    release_date = db.Column(db.Date, nullable=False)
    total_tracks = db.Column(db.Integer, nullable=False)
    popularity = db.Column(db.Integer, nullable=False, check_constraint='popularity BETWEEN 0 AND 100')

    songs = db.relationship('Song', secondary='album_songs', backref='albums')
    artists = db.relationship('Artist', secondary='album_artists', backref='albums')


class Song(db.Model):
    __tablename__ = 'Song'
    track_id = db.Column(db.String(50), primary_key=True)
    track_name = db.Column(db.String(100), nullable=False)
    duration_ms = db.Column(db.Integer, nullable=False, check_constraint='duration_ms > 0')

    artists = db.relationship('Artist', secondary='song_artists', backref='songs')


class Artist(db.Model):
    __tablename__ = 'Artist'
    artist_id = db.Column(db.String(50), primary_key=True)
    artist_name = db.Column(db.String(100), nullable=False)
    follower_count = db.Column(db.Integer, nullable=False)
    artist_image_uri = db.Column(db.String(50))


class UserPlaylist(db.Model):
    __tablename__ = 'user_playlist'
    user_id = db.Column(db.String(50), db.ForeignKey('User.user_id'), primary_key=True)
    playlist_id = db.Column(db.String(50), db.ForeignKey('Playlist.playlist_id'), primary_key=True)


class UserSongs(db.Model):
    __tablename__ = 'user_songs'
    user_id = db.Column(db.String(50), db.ForeignKey('User.user_id'), primary_key=True)
    track_id = db.Column(db.String(50), db.ForeignKey('Song.track_id'), primary_key=True)


class UserAlbums(db.Model):
    __tablename__ = 'user_albums'
    user_id = db.Column(db.String(50), db.ForeignKey('User.user_id'), primary_key=True)
    album_id = db.Column(db.String(50), db.ForeignKey('Album.album_id'), primary_key=True)


class PlaylistSongs(db.Model):
    __tablename__ = 'playlist_songs'
    playlist_id = db.Column(db.String(50), db.ForeignKey('Playlist.playlist_id'), primary_key=True)
    track_id = db.Column(db.String(50), db.ForeignKey('Song.track_id'), primary_key=True)


class PlaylistImage(db.Model):
    __tablename__ = 'playlist_images'
    playlist_id = db.Column(db.String(50), db.ForeignKey('Playlist.playlist_id'), primary_key=True)
    image_uri = db.Column(db.String(50), primary_key=True)


class AlbumSongs(db.Model):
    __tablename__ = 'album_songs'
    track_id = db.Column(db.String(50), db.ForeignKey('Song.track_id'), primary_key=True)
    album_id = db.Column(db.String(50), db.ForeignKey('Album.album_id'), primary_key=True)


class AlbumArtists(db.Model):
    __tablename__ = 'album_artists'
    album_id = db.Column(db.String(50), db.ForeignKey('Album.album_id'), primary_key=True)
    artist_id = db.Column(db.String(50), db.ForeignKey('Artist.artist_id'), primary_key=True)


class AlbumGenres(db.Model):
    __tablename__ = 'album_genres'
    album_id = db.Column(db.String(50), db.ForeignKey('Album.album_id'), primary_key=True)
    genre = db.Column(db.String(100), primary_key=True)


class SongArtists(db.Model):
    __tablename__ = 'song_artists'
    track_id = db.Column(db.String(50), db.ForeignKey('Song.track_id'), primary_key=True)
    artist_id = db.Column(db.String(50), db.ForeignKey('Artist.artist_id'), primary_key=True)
