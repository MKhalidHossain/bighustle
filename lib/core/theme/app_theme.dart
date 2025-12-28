import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTheme {
  static ThemeData get light => ThemeData(
    fontFamily: 'NotoSansKR',
    scaffoldBackgroundColor: AppColors.background,
    //primaryColor: AppColors.pinkColor,
    colorScheme: ColorScheme.light(
      primary: AppColors.primarybutton,
      //primary: AppColors.pinkColor,
      secondary: AppColors.primarybutton,
      //primaryContainer: AppColors.pinkColor,
    ),
  );
}





// For Screens Using the Default Image

// class HomePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return GlobalBackgroundWrapper(
//       child: Scaffold(
//         backgroundColor: Colors.transparent,
//         appBar: AppBar(title: Text('Home')),
//         body: Center(child: Text("Default background")),
//       ),
//     );
//   }
// }


// For Screens That Override the Image

// class SpecialPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return GlobalBackgroundWrapper(
//       customImage: 'assets/images/custom_bg.png',
//       child: Scaffold(
//         backgroundColor: Colors.transparent,
//         appBar: AppBar(title: Text('Special')),
//         body: Center(child: Text("Custom background")),
//       ),
//     );
//   }
// }




//  For Screens That Use a Color Instead

// class ColorBackgroundPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return GlobalBackgroundWrapper(
//       backgroundColor: Colors.white,
//       child: Scaffold(
//         backgroundColor: Colors.transparent,
//         body: Center(child: Text("Color background")),
//       ),
//     );
//   }
// }


// Optional: Apply Globally in MaterialApp

// return MaterialApp(
//   theme: AppTheme.dark,
//   builder: (context, child) {
//     return GlobalBackgroundWrapper(child: child ?? SizedBox());
//   },
//   home: HomePage(),
// );


