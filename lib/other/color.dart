import 'package:flutter/material.dart';

makeCodeWarsColor(String colorStr) {
  switch (colorStr) {
    case "white": //  显示为绿色
      return Colors.green;
    case "yellow": // 显示为黄色
      return Color.fromARGB(255, 247, 205, 72);
    case "blue": // 显示为红色
      return Colors.red;
    case "purple": // 显示为紫色
      return Colors.purple;
  }
}
