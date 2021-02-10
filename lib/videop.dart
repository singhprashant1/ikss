import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerr extends StatefulWidget {
  @override
  _VideoPlayerrState createState() => _VideoPlayerrState();
}

class _VideoPlayerrState extends State<VideoPlayerr> {
  VideoPlayerController _controller;
  int _playback = 0;
  // Future<void> _initializeVideoPlayerFuture;
  void _initplayer() async {
    _controller = VideoPlayerController.network(
        "http://www.sample-videos.com/video123/mp4/720/big_buck_bunny_720p_20mb.mp4");
    await _controller.initialize();
    _controller.setLooping(true);
    _controller.setVolume(1.0);
  }

  // int minute;
  @override
  void initState() {
    super.initState();
    _initplayer();
    _controller.addListener(() {
      setState(() {
        _playback = _controller.value.position.inSeconds;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Player"),
      ),
      body: _controller.value.initialized
          ? _playerWidget()
          : Center(child: CircularProgressIndicator()),
      // body: FutureBuilder(
      //   future: _initializeVideoPlayerFuture,
      //   builder: (context, snapshot) {
      //     if (snapshot.connectionState == ConnectionState.done) {
      //       return AspectRatio(
      //         aspectRatio: _controller.value.aspectRatio,
      //         child: _playerWidget(),
      //       );
      //     } else {
      //       return Center(
      //         child: CircularProgressIndicator(),
      //       );
      //     }
      //   },
      // ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        onPressed: () {
          setState(() {
            if (_controller.value.isPlaying) {
              _controller.pause();
            } else {
              _controller.play();
            }
          });
          var time = _controller.value.duration.inSeconds.toInt();
          // var minut = time / 60;
          int minut = (time / 60).truncate();
          print(minut);
          print(time);
          // print(_controller.value.position.inSeconds.toString());
        },
        child: Icon(
          _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget _playerWidget() {
    return Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AspectRatio(
            aspectRatio: _controller.value.aspectRatio,
            child: VideoPlayer(_controller),
          ),
          Slider(
            value: _playback.toDouble(),
            onChanged: (v) {
              _controller.seekTo(Duration(seconds: v.toInt()));
            },
            max: _controller.value.duration.inSeconds.toDouble(),
            min: 0,
          ),
        ]);
  }
}
