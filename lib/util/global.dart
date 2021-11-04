//Permission
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

const permission = "oratoriam";
//Routs
const host = 'http://10.0.2.2:8000/';
//const host = 'https://tvcomunidade.pt/';
const fileDir = host + 'storage/';

Future toast(String msg) {
  return Fluttertoast.showToast(
    msg: msg,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 3,
    backgroundColor: Colors.black54,
    textColor: Colors.white,
    fontSize: 16.0,
  );
}
