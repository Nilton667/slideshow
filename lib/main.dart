import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:slideshow/controllers/home.controller.dart';
import 'package:slideshow/util/theme_config.dart';
import 'views/home.dart';

void main() {
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: themeData.lightTheme,
      darkTheme: themeData.darkTheme,
      onInit: () async {
        await GetStorage.init();
        final box = GetStorage();
        final c = Get.put(HomeController());
        c.id = box.read('id') is int ? box.read('id') : 0;
        c.getData();
      },
      home: MyApp(),
    ),
  );
}
