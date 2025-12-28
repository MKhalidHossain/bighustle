import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_sizes.dart';

extension InputDecorationExtensions on BuildContext {
  InputDecoration get primaryInputDecoration => InputDecoration(
    filled: true,
    suffixIconColor: AppColors.textFieldTextiHint,
    fillColor: AppColors.textFieldBackground,
    contentPadding: AppSizes.paddingAllRegular,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppSizes.paddingSmall),
      borderSide: const BorderSide(color: AppColors.textFieldBorder),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppSizes.paddingSmall),
      borderSide: const BorderSide(color: AppColors.textFieldBorder),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppSizes.paddingSmall),
      borderSide: const BorderSide(
        color: AppColors.textFieldBorder,
        width: 1.5,
      ),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppSizes.paddingSmall),
      //borderSide: const BorderSide(color: AppColors.pinkColor, width: 1.5),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppSizes.paddingSmall),
      //borderSide: const BorderSide(color: AppColors.pinkColor, width: 1.5),
    ),
    hintStyle: const TextStyle(
      color: AppColors.textFieldTextiHint,
      fontSize: 16,
      fontWeight: FontWeight.w400,
    ),
    labelStyle: const TextStyle(
      color: AppColors.secondaryText,
      fontSize: 16,
      fontWeight: FontWeight.w500,
    ),
    errorStyle: const TextStyle(
      //color: AppColors.pinkColor,
      fontSize: 12,
      fontWeight: FontWeight.w400,
    ),
  );
}
