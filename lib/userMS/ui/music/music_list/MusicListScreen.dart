import 'package:app_new/userMS/db/model/Music.dart';
import 'package:app_new/userMS/db/repository/MusicDatabaseHelper.dart';
import 'package:app_new/userMS/ui/music/music_list/MusicListItem.dart';
import 'package:flutter/material.dart';

class MusicListScreen extends StatefulWidget {
  const MusicListScreen({super.key});

  @override
  State<MusicListScreen> createState() => _MusicListScreenState();
}

class _MusicListScreenState extends State<MusicListScreen> {
  List<Music> musics = [];

  @override
  void initState() {
    _getMusics();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Music List')
        ),
        body: Center(
          child: getBody(),
        ),
      );
  }

  void _getMusics() async {
    musics = await LocalMusicDatabaseHelper().getMusics() ?? [];
    setState(() {});
  }

  Widget getBody() {
    return musics.isEmpty ? getProgressBar() : getMusicList();
  }

  Widget getProgressBar() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget getMusicList() {
    return ListView.builder(
      itemCount: musics.length,
      itemBuilder: (context, index) {
        return MusicListItem(music: musics[index]);
      },
    );
  }
}
