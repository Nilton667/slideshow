import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:slideshow/controllers/home.controller.dart';
import 'package:video_player/video_player.dart';

Future<void> videoPlayer(String link) async {
  final c = Get.put(HomeController());
  c.videoController = VideoPlayerController.network(link);
  await Future.wait([c.videoController.initialize()]);

  c.chewieController = new ChewieController(
    videoPlayerController: c.videoController,
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
  c.update();
}

//Leitor de video
Widget chewie() {
  final c = Get.put(HomeController());
  return AspectRatio(
    aspectRatio: 16 / 9,
    child: Chewie(
      controller: c.chewieController as ChewieController,
    ),
  );
}

//Loading
Widget loading() {
  return Container(
    height: Get.height,
    width: Get.width,
    child: Center(
      child: CircularProgressIndicator(
        valueColor: new AlwaysStoppedAnimation<Color>(
          Colors.grey,
        ),
      ),
    ),
  );
}
