import 'package:flutter/material.dart';

class CommonShadowContainer extends Container {
  CommonShadowContainer(
      {Widget child,
      decoration = const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              offset: Offset(0.0, 15.0),
              blurRadius: 15.0,
              spreadRadius: 1.0,

    )
          ])})
      : super(child: child, decoration: decoration);
}