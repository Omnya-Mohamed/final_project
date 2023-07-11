import 'package:flutter/material.dart';

class HeaderClipper extends CustomClipper<Path> {
  HeaderClipper({required this.avatarRadius});

  final avatarRadius;

  @override
  getClip(Size size) {
    final path = Path()
      ..lineTo(0.0, size.height - 100)
      ..quadraticBezierTo(size.width / 4, (size.height - avatarRadius),
          size.width / 2, (size.height - avatarRadius))
      ..quadraticBezierTo(size.width - (size.width / 4),
          (size.height - avatarRadius), size.width, size.height - 100)
      ..lineTo(size.width, 0.0)
      ..close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    return false;
  }
}
