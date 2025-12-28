import 'package:flutter_bighustle/core/theme/app_colors.dart';
import 'package:flutter_bighustle/core/theme/text_style.dart';
import 'package:flutter/material.dart';

extension ButtonStyleExtensions on BuildContext {
  Widget primaryButton({
    required VoidCallback onPressed,
    required String text,
    double? width,
    double? height,
    bool isLoading = false,
    IconData? icon,
    double borderRadius = 20,
  }) {
    return SizedBox(
      width: width ?? 250,
      height: height ?? 52,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primarybutton,
          foregroundColor: Colors.white,
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
        child: isLoading
            ? SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                ),
              )
            : Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    text,
                    style: AppText.lgMedium_18_500.copyWith(
                      color: AppColors.white,
                    ),
                  ),
                  if (icon != null) ...[
                    SizedBox(width: 8),
                    Icon(icon, size: 20, color: Colors.white),
                  ],
                ],
              ),
      ),
    );
  }
}


// import 'package:flutter/material.dart';
// import 'package:shevaandrii/core/themes/app_colors.dart';
// import 'package:shevaandrii/core/themes/text_style.dart';

// extension ButtonStyleExtensions on BuildContext {
//   Widget primaryButton({
//     required VoidCallback onPressed,
//     required String text,
//     double? width,
//     double? height,
//     bool isLoading = false,
//     IconData? icon,
//     double borderRadius = 12,

//   }) {
//     return SizedBox(
//       width: width ?? 250,
//       height: height ?? 48,
//       child: ElevatedButton(
//         onPressed: isLoading ? null : onPressed,
//         style: ElevatedButton.styleFrom(
//           backgroundColor: AppColors.buttonbackgroundcolor,
//           foregroundColor: Colors.black,
//           elevation: 2,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(64),
//           ),
//         ),
//         child:
//             isLoading
//                 ? SizedBox(
//                   width: 24,
//                   height: 24,
//                   child: CircularProgressIndicator(
//                     strokeWidth: 2,
//                     valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
//                   ),
//                 )
//                 : Row(
//                   mainAxisSize: MainAxisSize.min,
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text(
//                       text,
//                       style: AppText.mdMedium_16.copyWith(color: Colors.black),
//                     ),
//                     if (icon != null) ...[
//                       SizedBox(width: 8),
//                       Icon(icon, size: 20, color: Colors.black),
//                     ],
//                   ],
//                 ),
//       ),
//     );
//   }
// }

//  example for use this button 
// context.primaryButton1(
//                         height: 40,
//                         width: 97,
//                         onPressed: () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(builder: (context) => Scaffold()),
//                           );
//                         },
//                         text: "save",
//                       ),

