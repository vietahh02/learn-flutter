import 'package:app_new/userMS/db/model/Music.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

abstract interface class MusicSource {
  Future<List<Music>?> getMusics();
}

class RemoteMusicSource implements MusicSource {
  @override
  Future<List<Music>?> getMusics() async {
    final response = await http.get(
      Uri.parse('https://thantrieu.com/resources/braniumapis/songs.json'),
    );
    if (response.statusCode == 200) {
      final String responseBody = utf8.decode(response.bodyBytes);
      // final List<dynamic> json = jsonDecode(responseBody);
      var songWrapper = jsonDecode(responseBody);
      var json = songWrapper['songs'] as List;
      return json.map((json) => Music.fromJson(json)).toList();
    }
    return null;
  }
}

class LocalMusicSource implements MusicSource {
  @override
  Future<List<Music>?> getMusics() async {
    final response = await rootBundle.loadString('assets/music.json');
    var songWrapper = jsonDecode(response) as Map;
    var json = songWrapper['songs'] as List<dynamic>;
    return json.map((json) => Music.fromJson(json)).toList();
  }
}