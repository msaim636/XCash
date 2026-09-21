import 'package:flutter/material.dart';
import 'package:xcash_app/core/utils/dimensions.dart';
import 'package:xcash_app/core/utils/my_color.dart';

class RoundedLoadingBtn extends StatelessWidget {
  final Color? loaderColor;
  final Color? color;
  final double width;
  final double height;
  final double horizontalPadding;
  final double verticalPadding;
  final double cornerRadius;

  const RoundedLoadingBtn({
    super.key,
    this.width = double.infinity,
    this.height = Dimensions.defaultButtonH,
    this.cornerRadius = 4,
    this.horizontalPadding = 35,
    this.verticalPadding = 18,
    this.loaderColor = MyColor.colorWhite,
    this.color = MyColor.primaryColor,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        shadowColor: MyColor.transparentColor,
        maximumSize: Size.fromHeight(size.height),
        minimumSize: Size(double.infinity, height),
        // splashFactory: InkRipple.splashFactory,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(cornerRadius)),
        textStyle: TextStyle(color: loaderColor, fontSize: 14, fontWeight: FontWeight.w500),
      ),
      child: SizedBox(width: 20, height: 20, child: CircularProgressIndicator(color: loaderColor, strokeWidth: 2)),
    );
  }
}
