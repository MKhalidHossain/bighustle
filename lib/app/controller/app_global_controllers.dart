// import 'package:flutter_ursffiver/app/controller/home_controller.dart';
// import 'package:flutter_ursffiver/core/common/controller/interest_fetch_controller.dart';
// import 'package:get/get.dart';

// // Why do we need this controller?
// //
// // >>
// // We Want to have a single place to store all the essential information of the app.
// //
// // Instead of managing controllers with [GetX] in every feature, we can manage them here.
// // This way we won't be all controllers will be in one place to inspect.
// class AppGlobalControllers extends GetxController {
//   final AllInterestFetchController interestController =
//       AllInterestFetchController();
//   late final HomeController homeController;
//   void beforeAuthInit() {
//     interestController.fetchInterests();

//     /// Add more controller intialization for essential information of the app
//   }

//   void afterAuthInit() {
//     interestController.fetchInterests();
//     homeController = HomeController();
//     /// Add more controller intialization for essential information of the app
//   }
// }

// import 'package:get/get.dart';
// import 'package:williamharri/app/controller/home_controller.dart';

// class AppGlobalControllers extends GetxController {


//   void clearControllers() {
//     if (Get.isRegistered<HomeController>()) {
//       Get.delete<HomeController>();
//     }
//   }
// }
