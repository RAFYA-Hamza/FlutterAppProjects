// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class StyleText extends StatelessWidget {
  final String titleText;
  final Color colorText;
  final FontWeight fontWeightText;
  final double fontSizeText;

  const StyleText({
    Key? key,
    required this.titleText,
    required this.colorText,
    required this.fontWeightText,
    required this.fontSizeText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      titleText,
      style: TextStyle(
        color: colorText,
        fontWeight: fontWeightText,
        fontSize: fontSizeText,
      ),
    );
  }
}
