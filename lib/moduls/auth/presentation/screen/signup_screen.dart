// import 'dart:ui';
// import 'package:dana_bozzetto/core/common/common/textfield.dart';
// import 'package:dana_bozzetto/core/notifiers/snackbar_notifier.dart';
// import 'package:dana_bozzetto/moduls/auth/controller/register_controller.dart';
// import 'package:dana_bozzetto/moduls/auth/presentation/screen/email_verify_screen.dart';
// import 'package:dana_bozzetto/moduls/auth/presentation/screen/login_screen.dart';
// import 'package:flutter/material.dart';

// class SignupScreen extends StatefulWidget {
//   const SignupScreen({super.key});

//   @override
//   State<SignupScreen> createState() => _SignupScreenState();
// }

// class _SignupScreenState extends State<SignupScreen> {
//   final nameController = TextEditingController();
//   final employeeIdController = TextEditingController();
//   final emailController = TextEditingController();
//   final roleController = TextEditingController();
//   final passwordController = TextEditingController();
//   final confirmPasswordController = TextEditingController();
//   late final RegisterScreenController registerController;
//   late final SnackbarNotifier snackbarNotifier;

//   @override
//   void initState() {
//     super.initState();
//     snackbarNotifier = SnackbarNotifier(context: context);
//     registerController = RegisterScreenController(snackbarNotifier);
//     roleController.text = 'team_member';
//     registerController.role = roleController.text;
//   }

//   @override
//   void dispose() {
//     nameController.dispose();
//     employeeIdController.dispose();
//     emailController.dispose();
//     roleController.dispose();
//     passwordController.dispose();
//     confirmPasswordController.dispose();
//     registerController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
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
//                           "Create New Account",
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 20,
//                             fontWeight: FontWeight.w500,
//                           ),
//                         ),
//                         SizedBox(height: 16),
//                         LabeledTextField(
//                           hintText: "Enter Your Name",
//                           prefixIcon: Icons.person_outline_rounded,
//                           controller: nameController,
//                           onChanged: (value) => registerController.name = value,
//                         ),
//                         LabeledTextField(
//                           hintText: "Enter Your Employee ID",
//                           prefixIcon: Icons.person_outline_rounded,
//                           controller: employeeIdController,
//                           onChanged: (value) =>
//                               registerController.employeeId = value,
//                         ),
//                         LabeledTextField(
//                           hintText: "Enter Email",
//                           prefixIcon: Icons.email_outlined,
//                           controller: emailController,
//                           onChanged: (value) => registerController.email = value,
//                         ),
//                         LabeledTextField(
//                           hintText: "Enter Role",
//                           prefixIcon: Icons.badge_outlined,
//                           controller: roleController,
//                           onChanged: (value) => registerController.role = value,
//                         ),
//                         LabeledTextField(
//                           isPassword: true,
//                           hintText: "Create Password",
//                           prefixIcon: Icons.lock_open_rounded,
//                           controller: passwordController,
//                           onChanged: (value) =>
//                               registerController.password = value,
//                         ),
//                         LabeledTextField(
//                           hintText: "Confirm Password",
//                           prefixIcon: Icons.lock_open_rounded,
//                           controller: confirmPasswordController,
//                           isPassword: true,
//                           onChanged: (value) =>
//                               registerController.confirmPassword = value,
//                         ),

//                         const SizedBox(height: 24),

//                         AnimatedBuilder(
//                           animation: registerController,
//                           builder: (context, child) {
//                             final canSubmit = registerController.canSubmit &&
//                                 !registerController.isBusy;
//                             return SizedBox(
//                               width: double.infinity,
//                               height: 56,
//                               child: ElevatedButton(
//                                 onPressed: canSubmit
//                                     ? () async {
//                                         await registerController.register(
//                                           onSuccessNavigate: () {
//                                             if (!mounted) return;
//                                             Navigator.push(
//                                               context,
//                                               MaterialPageRoute(
//                                                 builder: (context) =>
//                                                     EmailVerifyScreen(
//                                                   email: registerController.email,
//                                                 ),
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
//                                 child: registerController.isBusy
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
//                                         'Sign Up',
//                                         style: TextStyle(
//                                           fontSize: 16,
//                                           fontWeight: FontWeight.w600,
//                                         ),
//                                       ),
//                               ),
//                             );
//                           },
//                         ),
//                         SizedBox(height: 16),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             const Text(
//                               "you have an account? ",
//                               style: TextStyle(
//                                 color: Colors.white70,
//                                 fontSize: 15,
//                               ),
//                             ),
//                             GestureDetector(
//                               onTap: () {
//                                 Navigator.pop(context);
//                               },
//                               child: const Text(
//                                 'Sign in',
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
