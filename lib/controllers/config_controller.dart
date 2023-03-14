import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ConfigController extends GetxController{
  var themeLight = ThemeData(
    primarySwatch: Colors.red,
  ).obs;
  var themeDark = ThemeData(
    primarySwatch: Colors.red,
    primaryColor: Colors.red,
    textTheme: Typography.whiteCupertino,
    brightness: Brightness.dark,
    canvasColor: Colors.black87,
  ).obs;
  var theme = ThemeData(
    primarySwatch: Colors.red,
  ).obs;
}