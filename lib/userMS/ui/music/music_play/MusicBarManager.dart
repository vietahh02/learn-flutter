import 'package:just_audio/just_audio.dart';
import 'package:rxdart/rxdart.dart';

class MusicBarManager {
  final player = AudioPlayer();
  Stream<MusicDuration>? durationStream;
  late String songUrl = '';

  MusicBarManager._internal();
  static final MusicBarManager _instance = MusicBarManager._internal();

  factory MusicBarManager() {
    return _instance;
  }

  void init({bool isNewSong = false}) {
    durationStream =
      Rx.combineLatest2<Duration, PlaybackEvent, MusicDuration>(
        player.positionStream,
        player.playbackEventStream,
        (position, event) => MusicDuration(
          progress: position,
          buffered: event.bufferedPosition,
          total: event.duration,
        ),
      );
    if (isNewSong) {
      player.setUrl(songUrl);
    }
  }

  void dispose() {
    player.dispose();
  }

  void updateSongUrl(String url) {
    songUrl = url;
    player.setUrl(songUrl);
  }
}

class MusicDuration {
  final Duration progress;
  final Duration buffered;
  final Duration? total;

  MusicDuration({
    required this.progress,
    required this.buffered,
    required this.total,
  });
}
