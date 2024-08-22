import 'dart:math';

class Song {
  String title;
  String artist;
  int duration; // Duration in seconds

  Song(this.title, this.artist, this.duration);

  String get formattedDuration {
    int minutes = duration ~/ 60;
    int seconds = duration % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  String toString() {
    return '$title by $artist (${formattedDuration})';
  }
}

class Playlist {
  String name;
  List<Song> songs = [];

  Playlist(this.name);

  void addSong(Song song) {
    songs.add(song);
  }

  void removeSong(Song song) {
    songs.remove(song);
  }

  int get totalDuration {
    return songs.fold(0, (total, song) => total + song.duration);
  }

  void sortByArtist() {
    songs.sort((a, b) => a.artist.compareTo(b.artist));
  }

  @override
  String toString() {
    String playlistInfo = 'Playlist: $name\n';
    for (var song in songs) {
      playlistInfo += '$song\n';
    }
    return playlistInfo;
  }
}

class MusicFestival {
  String name;
  List<Playlist> playlists = [];

  MusicFestival(this.name);

  void addPlaylist(Playlist playlist) {
    playlists.add(playlist);
  }

  int get totalDuration {
    return playlists.fold(0, (total, playlist) => total + playlist.totalDuration);
  }

  Song? getRandomSongFromStage(String stageName) {
    var playlist = playlists.firstWhere((p) => p.name == stageName, orElse: () => Playlist('Empty'));
    if (playlist.songs.isNotEmpty) {
      var randomIndex = Random().nextInt(playlist.songs.length);
      return playlist.songs[randomIndex];
    }
    return null;
  }
}

void main() {
  print('Welcome to the Music Festival Playlist Manager!');

  // Creating Songs
  Song song1 = Song('Concrete', 'Poppy', 210);
  Song song2 = Song('BLOODMONEY', 'Poppy', 195); 
  Song song3 = Song('I Disagree', 'Poppy', 225); 
  Song song4 = Song('Anything Like Me', 'Poppy', 180); 
  Song song5 = Song('Fill the Crown', 'Poppy', 200); 
  Song song6 = Song('Sit/Stay', 'Poppy', 185); 
  Song song7 = Song('Bite Your Teeth', 'Poppy', 270); 

  // Creating Playlists
  Playlist mainStage = Playlist('Main Stage');
  mainStage.addSong(song1);
  mainStage.addSong(song2);
  mainStage.addSong(song3);
  mainStage.addSong(song4);
  mainStage.addSong(song5);

  Playlist indieStage = Playlist('Indie Stage');
  indieStage.addSong(song6);

  Playlist electronicStage = Playlist('Electronic Stage');
  electronicStage.addSong(song7);

  // Creating Music Festival
  MusicFestival festival = MusicFestival('My Music Festival');
  festival.addPlaylist(mainStage);
  festival.addPlaylist(indieStage);
  festival.addPlaylist(electronicStage);

  // Output the total duration of the festival
  print('Total Festival Duration: ${festival.totalDuration} seconds\n');

  // Output random songs from different stages
  print('Random Songs:');
  print('Main Stage: ${festival.getRandomSongFromStage('Main Stage') ?? "No songs available"}');
  print('Indie Stage: ${festival.getRandomSongFromStage('Indie Stage') ?? "No songs available"}');
  print('Electronic Stage: ${festival.getRandomSongFromStage('Electronic Stage') ?? "No songs available"}\n');

  // Sort Main Stage playlist by artist and output it
  mainStage.sortByArtist();
  print(mainStage);
}