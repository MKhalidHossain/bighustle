import 'package:flutter_bighustle/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class OrDividerWithCircle extends StatelessWidget {
  final String text;
  // final EdgeInsetsGeometry padding;
  //final double circleSize;
  final TextStyle? textStyle;
  // final Color circleColor;
  final Color textColor;

  const OrDividerWithCircle({
    super.key,
    this.text = 'Or Sign in With',
    // this.padding = const EdgeInsets.symmetric(horizontal: 16),
    //this.circleSize = 30.0,
    this.textStyle,
    // this.circleColor = Colors.white,
    this.textColor = AppColors.secondaryText,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(child: Divider(color: AppColors.secondaryText)),

        Container(
          // width: circleSize,
          // height: circleSize,
          alignment: Alignment.center,
          // decoration: BoxDecoration(
          //   shape: BoxShape.circle,
          //   // color: circleColor,
          //   border: Border.all(color: AppColors.secondaryColor),
          // ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              text,
              style:
                  textStyle ??
                  TextStyle(
                    fontSize: 12,
                    color: textColor,
                    fontWeight: FontWeight.w400,
                  ),
            ),
          ),
        ),
        const Expanded(child: Divider(color: AppColors.secondaryText)),
      ],
    );
  }
}
