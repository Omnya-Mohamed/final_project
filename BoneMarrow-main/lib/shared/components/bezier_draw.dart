import 'package:flutter/material.dart';
import 'package:proste_bezier_curve/proste_bezier_curve.dart';

class BezierDraw extends StatelessWidget {
  BezierDraw({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    return ClipPath(
      clipper: ProsteBezierCurve(
        position: ClipPosition.bottom,
        list: [
          BezierCurveSection(
            start: Offset(0, 100),
            top: Offset(screenWidth / 2, 70),
            end: Offset(screenWidth, 100),
          ),
        ],
      ),
      child: Container(
        height: 200,
        color: Colors.deepPurple[300],
      ),
    );
  }
}
