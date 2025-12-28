import 'package:flutter/material.dart';

class AppSizes {
  // Private constructor to prevent instantiation
  AppSizes._();

  // Device screen size helpers
  static late double screenWidth;
  static late double screenHeight;
  static late double blockSizeHorizontal;
  static late double blockSizeVertical;

  // Initialize the sizes (call this in your root widget)
  static void init(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);
    screenWidth = mediaQueryData.size.width;
    screenHeight = mediaQueryData.size.height;
    blockSizeHorizontal = screenWidth / 100;
    blockSizeVertical = screenHeight / 100;
  }

  // Standard padding sizes
  static const double paddingTiny = 4.0;
  static const double paddingSmall = 8.0;
  static const double paddingMedium = 12.0;
  static const double paddingRegular = 16.0;
  static const double paddingExtraRegular = 18.0;
  static const double paddingLarge = 24.0;
  static const double paddingXLarge = 32.0;
  static const double paddingXXLarge = 48.0;

  // Margin sizes
  static const double marginTiny = 4.0;
  static const double marginSmall = 8.0;
  static const double marginMedium = 12.0;
  static const double marginRegular = 16.0;
  static const double marginExtraRegular = 18.0;
  static const double marginLarge = 24.0;
  static const double marginXLarge = 32.0;

  // Border radius
  static const double radiusSmall = 4.0;
  static const double radiusMedium = 8.0;
  static const double radiusRegular = 12.0;
  static const double radiusLarge = 16.0;
  static const double radiusXLarge = 24.0;
  static const double radiusCircle = 50.0;

  // Icon sizes
  static const double iconSizeTiny = 12.0;
  static const double iconSizeSmall = 16.0;
  static const double iconSizeMedium = 24.0;
  static const double iconSizeRegular = 32.0;
  static const double iconSizeLarge = 48.0;

  // Button sizes
  static const double buttonHeightSmall = 36.0;
  static const double buttonHeightMedium = 44.0;
  static const double buttonHeightLarge = 52.0;

  // Text sizes
  static const double textSizeTiny = 10.0;
  static const double textSizeSmall = 12.0;
  static const double textSizeMedium = 14.0;
  static const double textSizeRegular = 16.0;
  static const double textSizeLarge = 18.0;
  static const double textSizeXLarge = 20.0;
  static const double textSizeXXLarge = 24.0;
  static const double textSizeXXXLarge = 48.0;

  // Responsive helpers
  static double rpx(double size) => blockSizeHorizontal * size;
  static double rpy(double size) => blockSizeVertical * size;

  // Device type detection
  static bool get isMobile => screenWidth < 600;
  static bool get isTablet => screenWidth >= 600 && screenWidth < 900;
  static bool get isDesktop => screenWidth >= 900;

  // Common widget sizes
  static double get appBarHeight => isMobile ? 56.0 : 64.0;
  static double get bottomNavBarHeight => 56.0;
  static double get floatingActionButtonSize => 56.0;
  static double get drawerWidth => isMobile ? screenWidth * 0.8 : 304.0;

  // Edge insets helpers
  static EdgeInsets get paddingAllTiny => const EdgeInsets.all(paddingTiny);
  static EdgeInsets get paddingAllSmall => const EdgeInsets.all(paddingSmall);
  static EdgeInsets get paddingAllMedium => const EdgeInsets.all(paddingMedium);
  static EdgeInsets get paddingAllExtraMedium => const EdgeInsets.all(paddingExtraRegular);
  static EdgeInsets get paddingAllRegular => const EdgeInsets.all(paddingRegular);
  static EdgeInsets get paddingAllLarge => const EdgeInsets.all(paddingLarge);

  static EdgeInsets get paddingHorizontalTiny => const EdgeInsets.symmetric(horizontal: paddingTiny);
  static EdgeInsets get paddingHorizontalSmall => const EdgeInsets.symmetric(horizontal: paddingSmall);
  static EdgeInsets get paddingHorizontalMedium => const EdgeInsets.symmetric(horizontal: paddingMedium);
  static EdgeInsets get paddingHorizontalExtraMedium => const EdgeInsets.symmetric(horizontal: paddingExtraRegular);
  static EdgeInsets get paddingHorizontalRegular => const EdgeInsets.symmetric(horizontal: paddingRegular);
  static EdgeInsets get paddingHorizontalLarge => const EdgeInsets.symmetric(horizontal: paddingLarge);

  static EdgeInsets get paddingVerticalTiny => const EdgeInsets.symmetric(vertical: paddingTiny);
  static EdgeInsets get paddingVerticalSmall => const EdgeInsets.symmetric(vertical: paddingSmall);
  static EdgeInsets get paddingVerticalExtraMedium => const EdgeInsets.symmetric(vertical: paddingExtraRegular);
  static EdgeInsets get paddingVerticalRegular => const EdgeInsets.symmetric(vertical: paddingRegular);
  static EdgeInsets get paddingVerticalLarge => const EdgeInsets.symmetric(vertical: paddingLarge);

  // Border radius helpers
  static BorderRadius get borderRadiusSmall => BorderRadius.circular(radiusSmall);
  static BorderRadius get borderRadiusMedium => BorderRadius.circular(radiusMedium);
  static BorderRadius get borderRadiusRegular => BorderRadius.circular(radiusRegular);
  static BorderRadius get radiusMediumborderRadiusLarge => BorderRadius.circular(radiusLarge);

  // Padding only helpers
  static EdgeInsets paddingOnly({
    double left = 0.0,
    double top = 0.0,
    double right = 0.0,
    double bottom = 0.0,
  }) => EdgeInsets.only(left: left, top: top, right: right, bottom: bottom);
}
