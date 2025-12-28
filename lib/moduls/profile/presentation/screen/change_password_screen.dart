import 'package:flutter/material.dart';

import '../widget/field_label.dart';
import '../widget/password_field.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  bool _oldVisible = false;
  bool _newVisible = false;
  bool _confirmVisible = false;

  static const Color _background = Color(0xFFF2F2F2);
  static const Color _primaryBlue = Color(0xFF2D6BFF);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _background,
      appBar: AppBar(
        backgroundColor: _background,
        elevation: 0,
        leading: const BackButton(color: Colors.black87),
        centerTitle: true,
        title: const Text(
          'Change Password',
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w600),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              children: [
                const FieldLabel(text: 'Old Password'),
                PasswordField(
                  hintText: 'Enter your Old Password',
                  isVisible: _oldVisible,
                  onToggle: () => setState(() => _oldVisible = !_oldVisible),
                ),
                const SizedBox(height: 16),
                const FieldLabel(text: 'New Password'),
                PasswordField(
                  hintText: 'Enter your New Password',
                  isVisible: _newVisible,
                  onToggle: () => setState(() => _newVisible = !_newVisible),
                ),
                const SizedBox(height: 16),
                const FieldLabel(text: 'Confirm Password'),
                PasswordField(
                  hintText: 'Enter your Confirm Password',
                  isVisible: _confirmVisible,
                  onToggle: () =>
                      setState(() => _confirmVisible = !_confirmVisible),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
            child: SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: _primaryBlue,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {},
                child: const Text('Update Password'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
