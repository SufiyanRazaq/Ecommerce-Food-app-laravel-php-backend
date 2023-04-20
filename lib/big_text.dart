import 'package:cupertino_icons/cupertino_icons.dart';
import 'package:flutter/material.dart';
import 'package:measterproject/dimension.dart';

class BigText extends StatelessWidget {
  BigText({
    super.key,
    this.color = const Color(0xFF332d2b),
    required this.text,
    this.overFlow = TextOverflow.fade,
    this.size = 20,
  });
  final Color color;
  final String text;
  double size;
  TextOverflow overFlow;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: 1,
      overflow: overFlow,
      style: TextStyle(
        fontFamily: 'Roboto',
        color: color,
        fontSize: size == 0 ? Dimensions.font20 : size,
        fontWeight: FontWeight.w400,
      ),
    );
  }
}
