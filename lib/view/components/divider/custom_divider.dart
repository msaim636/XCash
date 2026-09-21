import 'package:flutter/material.dart';
import 'package:xcash_app/core/utils/dimensions.dart';
import 'package:xcash_app/core/utils/my_color.dart';

class CustomDivider extends StatelessWidget {

  final double space;
  final Color color;

  const CustomDivider({
    super.key,
    this.space = Dimensions.space20,
    this.color = MyColor.colorBlack
  });

  @override
  Widget build(BuildContext context) {

    return Column(

      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: space),
        Divider(color: color.withOpacity(0.2), height: 0.5, thickness: 0.5),
        SizedBox(height: space),
      ],
    );
  }
}
