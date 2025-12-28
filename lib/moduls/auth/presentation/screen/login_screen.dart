// import 'dart:ui';
// import 'package:dana_bozzetto/core/common/common/textfield.dart';
// import 'package:dana_bozzetto/core/notifiers/button_status_notifier.dart';
// import 'package:dana_bozzetto/core/notifiers/snackbar_notifier.dart';
// import 'package:dana_bozzetto/moduls/auth/controller/login_controller.dart';
// import 'package:dana_bozzetto/moduls/home/common/menu/home.dart';
// import 'package:dana_bozzetto/moduls/auth/presentation/screen/forget_password.dart';
// import 'package:dana_bozzetto/moduls/auth/presentation/screen/otp_verify_screen.dart';
// import 'package:dana_bozzetto/moduls/auth/presentation/screen/signup_screen.dart';
// import 'package:flutter/material.dart';

// class LoginScreen extends StatefulWidget {
//   const LoginScreen({super.key});

//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//   final passwordController = TextEditingController();
//   final emailOrIdController = TextEditingController();
//   late final LoginsScreenController loginController;
//   late final SnackbarNotifier snackbarNotifier;
//   bool rememberMe = false;

//   @override
//   void initState() {
//     super.initState();
//     snackbarNotifier = SnackbarNotifier(context: context);
//     loginController = LoginsScreenController(snackbarNotifier);
//   }

//   @override
//   void dispose() {
//     emailOrIdController.dispose();
//     passwordController.dispose();
//     loginController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final listenable = Listenable.merge(
//       [loginController, loginController.processStatusNotifier],
//     );
//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: Stack(
//         children: [
//           Container(
//             width: double.infinity,
//             height: double.infinity,
//             decoration: const BoxDecoration(
//               image: DecorationImage(
//                 image: AssetImage('assets/image/ab.png'),
//                 fit: BoxFit.cover,
//               ),
//             ),
//           ),

//           Center(
//             child: Padding(
//               padding: const EdgeInsets.all(24.0),
//               child: ClipRRect(
//                 borderRadius: BorderRadius.circular(16),
//                 child: BackdropFilter(
//                   filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
//                   child: Container(
//                     width: double.infinity,
//                     padding: const EdgeInsets.fromLTRB(24, 24, 24, 24),
//                     decoration: BoxDecoration(
//                       color: Colors.white.withOpacity(0.12),
//                       borderRadius: BorderRadius.circular(16),
//                       border: Border.all(
//                         color: Colors.white.withOpacity(0.25),
//                         width: 1.2,
//                       ),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.black.withOpacity(0.2),
//                           blurRadius: 40,
//                           offset: const Offset(0, 12),
//                         ),
//                       ],
//                     ),
//                     child: Column(
//                       mainAxisSize: MainAxisSize.min,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       mainAxisAlignment: MainAxisAlignment.start,

//                       children: [
//                         Text(
//                           "Login to your account",
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 20,
//                             fontWeight: FontWeight.w500,
//                           ),
//                         ),
//                         SizedBox(height: 16),
//                         LabeledTextField(
//                           hintText: "Email or Client ID",
//                           prefixIcon: Icons.email_outlined,
//                           controller: emailOrIdController,
//                           onChanged: (value) =>
//                               loginController.emailOrId = value,
//                         ),
//                         LabeledTextField(
//                           hintText: "Password",
//                           prefixIcon: Icons.email_outlined,
//                           controller: passwordController,
//                           isPassword: true,
//                           onChanged: (value) => loginController.password = value,
//                         ),

//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Row(
//                               children: [
//                                 SizedBox(
//                                   width: 20,
//                                   height: 20,
//                                   child: Checkbox(
//                                     value: rememberMe,
//                                     onChanged: (val) {
//                                       setState(() => rememberMe = val!);
//                                     },
//                                     activeColor: const Color(0xFF00695C),
//                                     side: const BorderSide(
//                                       color: Colors.white70,
//                                     ),
//                                     shape: RoundedRectangleBorder(
//                                       borderRadius: BorderRadius.circular(4),
//                                     ),
//                                   ),
//                                 ),
//                                 const SizedBox(width: 8),
//                                 const Text(
//                                   'Remember me',
//                                   style: TextStyle(
//                                     color: Colors.white70,
//                                     fontSize: 14,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             TextButton(
//                               onPressed: () {
//                                 Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                     builder: (context) => ForgetPassword(),
//                                   ),
//                                 );
//                               },
//                               child: const Text(
//                                 'Forgot Password?',
//                                 style: TextStyle(
//                                   color: Colors.white70,
//                                   fontSize: 14,
//                                   decoration: TextDecoration.underline,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),

//                         const SizedBox(height: 24),

//                         AnimatedBuilder(
//                           animation: listenable,
//                           builder: (context, child) {
//                             final isLoading = loginController
//                                 .processStatusNotifier
//                                 .status is LoadingStatus;
//                             final canSubmit =
//                                 loginController.canSubmit && !isLoading;
//                             return SizedBox(
//                               width: double.infinity,
//                               height: 56,
//                               child: ElevatedButton(
//                                 onPressed: canSubmit
//                                     ? () async {
//                                         final success =
//                                             await loginController.login(
//                                           needVerification: () {
//                                             if (!mounted) return;
//                                             Navigator.push(
//                                               context,
//                                               MaterialPageRoute(
//                                                 builder: (context) =>
//                                                     OtpVerifyScreen(
//                                                   contact:
//                                                       loginController.emailOrId,
//                                                 ),
//                                               ),
//                                             );
//                                           },
//                                         );
//                                         if (!mounted) return;
//                                         if (success) {
//                                           Navigator.push(
//                                             context,
//                                             MaterialPageRoute(
//                                               builder: (context) =>
//                                                   HomeScreentest(),
//                                             ),
//                                           );
//                                         }
//                                       }
//                                     : null,
//                                 style: ElevatedButton.styleFrom(
//                                   backgroundColor: Color(0xFF01676C),
//                                   foregroundColor: Colors.white,
//                                   elevation: 0,
//                                   shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(16),
//                                   ),
//                                 ),
//                                 child: isLoading
//                                     ? const SizedBox(
//                                         width: 22,
//                                         height: 22,
//                                         child: CircularProgressIndicator(
//                                           strokeWidth: 2,
//                                           valueColor:
//                                               AlwaysStoppedAnimation<Color>(
//                                             Colors.white,
//                                           ),
//                                         ),
//                                       )
//                                     : const Text(
//                                         'Login',
//                                         style: TextStyle(
//                                           fontSize: 16,
//                                           fontWeight: FontWeight.w600,
//                                         ),
//                                       ),
//                               ),
//                             );
//                           },
//                         ),

//                         const SizedBox(height: 20),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             const Text(
//                               "Don't have an account? ",
//                               style: TextStyle(
//                                 color: Colors.white70,
//                                 fontSize: 15,
//                               ),
//                             ),
//                             GestureDetector(
//                               onTap: () {
//                                 Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                     builder: (context) => SignupScreen(),
//                                   ),
//                                 );
//                               },
//                               child: const Text(
//                                 'Sign up',
//                                 style: TextStyle(
//                                   color: Color(0xFF00D4AA),
//                                   fontWeight: FontWeight.w600,
//                                   fontSize: 15,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// // }
