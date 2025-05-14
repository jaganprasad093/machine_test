import 'package:flutter/material.dart';
import 'package:machine_test/core/constants/color_constants.dart';
import 'package:machine_test/core/constants/size_constants.dart'
    show SizeConstants;

class CustomButton extends StatelessWidget {
  final String? text;

  final Gradient? gradient;
  final double? fontSize;
  final Function()? onTap;
  final Widget? child;
  final EdgeInsetsGeometry? padding;

  const CustomButton({
    Key? key,
    this.text,

    this.gradient,
    this.fontSize,
    this.onTap,
    this.padding,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding:
            padding ?? const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        constraints: BoxConstraints(
          minWidth: SizeConstants.width(context) * 0.5,
          minHeight: SizeConstants.height(context) * 0.045,
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [ColorConstants.pinkColor, ColorConstants.lightPink],
            begin: Alignment.centerLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Center(
          child:
              child ??
              Text(
                text ?? "",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: fontSize ?? 13,
                ),
              ),
        ),
      ),
    );
  }
}
