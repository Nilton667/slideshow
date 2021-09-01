import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:slideshow/util/theme_config.dart';
import 'views/home.dart';

void main() {
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: themeData.lightTheme,
      darkTheme: themeData.darkTheme,
      home: MyApp(),
    ),
  );
}
