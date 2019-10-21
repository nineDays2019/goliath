import 'package:flutter/material.dart';

makeColor(String colorStr) {
  switch (colorStr) {
    case "white":
      return Color.fromARGB(255, 250, 222, 85);
    case "yellow":
      return Color.fromARGB(255, 247, 205, 72);
    case "blue":
      return Color.fromARGB(255, 245, 192, 71);
    case "purple":
      return Color.fromARGB(255, 244, 178, 62);
  }
}
