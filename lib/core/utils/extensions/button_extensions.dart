// import 'package:flutter/material.dart';
// import '../../theme/app_colors.dart';
// import '../../theme/text_style.dart';

// extension ButtonStyleExtensions on BuildContext {
//   Widget primaryButton({
//     required VoidCallback onPressed,
//     required String text,
//     double? width,
//     double? hight,
//     bool isLoading = false,
//   }) {
//     return GradientButtonPrimary(
//       onPressed: onPressed,
//       isPrimary: true,
//       gradient: AppColors.primaryGradient,
//       child: isLoading
//           ? SizedBox(
//               width: width ?? 24,
//               height: hight ?? 24,
//               child: CircularProgressIndicator(
//                 strokeWidth: 2,
//                 valueColor: AlwaysStoppedAnimation<Color>(AppColors.white),
//               ),
//             )
//           : Text( 
//               text,
//               style: AppText.mdMedium_16.copyWith(color: AppColors.primaryText),
//             ),
//       // const LinearGradient(
//       //   colors: [
//       //     AppColors.primary,
//       //     AppColors.primaryLight,
//       //     AppColors.primaryDark,
//       //   ],
//       //   begin: Alignment.topLeft,
//       //   end: Alignment.bottomRight,
//       // ),
//     );
//   }
// }
