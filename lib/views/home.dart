import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:slideshow/controllers/home.controller.dart';
import 'package:slideshow/view-models/widgets.dart';
import './../util/theme_config.dart';
import 'package:get/get.dart';

class MyApp extends StatelessWidget {
  final c = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder(
          init: HomeController(),
          initState: (_) {
            c.getData();
          },
          builder: (_) {
            return Center(
              child: CarouselSlider(
                options: CarouselOptions(
                    viewportFraction: 1.0,
                    aspectRatio: 16 / 9,
                    height: Get.height,
                    initialPage: 0,
                    autoPlay: true,
                    autoPlayInterval: Duration(seconds: c.duration),
                    onPageChanged: c.pageChange),
                items: c.data.map(
                  (data) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Container(
                          height: Get.height,
                          width: Get.width,
                          decoration: BoxDecoration(
                            color: themeData.themeColor,
                            borderRadius: BorderRadius.circular(0.0),
                          ),
                          child: data['tipo'] == 'imagem'
                              ? CachedNetworkImage(
                                  imageUrl: HomeController.host + data['nome'],
                                  imageBuilder: (context, imageProvider) =>
                                      Container(
                                    height: Get.height,
                                    width: Get.width,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: imageProvider,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  placeholder: (context, url) => Container(
                                    height: Get.height,
                                    width: Get.width,
                                    child: Center(
                                      child: CircularProgressIndicator(
                                        valueColor:
                                            new AlwaysStoppedAnimation<Color>(
                                          Colors.grey,
                                        ),
                                      ),
                                    ),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      Container(
                                    height: Get.height,
                                    width: Get.width,
                                    color: Color.fromRGBO(0, 0, 0, 0.1),
                                    child: Center(
                                      child:
                                          Icon(Icons.error, color: Colors.grey),
                                    ),
                                  ),
                                )
                              : Center(
                                  child: videoPlayerController(
                                    HomeController.host + data['nome'],
                                  ),
                                ),
                        );
                      },
                    );
                  },
                ).toList(),
              ),
            );
          }),
    );
  }
}
