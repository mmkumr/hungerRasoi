import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';

Widget imageCarousel = new Container(
  height: 200.0,
  child: new Carousel(
    borderRadius: true,
    radius: Radius.circular(50),
    boxFit: BoxFit.cover,
    images: [
      AssetImage('images/banner/b1.jpg'),
      AssetImage('images/banner/b2.jpg'),
      AssetImage('images/banner/b3.jpg'),
    ],
    dotSize: 4.0,
    indicatorBgPadding: 8.0,
    dotColor: Colors.red,
    dotBgColor: Colors.transparent,
    animationCurve: Curves.fastOutSlowIn,
    animationDuration: Duration(milliseconds: 1000),
  ),
);