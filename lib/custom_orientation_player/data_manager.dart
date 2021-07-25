import 'dart:async';

import 'package:flick_video_player/flick_video_player.dart';
import 'package:video_player/video_player.dart';

class DataManager {
  DataManager({this.flickManager, this.urls});

  int currentPlaying = 0;
  final FlickManager flickManager;
  final String urls;

   Timer videoChangeTimer;

  cancelVideoAutoPlayTimer({bool playNext}) {
    if (playNext != true) {
      currentPlaying--;
    }

    flickManager.flickVideoManager
        ?.cancelVideoAutoPlayTimer(playNext: playNext);
  }
}
