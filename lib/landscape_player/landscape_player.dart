import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myads_app/utils/mock_data.dart';
import 'package:video_player/video_player.dart';
import 'landscape_player_controls.dart';

class LandscapePlayer extends StatefulWidget {
  LandscapePlayer({Key key}) : super(key: key);

  @override
  _LandscapePlayerState createState() => _LandscapePlayerState();
}

class _LandscapePlayerState extends State<LandscapePlayer> {
  FlickManager flickManager;

  @override
  void initState() {
    super.initState();
    flickManager = FlickManager(
      // autoPlay: true,
        videoPlayerController:
        VideoPlayerController.network("https://www.sample-videos.com/video123/mp4/720/big_buck_bunny_720p_20mb.mp4"));
  }

  @override
  void dispose() {
    flickManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FlickVideoPlayer(
        flickManager: flickManager,
        preferredDeviceOrientation: [
          DeviceOrientation.landscapeRight,
          DeviceOrientation.landscapeLeft
        ],

        systemUIOverlay: [],
        flickVideoWithControls: FlickVideoWithControls(
          // controls: LandscapePlayerControls(),
        ),
      ),
    );
  }
}
