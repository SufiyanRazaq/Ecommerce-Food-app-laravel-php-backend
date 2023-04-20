import 'package:flutter/material.dart';
import 'package:measterproject/dimension.dart';

import 'big_text.dart';
import 'colors.dart';
import 'icon_and_text_widget.dart';
import 'small_text.dart';

class AppColumn extends StatelessWidget {
  final String text;
  const AppColumn({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BigText(
          text: text,
          size: Dimensions.font26,
        ),
        SizedBox(
          height: 8,
        ),
        Row(
          children: [
            Wrap(
              children: List.generate(
                5,
                (index) {
                  return Icon(
                    Icons.star,
                    color: AppColor.mainColor,
                    size: 13,
                  );
                },
              ),
            ),
            SizedBox(
              width: 5,
            ),
            SmallText(text: '4.5'),
            SizedBox(
              width: 5,
            ),
            SmallText(text: '!287'),
            SizedBox(
              width: 5,
            ),
            SmallText(text: 'comments'),
          ],
        ),
        SizedBox(
          height: 8,
        ),
        Row(
          //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconAndTextWidget(
              icon: Icons.circle_sharp,
              text: "Normal",
              iconColor: AppColor.iconColor1,
            ),
            SizedBox(
              width: 2,
            ),
            IconAndTextWidget(
              icon: Icons.location_on,
              text: "1.7Km",
              iconColor: AppColor.mainColor,
            ),
            SizedBox(
              width: 2,
            ),
            IconAndTextWidget(
              icon: Icons.access_time_rounded,
              text: "32min",
              iconColor: AppColor.iconColor2,
            ),
          ],
        )
      ],
    );
  }
}
