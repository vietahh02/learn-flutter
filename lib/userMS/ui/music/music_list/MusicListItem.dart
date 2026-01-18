import 'package:app_new/userMS/db/model/Music.dart';
import 'package:flutter/material.dart';

class MusicListItem extends StatelessWidget {
  final Music music;
  const MusicListItem({super.key, required this.music});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(music.title),
          SizedBox(width: 16),
          Text(music.artist),
        ],
      ),
    );
  }
}
