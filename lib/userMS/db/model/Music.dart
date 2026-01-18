class Music {
  final int id;
  final String title;
  final String album;
  final String artist;
  final String source;
  final String image;
  final int duration;

  factory Music.fromJson(Map<String, dynamic> json) {
    int idValue;
    if (json['id'] is String) {
      idValue = int.parse(json['id'] as String);
    } else {
      idValue = json['id'] as int;
    }
    
    return Music(
      id: idValue,
      title: json['title'] as String,
      album: json['album'] as String,
      artist: json['artist'] as String,
      source: json['source'] as String,
      image: json['image'] as String,
      duration: json['duration'] as int,
    );
  }

    @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Music && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;

  Music({
    required this.id,
    required this.title,
    required this.album,
    required this.artist,
    required this.source,
    required this.image,
    required this.duration,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'album': album,
      'artist': artist,
      'source': source,
      'image': image,
      'duration': duration,
    };
  }
}
