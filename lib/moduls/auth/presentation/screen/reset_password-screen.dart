// import 'dart:ui';
// import 'package:dana_bozzetto/core/common/common/textfield.dart';
// import 'package:dana_bozzetto/core/notifiers/button_status_notifier.dart';
// import 'package:dana_bozzetto/core/notifiers/snackbar_notifier.dart';
// import 'package:dana_bozzetto/moduls/auth/controller/reset_password_controller.dart';
// import 'package:dana_bozzetto/moduls/auth/presentation/screen/login_screen.dart';
// import 'package:flutter/material.dart';

// class ResetPasswordscreen extends StatefulWidget {
//   final String? email;

//   const ResetPasswordscreen({
//     super.key,
//     this.email,
//   });

//   @override
//   State<ResetPasswordscreen> createState() => _ResetPasswordscreenState();
// }

// class _ResetPasswordscreenState extends State<ResetPasswordscreen> {
//   final newPasswordController = TextEditingController();
//   final confirmPasswordController = TextEditingController();
//   late final ResetPasswordController resetController;
//   late final SnackbarNotifier snackbarNotifier;
//   bool rememberMe = false;

//   @override
//   void initState() {
//     super.initState();
//     snackbarNotifier = SnackbarNotifier(context: context);
//     resetController = ResetPasswordController(snackbarNotifier);
//     if (widget.email != null && widget.email!.isNotEmpty) {
//       resetController.email = widget.email!;
//     }
//   }

//   @override
//   void dispose() {
//     newPasswordController.dispose();
//     confirmPasswordController.dispose();
//     resetController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final listenable = Listenable.merge(
//       [resetController, resetController.processStatusNotifier],
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
//                           "Create New Password",
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 20,
//                             fontWeight: FontWeight.w500,
//                           ),
//                         ),
//                         SizedBox(height: 16),
//                         LabeledTextField(
//                           isPassword: true,
//                           hintText: "New Password",
//                           prefixIcon: Icons.lock_open_rounded,
//                           controller: newPasswordController,
//                           onChanged: (value) =>
//                               resetController.newPassword = value,
//                         ),
//                         LabeledTextField(
//                           hintText: "Confirm Password",
//                           prefixIcon: Icons.lock_open_rounded,
//                           controller: confirmPasswordController,
//                           isPassword: true,
//                           onChanged: (value) =>
//                               resetController.confirmPassword = value,
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
//                           ],
//                         ),

//                         const SizedBox(height: 24),

//                         AnimatedBuilder(
//                           animation: listenable,
//                           builder: (context, child) {
//                             final isLoading = resetController
//                                 .processStatusNotifier
//                                 .status is LoadingStatus;
//                             final canSubmit =
//                                 resetController.canReset() && !isLoading;
//                             return SizedBox(
//                               width: double.infinity,
//                               height: 56,
//                               child: ElevatedButton(
//                                 onPressed: canSubmit
//                                     ? () async {
//                                         await resetController.resetPassword(
//                                           onSuccess: () {
//                                             if (!mounted) return;
//                                             Navigator.push(
//                                               context,
//                                               MaterialPageRoute(
//                                                 builder: (context) =>
//                                                     LoginScreen(),
//                                               ),
//                                             );
//                                           },
//                                         );
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
//                                         'Reset Password',
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
