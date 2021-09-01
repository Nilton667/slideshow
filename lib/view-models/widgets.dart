import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

Widget videoPlayerController(String link) {
  final VideoPlayerController videoController =
      VideoPlayerController.network(link);
  videoController.initialize();

  ChewieController chewieController = ChewieController(
    videoPlayerController: videoController,
    showControls: false,
    autoPlay: true,
    looping: false,
    allowPlaybackSpeedChanging: false,
    aspectRatio: 16 / 9,
    errorBuilder: (context, errorMessage) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('Não foi possível reproduzir o vídeo!'),
        ),
      );
    },
  );
  videoController.dispose();
  return Chewie(
    controller: chewieController,
  );
}
