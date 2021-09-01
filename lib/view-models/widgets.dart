import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

Widget videoPlayer(String link) {
  final videoController = VideoPlayerController.network(link);
  Future.wait([videoController.initialize()]);

  final chewieController = ChewieController(
    videoPlayerController: videoController,
    showControls: false,
    autoPlay: true,
    looping: false,
    aspectRatio: 16 / 9,
    autoInitialize: true,
    errorBuilder: (context, errorMessage) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('Não foi possível reproduzir o vídeo!'),
        ),
      );
    },
  );
  videoController.play();
  return AspectRatio(
    aspectRatio: 16 / 9,
    child: Chewie(
      controller: chewieController,
    ),
  );
}
