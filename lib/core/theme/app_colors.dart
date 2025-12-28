import 'package:flutter/material.dart';

class AppColors {
  /// [Primary Background color]
  static const Color background = Color(0xFFFFFFFF);
  static const Color secondarybackground = Color(0xFF3D3E40);
  static const Color primarybutton = Color(0xFF3F42EE);
  static const Color imagebackgrount = Color(0xFF1C2A3A);

  //gradiant colors
  static const Color gradientTop = Color(0xFF3A83EA);
  static const Color gradientBottom = Color(0xFF45B881);

  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [gradientTop, gradientBottom],
  );

  /// [Primary App Colors]

  static const Color white = Color(0xFFFFFFFF);

  /// [Text colors]
  static const Color textFieldBackground = Color(0xFF121212);
  static const Color textFieldTextiHint = Color(0xFFB0B0B0);
  static const Color textFieldBorder = Color(0xFFB0B0B0);
  static const Color progressBg = Color(0xFFE7E8EA);

  static const Color textLink = Color(0xFF3F42EE);

  static const Color primaryText = Color(0xFFFFFFFF);
  static const Color primaryTextblack = Color(0xFF25272D);
  static const Color secondaryTextblack = Color(0xFF7E8492);
  static const Color messageBoxbackground = Color(0xFFE5E5E5);
  static const Color buttonTextColor = Colors.black;
  static const Color buttonInactiveTextColor = Color(0xFF3F42EE);
  static const Color secondaryText = Color(0xFF7E8492);
  static const Color buttontext = Color(0xFF000000);

  static const Color tabselect = Color(0xFF6447CE);
  static const Color interestsblue = Color(0xFF3F42EE);
  static const Color interestsyellow = Color(0xFFFFBF0F);
  static const Color interestsgreen = Color(0xFF27BE69);
  static const Color interestsred = Color(0xFFF2415A);

  static const Color appber = Color(0xFFECEDFD);

  /// [delete]
  // static const Color containerPolicyColor = Color(0xff2A2A2A);

  // static const Color primary = Color(0x#2B2B2B);
  // static const Color primaryDark = Color(0xFF6447CE);

  // static const Color secondary = Color(0xFF34373E);
  // static const Color textPrimary = secondary;
  // static const Color textSecondary = textPrimary;

  // static const Color icon = Color(0xFF595959);
  // static const Color warningBackground = Color(0xFFFAEBEB);
  // static const Color error = Color(0xFFCE3837);
  // static const Color success = Color(0xFF09B850);
  // static const Color backgroundLight = Color(0xFFDBEBF6);

  // // Button styles (for convenience)
  // static const Color buttonBackground = primary;
  // static const Color buttonText = background; // when background is primary

  // // Add these new form field specific colors
  // static const Color inputBorder = primaryDark; // Light blue-gray border
  // static const Color inputFocusedBorder = primaryDark; // Use your primary blue
  // static const Color inputErrorBorder = error; // Use your existing error red
  // static const Color inputFill = white; // White background
  // static const Color inputHint = textSecondary; // Use your textSecondary
  // static const Color inputLabel = textPrimary; // Use your textPrimary
  // static const Color inputIcon = Color(0xFF70603F);

  // static const Color inputDisabledFill = Color(
  //   0xFFF5F5F5,
  // ); // Light gray for disabled

  // static const Gradient primaryGradient = LinearGradient(
  //   colors: [pinkColor, lightBlue],
  //   begin: Alignment.topLeft,
  //   end: Alignment.bottomRight,
  //   stops: [0.2, 7.0],
  //   transform: GradientRotation(45 * (pi / 180)),
  // );
}
