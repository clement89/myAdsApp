import 'package:flutter/material.dart';
import 'package:myads_app/UI/portraitScreen/watchPortraitScreen.dart';
import 'package:video_player/video_player.dart';

class DashboardVideo extends StatefulWidget {
  final String videoUrl, id, watchTime, productUrl;
  DashboardVideo({this.videoUrl, this.id, this.watchTime, this.productUrl});
  @override
  _DashboardVideoState createState() => _DashboardVideoState();
}

class _DashboardVideoState extends State<DashboardVideo> {
  VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(
      widget.videoUrl,
      videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true),
    );

    _controller.addListener(() {
      setState(() {});
    });
    _controller.setLooping(true);
    _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        Center(
          child: _controller.value.isInitialized
              ? AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: VideoPlayer(_controller),
                )
              : Container(
                  height: 200,
                  child: Center(child: CircularProgressIndicator()),
                ),
        ),
        Positioned(
          top: 100,
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => WatchPortrait(
                            videoUrl: widget.videoUrl,
                            VideoId: widget.id,
                            watchtime: widget.watchTime,
                            productUrl: widget.productUrl,
                          )));
            },
            child: Center(
              child: Icon(
                Icons.play_arrow,
                color: Colors.white,
                size: 50.0,
              ),
            ),
          ),
        ),
        // VideoProgressIndicator(_controller, allowScrubbing: true),
      ],
    );
  }
}
