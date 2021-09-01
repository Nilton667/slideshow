import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

Widget videoPlayerController(String link) {
  VideoPlayerController videoController = VideoPlayerController.network(link);
  videoController.initialize();

  ChewieController chewieController = ChewieController(
    videoPlayerController: videoController,
    showControls: false,
    autoPlay: true,
    looping: false,
    allowPlaybackSpeedChanging: false,
    aspectRatio: 16 / 9,
    errorBuilder: (context, errorMessage) {
      return Container(
        margin:
            const EdgeInsets.only(top: 8.0, left: 0.0, right: 0.0, bottom: 0.0),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('Video não encontrado!'),
        ),
      );
    },
  );
  return chewie(chewieController);
}

Widget chewie(controller) {
  if (controller != null) {
    return Chewie(
      controller: controller,
    );
  } else {
    return Center();
  }
}
