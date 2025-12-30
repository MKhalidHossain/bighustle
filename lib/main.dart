import 'package:flutter/material.dart';
import 'package:flutter_bighustle/core/constants/app_routes.dart';
import 'package:flutter_bighustle/moduls/auth/presentation/screen/email_verify_screen.dart';
import 'package:flutter_bighustle/moduls/auth/presentation/screen/forget_password.dart';
import 'package:flutter_bighustle/moduls/auth/presentation/screen/login_screen.dart';
import 'package:flutter_bighustle/moduls/auth/presentation/screen/otp_verify_screen.dart';
import 'package:flutter_bighustle/moduls/auth/presentation/screen/reset_password-screen.dart';
import 'package:flutter_bighustle/moduls/auth/presentation/screen/splash_screen.dart';
import 'package:flutter_bighustle/moduls/auth/presentation/screen/signup_screen.dart';
import 'package:flutter_bighustle/moduls/auth/presentation/widget/auth_ui.dart';
import 'package:flutter_bighustle/moduls/home/screen/bottom_nav_screen.dart';
import 'package:flutter_bighustle/moduls/home/screen/learning_center_screen.dart';
import 'package:flutter_bighustle/moduls/home/screen/learning_video_screen.dart';
import 'package:flutter_bighustle/moduls/home/screen/teen_driver_posts_screen.dart';
import 'package:flutter_bighustle/moduls/home/screen/teen_drivers_screen.dart';
import 'package:flutter_bighustle/moduls/license/presentation/screen/edit_license_info_screen.dart';
import 'package:flutter_bighustle/moduls/license/presentation/screen/license_screen.dart';
import 'package:flutter_bighustle/moduls/license/presentation/screen/liscense_alearts_screen.dart';
import 'package:flutter_bighustle/moduls/ticket/presentation/screen/notification_screen.dart';
import 'package:flutter_bighustle/moduls/ticket/presentation/screen/plan_pricing_details_screen.dart';
import 'package:flutter_bighustle/moduls/ticket/presentation/screen/plan_pricing_screen.dart';
import 'package:flutter_bighustle/moduls/ticket/presentation/screen/ticket_details_screen.dart';
import 'package:flutter_bighustle/moduls/ticket/presentation/screen/ticket_screen.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Bighustle',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: AuthColors.background,
        colorScheme: ColorScheme.fromSeed(seedColor: AuthColors.primary),
      ),
      initialRoute: AppRoutes.splash,
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case AppRoutes.splash:
            return MaterialPageRoute(builder: (_) => const SplashScreen());
          case AppRoutes.login:
            return MaterialPageRoute(builder: (_) => const LoginScreen());
          case AppRoutes.signup:
            return MaterialPageRoute(builder: (_) => const SignupScreen());
          case AppRoutes.forgetPassword:
            return MaterialPageRoute(builder: (_) => const ForgetPassword());
          case AppRoutes.otpVerify:
            final contact = settings.arguments is String
                ? settings.arguments as String
                : '';
            return MaterialPageRoute(
              builder: (_) => OtpVerifyScreen(contact: contact),
            );
          case AppRoutes.emailVerify:
            final email = settings.arguments is String
                ? settings.arguments as String
                : '';
            return MaterialPageRoute(
              builder: (_) => EmailVerifyScreen(email: email),
            );
          case AppRoutes.resetPassword:
            final email = settings.arguments is String
                ? settings.arguments as String
                : null;
            return MaterialPageRoute(
              builder: (_) => ResetPasswordscreen(email: email),
            );
          case AppRoutes.home:
            return MaterialPageRoute(builder: (_) => const BottomNavScreen());
          case AppRoutes.teenDrivers:
            return MaterialPageRoute(builder: (_) => const TeenDriversScreen());
          case AppRoutes.teenDriverPosts:
            return MaterialPageRoute(
              builder: (_) => const TeenDriverPostsScreen(),
            );
          case AppRoutes.learningCenter:
            return MaterialPageRoute(
              builder: (_) => const LearningCenterScreen(),
            );
          case AppRoutes.learningVideo:
            return MaterialPageRoute(
              builder: (_) => const LearningVideoScreen(),
            );
          case AppRoutes.license:
            return MaterialPageRoute(builder: (_) => const LicenseScreen());
          case AppRoutes.licenseAlerts:
            return MaterialPageRoute(builder: (_) => const LicenseAlertsScreen());
          case AppRoutes.editLicenseInfo:
            return MaterialPageRoute(builder: (_) => const EditLicenseInfoScreen());
          case AppRoutes.ticket:
            return MaterialPageRoute(builder: (_) => const TicketScreen());
          case AppRoutes.ticketDetails:
            return MaterialPageRoute(builder: (_) => const TicketDetailsScreen());
          case AppRoutes.ticketNotifications:
            return MaterialPageRoute(
              builder: (_) => const TicketNotificationScreen(),
            );
          case AppRoutes.planPricing:
            return MaterialPageRoute(builder: (_) => const PlanPricingScreen());
          case AppRoutes.planPricingDetails:
            return MaterialPageRoute(
              builder: (_) => const PlanPricingDetailsScreen(),
            );
          default:
            return MaterialPageRoute(builder: (_) => const LoginScreen());
        }
      },
    );
  }
}
