import 'package:flutter/material.dart';

class ClipTopSplash extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
      Offset controlPoint = Offset(size.width * .24,size.height);
      Offset endPoint = Offset(size.width * .25,size.height * .96);
      Offset controlPoint2 = Offset(size.width * .3,size.height * .78);
      Offset endPoint2 = Offset(size.width * .5,size.height * .78);
      Offset controlPoint3 = Offset(size.width * .7,size.height * .78);
      Offset endPoint3 = Offset(size.width * .75,size.height * .96);
      Offset controlPoint4 = Offset(size.width * .76,size.height );
      Offset endPoint4 = Offset(size.width * .79,size.height );
      Path path = Path()
      ..lineTo(0, size.height)
      ..lineTo(size.width * .21, size.height )
      ..quadraticBezierTo(
      controlPoint.dx,
      controlPoint.dy, 
      endPoint.dx,
      endPoint.dy)
      ..quadraticBezierTo(
      controlPoint2.dx,
      controlPoint2.dy, 
      endPoint2.dx,
      endPoint2.dy)
      ..quadraticBezierTo(
      controlPoint3.dx,
      controlPoint3.dy, 
      endPoint3.dx,
      endPoint3.dy)
      ..quadraticBezierTo(
      controlPoint4.dx,
      controlPoint4.dy, 
      endPoint4.dx,
      endPoint4.dy)
      ..lineTo(size.width, size.height)
      ..lineTo(size.width, 0);
      return path;
    }
  
    @override
    bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}