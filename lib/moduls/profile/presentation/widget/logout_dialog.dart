import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:flutter_bighustle/core/services/app_pigeon/app_pigeon.dart';
import 'package:flutter_bighustle/moduls/auth/interface/auth_interface.dart';
import 'package:flutter_bighustle/moduls/auth/model/logout_request_model.dart';
import 'package:flutter_bighustle/moduls/auth/presentation/screen/login_screen.dart';

const Color _primaryBlue = Color(0xFF2D6BFF);

Future<void> _performLogout(BuildContext context) async {
  final appPigeon = Get.find<AppPigeon>();
  final status = await appPigeon.currentAuth();
  final refreshToken =
      status is Authenticated ? status.auth.refreshToken ?? '' : '';
  await Get.find<AuthInterface>().logout(
    param: LogoutRequestModel(refreshToken: refreshToken),
  );
  if (!context.mounted) {
    return;
  }
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (_) => const LoginScreen()),
    (route) => false,
  );
}

void showLogoutDialog(BuildContext context) {
  showDialog<void>(
    context: context,
    builder: (dialogContext) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        title: const Text(
          'Are you sure want to Log Out?',
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        contentPadding: const EdgeInsets.fromLTRB(24, 12, 24, 24),
        content: Row(
          children: [
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: _primaryBlue,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () => Navigator.pop(dialogContext),
                child: const Text('Cancel'),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.red,
                  side: const BorderSide(color: Color(0xFFFFB3B3)),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  backgroundColor: const Color(0xFFFFF2F2),
                ),
                onPressed: () {
                  Navigator.pop(dialogContext);
                  _performLogout(context);
                },
                child: const Text('Log Out'),
              ),
            ),
          ],
        ),
      );
    },
  );
}
