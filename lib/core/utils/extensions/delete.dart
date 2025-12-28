// import 'package:flutter/material.dart';
// import 'package:flutter_kmondesir472_fo82e52cc7/core/theme/app_colors.dart';
// import 'package:flutter_kmondesir472_fo82e52cc7/core/theme/text_style.dart';
// import 'package:flutter_kmondesir472_fo82e52cc7/presentation/core/widgets/gradient_primary_button.dart';

// extension ButtonStyleExtensions on BuildContext {
//   Widget primaryButton1({
//     required VoidCallback onPressed,
//     required String text,
//     double? width,
//     double? height,
//     bool isLoading = false,
//   }) {
//     return SizedBox(
//       width: width ?? 342,
//       height: height ?? 45,
//       child: GradientButtonPrimary(
//         onPressed: onPressed,
//         isPrimary: true,
//         gradient: AppColors.primarybutton,
//         child: isLoading
//             ? SizedBox(
//                 width: 24,
//                 height: 24,
//                 child: const CircularProgressIndicator(
//                   strokeWidth: 2,
//                   valueColor: AlwaysStoppedAnimation<Color>(AppColors.white),
//                 ),
//               )
//             : Text(
//                 text,
//                 style: AppText.mdMedium_16.copyWith(color: AppColors.primaryText),
//               ),
//       ),
//     );
//   }
// }

