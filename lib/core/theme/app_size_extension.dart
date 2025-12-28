import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppText {
  AppText._(); // Prevent instantiation

  static const String _fontFamily = 'Poppins';

  static TextStyle _style({
    required double fontSize,
    required FontWeight fontWeight,
    Color? color,
  }) {
    return TextStyle(
      fontFamily: _fontFamily,
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color ?? AppColors.primaryText,
    );
  }

  // XXXL
  static final TextStyle xxxlSemiBold_40_600 = _style(
    fontSize: 40,
    fontWeight: FontWeight.w600,
  );
  static final TextStyle xxxlBold_32_700 = _style(
    fontSize: 32,
    fontWeight: FontWeight.w700,
  );

  // XXL
  static final TextStyle xxlSemiBold_24_600 = _style(
    fontSize: 24,
    fontWeight: FontWeight.w600,
  );

  // XL2
  static final TextStyle xl2Medium_22_500 = _style(
    fontSize: 22,
    fontWeight: FontWeight.w500,
  );

  // XL
  static final TextStyle xlSemiBold_20_600 = _style(
    fontSize: 20,
    fontWeight: FontWeight.w600,
  );
  static final TextStyle xlBold_20_700 = _style(
    fontSize: 20,
    fontWeight: FontWeight.w700,
  );

  // LG
  static final TextStyle lgMedium_18_500 = _style(
    fontSize: 18,
    fontWeight: FontWeight.w500,
  );

  // MD
  static final TextStyle mdSemiBold_16_600 = _style(
    fontSize: 16,
    fontWeight: FontWeight.w600,
  );
  static final TextStyle mdBold_16_700 = _style(
    fontSize: 16,
    fontWeight: FontWeight.w700,
  );
  static final TextStyle mdMedium_16_500 = _style(
    fontSize: 16,
    fontWeight: FontWeight.w500,
  );
  static final TextStyle mdRegular_16_400 = _style(
    fontSize: 16,
    fontWeight: FontWeight.w400,
  );

  // SM
  static final TextStyle smMedium_14_500 = _style(
    fontSize: 14,
    fontWeight: FontWeight.w500,
  );
  static final TextStyle smRegular_14_400 = _style(
    fontSize: 14,
    fontWeight: FontWeight.w400,
  );

  // XS
  static final TextStyle xsMedium_12_500 = _style(
    fontSize: 12,
    fontWeight: FontWeight.w500,
  );
  static final TextStyle xsRegular_12_400 = _style(
    fontSize: 12,
    fontWeight: FontWeight.w400,
  );
}
