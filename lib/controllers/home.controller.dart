import 'dart:convert';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:flutter/animation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class HomeController extends GetxController {
  List data = [];
  //static const host = 'http://10.0.2.2/slideshow/';
  static const host = 'https://slideshow.rubro.ao/';
  CarouselController carouselController = new CarouselController();
  int duration = 7;
  bool isLoading = true;

  Future getData() async {
    try {
      var res = await http.get(Uri.parse(host + "index.php"));
      if (res.statusCode == 200) {
        var resBody = json.decode(res.body);
        if (resBody is List) {
          data.addAll(resBody);
          carouselController.nextPage(
            duration: Duration(seconds: data[0]['duration']),
            curve: Curves.linear,
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

  void pageChange(int index, CarouselPageChangedReason reason) {
    if (data.length > 0) {
      duration = data[index]['duration'] is int
          ? data[index]['duration']
          : int.parse(
              data[index]['duration'],
            );
      update();
    }
  }
}
