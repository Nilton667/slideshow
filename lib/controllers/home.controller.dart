import 'dart:async';
import 'dart:convert';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:flutter/animation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:chewie/chewie.dart';
import 'package:slideshow/view-models/widgets.dart';
import 'package:video_player/video_player.dart';

class HomeController extends GetxController {
  //Video Controller
  ChewieController? chewieController;
  late VideoPlayerController videoController;

  //Data
  List data = [];
  //Routs
  //static const host = 'http://10.0.2.2/slideshow/';
  //static const host = 'http://localhost/slideshow/';
  static const host = 'https://slideshow.rubro.ao/';
  CarouselController carouselController = new CarouselController();
  //Carousel setting
  int durationSlider = 0;
  int nextTime = 1;
  Timer? timer;
  //Loading page
  bool isLoading = true;

  //Get image and video
  Future getData() async {
    try {
      var res = await http.get(
        Uri.parse(host + "index.php"),
      );
      if (res.statusCode == 200) {
        var resBody = json.decode(res.body);
        if (resBody is List) {
          data = resBody;
          durationSlider = data[0]['duration'] is int
              ? data[0]['duration']
              : int.parse(
                  data[0]['duration'],
                );
          await checkTimer();
          Timer(
            Duration(seconds: durationSlider),
            () async {
              carouselController.nextPage(
                  duration: Duration(seconds: nextTime), curve: Curves.linear);
            },
          );
        }
      }
    } catch (e) {
      print(
        "Data error: " + e.toString(),
      );
    }
    isLoading = false;
    update();
  }

  //Event onPageChange
  void pageChange(int index, CarouselPageChangedReason reason) async {
    if ((chewieController?.isPlaying) != null &&
        chewieController?.isPlaying == true) {
      chewieController!.seekTo(Duration.zero);
      chewieController!.pause();
      update();
    }

    if (data.length > 0) {
      durationSlider = data[index]['duration'] is int
          ? data[index]['duration']
          : int.parse(
              data[index]['duration'],
            );
      await checkTimer();
      //Carregando o video
      if (data[index]['tipo'] == 'video') {
        await videoPlayer(
          HomeController.host + data[index]['nome'],
        );
      }
      timer = Timer(
        Duration(seconds: durationSlider),
        () async {
          carouselController.nextPage(
              duration: Duration(seconds: nextTime), curve: Curves.linear);
        },
      );
      update();
    }
  }

  //Timer reset
  Future checkTimer() async {
    bool local = (timer?.isActive) != null ? true : false;
    if (local) {
      timer!.cancel();
    }
  }
}
