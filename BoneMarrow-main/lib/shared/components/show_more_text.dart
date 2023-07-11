import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';

import '../constansts.dart/app_strings.dart';

class ShowMoreText extends StatelessWidget {
  final String text;
  final int? lines;
  ShowMoreText({super.key, required this.text, this.lines});

  @override
  Widget build(BuildContext context) {
    return ReadMoreText(
      text,
      trimLines: lines ?? 3,
      colorClickableText: Colors.pink,
      trimMode: TrimMode.Line,
      trimCollapsedText: showMore,
      trimExpandedText: showLess,
      // textAlign: TextAlign.justify,
      moreStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
    );
  }
}
