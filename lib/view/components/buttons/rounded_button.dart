import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xcash_app/core/utils/dimensions.dart';
import 'package:xcash_app/core/utils/my_color.dart';

class RoundedButton extends StatelessWidget {
  final bool isColorChange;
  final String text;
  final VoidCallback press;
  final Color color;
  final Color? textColor;
  final double width;
  final double height;
  final double horizontalPadding;
  final double verticalPadding;
  final double cornerRadius;
  final bool isOutlined;
  final bool isLoading;
  final Widget? child;

  const RoundedButton({
    super.key,
    this.isColorChange = false,
    this.isLoading = false,
    this.width = 1,
    this.height = Dimensions.defaultButtonH,
    this.child,
    this.cornerRadius = 6,
    required this.text,
    required this.press,
    this.isOutlined = false,
    this.horizontalPadding = 35,
    this.verticalPadding = 18,
    this.color = MyColor.primaryColor,
    this.textColor = MyColor.colorWhite,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return child != null
        ? InkWell(
            onTap: press,
            splashColor: MyColor.getScreenBgColor(),
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: verticalPadding),
                width: size.width * width,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(cornerRadius), color: isColorChange ? color : MyColor.getPrimaryButtonColor()),
                child: Center(child: Text(text.tr, style: TextStyle(color: isColorChange ? textColor : MyColor.getPrimaryButtonTextColor(), fontSize: 14, fontWeight: FontWeight.w500)))),
          )
        : isOutlined
            ? Material(
                child: InkWell(
                  onTap: press,
                  splashColor: MyColor.getScreenBgColor(),
                  child: Container(
                      padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: verticalPadding),
                      width: size.width * width,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(cornerRadius), color: isColorChange ? color : MyColor.getPrimaryButtonColor()),
                      child: Center(child: Text(text.tr, style: TextStyle(color: isColorChange ? textColor : MyColor.getPrimaryButtonTextColor(), fontSize: 14, fontWeight: FontWeight.w500)))),
                ),
              )
            : ElevatedButton(
                onPressed: press,
                style: ElevatedButton.styleFrom(
                    backgroundColor: color,
                    shadowColor: MyColor.transparentColor,
                    padding: EdgeInsets.symmetric(
                      horizontal: horizontalPadding,
                      vertical: verticalPadding,
                    ),
                    splashFactory: InkRipple.splashFactory,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(cornerRadius)),
                    maximumSize: Size.fromHeight(size.height),
                    minimumSize: Size(double.infinity, height),
                    textStyle: TextStyle(color: textColor, fontSize: 14, fontWeight: FontWeight.w500)),
                child: isLoading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(color: Colors.white),
                      )
                    : Text(
                        text.tr,
                        style: TextStyle(color: textColor),
                      ),
              );
  }
}
