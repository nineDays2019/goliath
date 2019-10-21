import 'package:flutter/material.dart';

buildRoundDecoration(Color color) {
  return new BoxDecoration(
      border: new Border.all(color: color, width: 0.5), // 边色与边宽度
      color: Color(0xFF9E9E9E), // 底色
      //        borderRadius: new BorderRadius.circular((20.0)), // 圆角度
      borderRadius: new BorderRadius.vertical(
        top: Radius.elliptical(20, 50),
      ));
}

buildGradient(List<Color> colors) {
  return new BoxDecoration(
    borderRadius: new BorderRadius.all(Radius.circular(14.0)),
    gradient: LinearGradient(
        begin: Alignment.topLeft, end: Alignment.bottomRight, colors: colors),
  );
}
