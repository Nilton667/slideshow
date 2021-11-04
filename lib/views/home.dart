import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
import 'package:slideshow/controllers/home.controller.dart';
import 'package:slideshow/util/global.dart';
import 'package:slideshow/view-models/widgets.dart';
import 'package:slideshow/views/setid.dart';
import './../util/theme_config.dart';
import 'package:get/get.dart';

class Home extends StatelessWidget {
  final c = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    return Shortcuts(
      shortcuts: {
        LogicalKeySet(LogicalKeyboardKey.select): ActivateIntent(),
      },
      child: RawKeyboardListener(
        onKey: (RawKeyEvent event) async {
          if (event.runtimeType == RawKeyDownEvent) {
            if (event.logicalKey.keyLabel == '0') {
              final box = await GetStorage();
              await box.remove('id');
              Get.offAll(() => Verify());
            }
          }
        },
        autofocus: true,
        focusNode: FocusNode(),
        child: Scaffold(
          body: GetBuilder(
            init: HomeController(),
            initState: (_) {
              final box = GetStorage();
              c.id = box.read('id') is String ? box.read('id') : 0;
              c.getData();
            },
            builder: (_) {
              return RefreshIndicator(
                onRefresh: c.getData,
                child: ListView(
                  children: [
                    Center(
                      child: c.isLoading == true
                          ? loading()
                          : c.isLoading == false && c.data.length <= 0
                              ? Container(
                                  height: Get.height,
                                  width: Get.width,
                                  padding: const EdgeInsets.all(8.0),
                                  child: Center(
                                    child: Text(
                                      'Sem conteúdo a ser exibido!',
                                      style: TextStyle(
                                          fontSize: 22.0, color: Colors.grey),
                                    ),
                                  ),
                                )
                              : CarouselSlider(
                                  carouselController: c.carouselController,
                                  options: CarouselOptions(
                                    viewportFraction: 1.0,
                                    aspectRatio: 16 / 9,
                                    height: Get.height,
                                    onPageChanged: c.pageChange,
                                  ),
                                  items: c.data.map(
                                    (data) {
                                      return Builder(
                                        builder: (BuildContext context) {
                                          return Container(
                                            height: Get.height,
                                            width: Get.width,
                                            decoration: BoxDecoration(
                                              color: themeData.themeColor,
                                              borderRadius:
                                                  BorderRadius.circular(0.0),
                                            ),
                                            child: data['tipo'] == 'imagem'
                                                ? CachedNetworkImage(
                                                    imageUrl:
                                                        fileDir + data['nome'],
                                                    imageBuilder: (context,
                                                            imageProvider) =>
                                                        Container(
                                                      height: Get.height,
                                                      width: Get.width,
                                                      decoration: BoxDecoration(
                                                        image: DecorationImage(
                                                          image: imageProvider,
                                                          fit: data['fit'] ==
                                                                  'cover'
                                                              ? BoxFit.cover
                                                              : data['fit'] ==
                                                                      'contain'
                                                                  ? BoxFit
                                                                      .contain
                                                                  : BoxFit.fill,
                                                        ),
                                                      ),
                                                    ),
                                                    placeholder:
                                                        (context, url) =>
                                                            loading(),
                                                    errorWidget:
                                                        (context, url, error) =>
                                                            Container(
                                                      height: Get.height,
                                                      width: Get.width,
                                                      color: Color.fromRGBO(
                                                          0, 0, 0, 0.1),
                                                      child: Center(
                                                        child: Icon(
                                                          Icons.error,
                                                          color: Colors.grey,
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                : Center(
                                                    child: c.chewieController !=
                                                                null &&
                                                            c
                                                                .chewieController!
                                                                .videoPlayerController
                                                                .value
                                                                .isInitialized
                                                        ? chewie()
                                                        : loading(),
                                                  ),
                                          );
                                        },
                                      );
                                    },
                                  ).toList(),
                                ),
                    )
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
