import 'package:flutter/material.dart';

class NoDataPage extends StatelessWidget {
  final String text;
  final String imgPath;
  const NoDataPage(
      {super.key, required this.text, this.imgPath = "assets/empty_cart.png"});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          imgPath,
          height: MediaQuery.of(context).size.height * 0.350,
          width: MediaQuery.of(context).size.height * 0.550,
        ),
        Text(
          text,
          style: TextStyle(
              fontSize: MediaQuery.of(context).size.height * 0.0300,
              color: Theme.of(context).disabledColor),
        )
      ],
    );
  }
}
