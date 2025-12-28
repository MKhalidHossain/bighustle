// import 'dart:async';
// import 'package:flutter_bighustle/core/constants/api_endpoints.dart';
// import 'package:flutter_bighustle/core/helpers/auth_role.dart';
// import 'package:flutter_bighustle/core/services/app_pigeon/app_pigeon.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get/get_rx/src/rx_workers/utils/debouncer.dart';
// class AppManager extends GetxController {
//   AuthStatus _authStatus = AuthLoading();
//   AuthStatus get currentAuthStatus => _authStatus;
//   Debouncer authDebouncer = Debouncer(delay: const Duration(milliseconds: 100));

//   /// Initializes the stream to listen to auth status
//   AppManager() {
//     _init();
//   }

//   // listen to auth change
//   void _init() async {
//     debugPrint("AppManager initialized");

//     await Get.find<AppPigeon>().currentAuth().then((initialAuthStatus) {
//       _decideRoute(initialAuthStatus);
//     });

//     // Start listening to the auth status changes
//   }

//   void _decideRoute(AuthStatus? authStatus) async {
//     if (authStatus is UnAuthenticated) {
//       _authStatus = authStatus;
//       Get.to(() => SignupScreen());
//       // navigatorKey.currentState?.pushNamedAndRemoveUntil(
//       //   RouteNames.login,
//       //   (route) => false,
//       // );
//     } else if (authStatus is Authenticated) {
//       debugPrint(
//         "currentAuthStatus: $_authStatus, beforeAuthStatus: $authStatus",
//       );
//       debugPrint(
//         "New auth:: ${!(currentAuthStatus is Authenticated && (authStatus).auth.userId != (currentAuthStatus as Authenticated).auth.userId)}",
//       );
//       _authStatus = authStatus;
//       await _initializeControllers();
//       if (Get.isRegistered<ProfileController>()) {
//         Get.delete<ProfileController>();
//       }
//       Get.put(ProfileController(repo: Get.find()));
//       Get.to(() => AppGround());

//       // navigatorKey.currentState?.pushNamedAndRemoveUntil(
//       //   RouteNames.home,
//       //   (route) => false,
//       // );
//     }
//     update();
//     // if (authStatus != null && authStatus != _authStatus) {
//     //   debugPrint("(In Appmanager)Auth status: $authStatus");

//     // }
//   }

//   // initiate controllers on auth change[Authenticated]
//   Future<void> _initializeControllers() async {
//     if ((currentAuthStatus as Authenticated).auth.userId.isNotEmpty) {
//       await Get.find<AppPigeon>()
//           .socketInit(
//             SocketConnetParamX(
//               token: null,
//               socketUrl: ApiEndpoints.socketUrl,
//               joinId: (currentAuthStatus as Authenticated).auth.userId,
//             ),
//           )
//           .then((_) async {
//             Get.find<AppPigeon>().emit(
//               "join",
//               ((currentAuthStatus as Authenticated).auth.userId),
//             );
//             // if (Get.isRegistered<AppGlobalControllers>()) {
//             //   await Get.delete<AppGlobalControllers>();
//             // }

//             // Get.put<AppGlobalControllers>(
//             //   AppGlobalControllers(),
//             // );
//           });
//     }
//   }
// }
