import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:slideshow/util/theme_config.dart';
import 'views/setid.dart';

void main() {
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: themeData.lightTheme,
      darkTheme: themeData.darkTheme,
      onInit: () async {
        await GetStorage.init();
      },
      home: Verify(),
    ),
  );
}
