import 'package:app_new/userMS/db/model/Music.dart';
import 'package:app_new/userMS/ui/music/music_play/MusicPlayScreen.dart';
import 'package:flutter/material.dart';

class MusicListItem extends StatelessWidget {
  final Music music;
  final List<Music> playlist;
  const MusicListItem({super.key, required this.music, required this.playlist});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      // padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => MusicPlayScreen(music: music, playlist: playlist)));
        },
        contentPadding: EdgeInsets.only(left: 16, right: 0),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(Icons.play_arrow),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => MusicPlayScreen(music: music, playlist: playlist)));
              },
            ),
            IconButton(
              icon: Icon(Icons.more_vert),
              onPressed: () {
                showDialog(context: context, builder: (context) => AlertDialog(
                  title: Text('More'),
                  content: Text('Are you sure you want to more this music?'),
                  actions: [
                    TextButton(onPressed: () => Navigator.pop(context), child: Text('Cancel')),
                    TextButton(onPressed: () => Navigator.pop(context), child: Text('More')),
                  ],
                ));
              },
            ),
          ],
        ),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: FadeInImage(
            placeholder: AssetImage("assets/placeholder.jpg"),
            image: NetworkImage(music.image),
            width: 50,
            height: 50,
            fit: BoxFit.cover,
            imageErrorBuilder: (context, error, stackTrace) {
              return Image.asset('assets/placeholder.jpg', width: 50, height: 50, fit: BoxFit.cover,);
            }
          ),
        ),
        title: Text(music.title,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.grey.shade800),
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
        subtitle: Row(
          children: [
            Icon(Icons.music_video),
            SizedBox(width: 8),
            Expanded(
              child: Text(
                music.artist,
                style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              )
            )
          ],
        ),
      ),
    );
  }
}
