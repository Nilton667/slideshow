import 'dart:convert';
import 'package:carousel_slider/carousel_options.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class HomeController extends GetxController {
  List data = [];
  static const host = 'https://localhost/slideshow/';
  int duration = 7;

  Future getData() async {
    try {
      var res = await http.get(Uri.parse(host + "index.php"));
      if (res.statusCode == 200) {
        var resBody = json.decode(res.body);
        if (resBody is List) {
          data.addAll(resBody);
        }
      }
    } catch (e) {
      print(
        "Data error: " + e.toString(),
      );
    }
    update();
  }

  void pageChange(int index, CarouselPageChangedReason reason) {
    if (data.length > 0) {
      duration = data[index]['duration'] is int
          ? data[index]['duration']
          : int.parse(data[index]['duration']);
      update();
    }
  }
}
