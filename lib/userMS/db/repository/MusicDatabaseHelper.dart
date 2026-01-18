import 'package:app_new/userMS/db/model/Music.dart';
import 'package:app_new/userMS/db/source/MusicSource.dart';

abstract interface class MusicDatabaseHelper {
  Future<List<Music>?> getMusics();
}

class LocalMusicDatabaseHelper implements MusicDatabaseHelper {
  final _localMusicSource = LocalMusicSource();
  final _remoteMusicSource = RemoteMusicSource();
  @override
  Future<List<Music>?> getMusics() async {
    List<Music> musics = [];

    await _remoteMusicSource.getMusics().then((value) {
      if (value != null) {
        musics.addAll(value);
      }else {
        _localMusicSource.getMusics().then((value) {
          if (value != null) {
            musics.addAll(value);
          }
        });
      }
    });
    return musics;
  }
}
