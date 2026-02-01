import 'package:app_new/userMS/db/model/Music.dart';
import 'package:app_new/userMS/ui/music/music_play/MusicBarManager.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class MusicPlayScreen extends StatefulWidget {
  final Music music;
  final List<Music> playlist;
  const MusicPlayScreen({
    super.key,
    required this.music,
    required this.playlist,
  });

  @override
  State<MusicPlayScreen> createState() => _MusicPlayScreenState();
}

class _MusicPlayScreenState extends State<MusicPlayScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late MusicBarManager _musicBarManager;
  late int _selectItemIndex;
  late Music _song;

  @override
  void initState() {
    super.initState();
    _song = widget.music;
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 10),
    );
    _musicBarManager = MusicBarManager();
    if (_musicBarManager.songUrl.compareTo(_song.source) != 0) {
      _musicBarManager.updateSongUrl(_song.source);
      _musicBarManager.init(isNewSong: true);
    } else {
      _musicBarManager.init();
    }
    _animationController.repeat();
    _selectItemIndex = widget.playlist.indexOf(_song);
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    const delta = 64;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text(_song.title)),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(_song.album),
              SizedBox(height: 16),
              RotationTransition(
                turns: Tween<double>(
                  begin: 0,
                  end: 1,
                ).animate(_animationController),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(
                    screenWidth / 2 - delta / 2,
                  ),
                  child: FadeInImage(
                    width: screenWidth - delta,
                    height: screenWidth - delta,
                    placeholder: AssetImage('assets/placeholder.jpg'),
                    image: NetworkImage(_song.image),
                    imageErrorBuilder: (context, error, stackTrace) =>
                        Image.asset(
                          'assets/placeholder.jpg',
                          width: screenWidth - delta,
                          height: screenWidth - delta,
                          fit: BoxFit.cover,
                        ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: 16),
              Text(_song.title),
              SizedBox(height: 16),
              Text(_song.artist),
              SizedBox(height: 16),
              Padding(
                padding: EdgeInsets.only(
                  left: 10,
                  right: 10,
                  top: 20,
                  bottom: 20,
                ),
                child: _progressBar(),
              ),
              SizedBox(height: 16),
              Padding(
                padding: EdgeInsets.only(
                  left: 10,
                  right: 10,
                  top: 20,
                  bottom: 20,
                ),
                child: _mediaControl(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  StreamBuilder<MusicDuration> _progressBar() {
    return StreamBuilder<MusicDuration>(
      stream: _musicBarManager.durationStream,
      builder: (context, snapshot) {
        final durationState = snapshot.data;
        final progress = durationState?.progress ?? Duration.zero;
        final buffered = durationState?.buffered ?? Duration.zero;
        final total = durationState?.total ?? Duration.zero;
        return ProgressBar(
          progress: progress,
          buffered: buffered,
          total: total,
          onSeek: (value) {
            _musicBarManager.player.seek(value);
          },
          barHeight: 2,
          baseBarColor: Colors.grey[200]!,
        );
      },
    );
  }

  StreamBuilder<PlayerState> _playPause() {
    return StreamBuilder<PlayerState>(
      stream: _musicBarManager.player.playerStateStream,
      builder: (context, snapshot) {
        final playerState = snapshot.data;
        final progressingState = playerState?.processingState;
        final playing = playerState?.playing;
        if (progressingState == ProcessingState.loading ||
            progressingState == ProcessingState.buffering) {
          return Container(
            margin: EdgeInsets.all(10),
            width: 48,
            height: 48,
            child: CircularProgressIndicator(
              color: Colors.blue,
              strokeWidth: 2,
            ),
          );
        } else if (playing != true) {
          return MediaButton(
            onPressed: () {
              _musicBarManager.player.play();
              _animationController.repeat();
            },
            icon: Icons.play_arrow,
            color: Colors.blue,
          );
        } else if (progressingState != ProcessingState.completed) {
          return MediaButton(
            onPressed: () {
              _musicBarManager.player.pause();
              _animationController.stop();
            },
            icon: Icons.pause,
            color: Colors.blue,
          );
        } else {
          if (progressingState == ProcessingState.completed) {
            _animationController.stop();
          }
          return MediaButton(
            onPressed: () {
              _musicBarManager.player.seek(Duration.zero);
              _animationController.repeat();
            },
            icon: Icons.replay,
            color: Colors.blue,
          );
        }
      },
    );
  }

  void _skipPrevious() {
    _selectItemIndex--;
    if (_selectItemIndex < 0) {
      _selectItemIndex = widget.playlist.length - 1;
    }
    final newSong = widget.playlist[_selectItemIndex];
    _musicBarManager.updateSongUrl(newSong.source);
    setState(() {
      _song = newSong;
    });
  }

  void _skipNext() {
    _selectItemIndex++;
    if (_selectItemIndex >= widget.playlist.length) {
      _selectItemIndex = 0;
    }
    final newSong = widget.playlist[_selectItemIndex];
    _musicBarManager.updateSongUrl(newSong.source);
    setState(() {
      _song = widget.playlist[_selectItemIndex];
    });
  }

  Widget _mediaControl() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        MediaButton(icon: Icons.skip_previous, onPressed: _skipPrevious),
         _playPause(),
        MediaButton(icon: Icons.skip_next, onPressed: _skipNext),
      ],
    );
  }
}

class MediaButton extends StatefulWidget {
  final IconData icon;
  final VoidCallback onPressed;
  final Color? color;
  final double? size;
  const MediaButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.color,
    this.size,
  });

  @override
  State<MediaButton> createState() => _MediaButtonState();
}

class _MediaButtonState extends State<MediaButton> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: widget.onPressed,
      icon: Icon(widget.icon, color: widget.color, size: widget.size),
    );
  }
}
