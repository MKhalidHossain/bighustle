// import 'dart:ui';

// import 'package:flutter/material.dart';
// import 'package:flutter_bighustle/core/notifiers/snackbar_notifier.dart';
// import 'package:flutter_bighustle/moduls/auth/controller/email_verify_controller.dart';


// class EmailVerifyScreen extends StatefulWidget {
//   final String email;

//   const EmailVerifyScreen({
//     super.key,
//     required this.email,
//   });

//   @override
//   State<EmailVerifyScreen> createState() => _EmailVerifyScreenState();
// }

// class _EmailVerifyScreenState extends State<EmailVerifyScreen> {
//   late final EmailVerifyController verifyController;
//   late final SnackbarNotifier snackbarNotifier;
//   int resendTime = 45;

//   @override
//   void initState() {
//     super.initState();
//     snackbarNotifier = SnackbarNotifier(context: context);
//     verifyController = EmailVerifyController(snackbarNotifier);
//     verifyController.email = widget.email;
//     startTimer();
//   }

//   void startTimer() {
//     Future.doWhile(() async {
//       if (resendTime == 0) return false;
//       await Future.delayed(const Duration(seconds: 1));
//       setState(() => resendTime--);
//       return true;
//     });
//   }

//   @override
//   void dispose() {
//     verifyController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final listenable = Listenable.merge(
//       [verifyController, verifyController.processStatusNotifier],
//     );

//     final defaultPinTheme = PinTheme(
//       width: 50,
//       height: 50,
//       textStyle: const TextStyle(
//         fontSize: 22,
//         color: Colors.white,
//         fontWeight: FontWeight.w600,
//       ),
//       decoration: BoxDecoration(
//         color: Colors.black.withOpacity(.35),
//         borderRadius: BorderRadius.circular(40),
//         border: Border.all(color: Colors.white24),
//       ),
//     );

//     return Scaffold(
//       backgroundColor: Colors.black,
//       extendBodyBehindAppBar: true,
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         foregroundColor: Colors.white,
//         title: const Text(
//           "Verify Your Email",
//           style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
//         ),
//       ),
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
//               padding: const EdgeInsets.symmetric(horizontal: 24),
//               child: ClipRRect(
//                 borderRadius: BorderRadius.circular(16),
//                 child: BackdropFilter(
//                   filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
//                   child: Container(
//                     width: double.infinity,
//                     padding: const EdgeInsets.fromLTRB(24, 24, 24, 32),
//                     decoration: BoxDecoration(
//                       color: Colors.white.withOpacity(0.12),
//                       borderRadius: BorderRadius.circular(16),
//                       border: Border.all(
//                         color: Colors.white.withOpacity(0.25),
//                         width: 1.2,
//                       ),
//                     ),
//                     child: Column(
//                       mainAxisSize: MainAxisSize.min,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         const Text(
//                           "Please check your email for a message with your code. "
//                           "Your code is 6 numbers long.",
//                           style: TextStyle(color: Colors.white70, fontSize: 14),
//                         ),
//                         const SizedBox(height: 20),
//                         Center(
//                           child: Pinput(
//                             length: 6,
//                             obscureText: true,
//                             defaultPinTheme: defaultPinTheme,
//                             onChanged: (value) => verifyController.otp = value,
//                             onCompleted: (value) =>
//                                 verifyController.otp = value,
//                           ),
//                         ),
//                         const SizedBox(height: 16),
//                         Center(
//                           child: Text(
//                             "Resend code in ${resendTime}s",
//                             style: const TextStyle(
//                               color: Colors.white70,
//                               fontSize: 14,
//                             ),
//                           ),
//                         ),
//                         const SizedBox(height: 30),
//                         AnimatedBuilder(
//                           animation: listenable,
//                           builder: (context, child) {
//                             final isLoading = verifyController
//                                 .processStatusNotifier
//                                 .status is LoadingStatus;
//                             final canSubmit =
//                                 verifyController.canVerify() && !isLoading;
//                             return SizedBox(
//                               width: double.infinity,
//                               height: 56,
//                               child: ElevatedButton(
//                                 onPressed: canSubmit
//                                     ? () async {
//                                         await verifyController.verifyEmail(
//                                           onSuccess: () {
//                                             if (!mounted) return;
//                                             Navigator.push(
//                                               context,
//                                               MaterialPageRoute(
//                                                 builder: (context) =>
//                                                     const LoginScreen(),
//                                               ),
//                                             );
//                                           },
//                                         );
//                                       }
//                                     : null,
//                                 style: ElevatedButton.styleFrom(
//                                   backgroundColor: const Color(0xFF01676C),
//                                   foregroundColor: Colors.white,
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
//                                         "Continue",
//                                         style: TextStyle(
//                                           fontSize: 16,
//                                           fontWeight: FontWeight.w600,
//                                         ),
//                                       ),
//                               ),
//                             );
//                           },
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
