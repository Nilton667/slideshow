import 'dart:async';
import 'dart:convert';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:flutter/animation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:chewie/chewie.dart';
import 'package:slideshow/util/global.dart';
import 'package:slideshow/view-models/widgets.dart';
import 'package:video_player/video_player.dart';
import 'package:get_storage/get_storage.dart';

class HomeController extends GetxController {
  //Video Controller
  ChewieController? chewieController;
  late VideoPlayerController videoController;

  //Data
  List data = [];
  var id = '0';

  CarouselController carouselController = new CarouselController();
  //Carousel setting
  int durationSlider = 0;
  int nextTime = 1;
  Timer? timer;
  //Loading page
  bool isLoading = true;

  //Get image and video
  Future getData() async {
    if (!isLoading) {
      isLoading = true;
      update();
    }
    final box = GetStorage();
    id = box.read('id') is String ? box.read('id') : 0;
    try {
      var res = await http.post(
        Uri.parse(host + "api/slider/get"),
        body: {
          "getData": "true",
          "id": id.toString(),
          "permission": permission,
        },
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
                duration: Duration(seconds: nextTime),
                curve: Curves.linear,
              );
            },
          );
        } else {
          data = [];
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
          fileDir + data[index]['nome'],
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
