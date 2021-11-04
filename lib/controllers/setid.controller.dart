import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:slideshow/util/global.dart';
import 'package:slideshow/views/home.dart';
import 'package:slideshow/views/setid.dart';
import 'package:http/http.dart' as http;

class SetIdController extends GetxController {
  bool isDefined = false;
  bool isLoading = false;
  //Editing controller
  //Id
  TextEditingController formId = new TextEditingController();
  final FocusNode formIdFocus = new FocusNode();
  //Key
  TextEditingController formKey = new TextEditingController();
  final FocusNode formKeyFocus = new FocusNode();

  void verify() async {
    final box = await GetStorage();

    GetStorage().initStorage.then(
      (value) {
        if (value == true) {
          isDefined =
              box.read('id') is String || box.read('id') is int ? true : false;

          if (isDefined) {
            Get.to(() => Home());
            return;
          }
          Get.to(() => SetId());
        } else {
          SystemNavigator.pop();
        }
      },
    );
  }

  void setId(context) async {
    if (formId.text.trim() == '' || formId.text.trim() == '0') {
      toast('Insira um id valido');
      formIdFocus.requestFocus();
      return;
    } else if (formKey.text.trim().length < 6) {
      toast('Insira um código de acesso valido!');
      formKeyFocus.requestFocus();
      return;
    }

    if (!isLoading) {
      isLoading = true;
      update();
    }

    try {
      var res = await http.post(
        Uri.parse(host + "api/slider/set"),
        body: {
          "setData": "true",
          "id": formId.text.trim(),
          "acess": formKey.text.trim(),
          "permission": permission,
        },
      );
      if (res.statusCode == 200) {
        var resBody = json.decode(res.body);

        if (resBody is List) {
          final box = await GetStorage();

          box.write('id', resBody[0]['id_loja'].toString().trim());

          Get.offAll(() => Home());
        } else if (resBody == 0) {
          toast('Este id não se encontra associado a uma loja!');
        } else {
          toast(resBody);
        }
      }
    } catch (e) {
      print(
        "Data error: " + e.toString(),
      );
    }
    isLoading = false;
    update();
    formIdFocus.requestFocus();
  }
}
