import 'package:flutter/material.dart';

class PasswordField extends StatelessWidget {
  const PasswordField({
    super.key,
    required this.hintText,
    required this.isVisible,
    required this.onToggle,
    this.controller,
    this.onChanged,
  });

  final String hintText;
  final bool isVisible;
  final VoidCallback onToggle;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: !isVisible,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hintText,
        filled: true,
        fillColor: Color(0xffFFFFFF).withOpacity(0.1),
        prefixIcon: const Icon(Icons.lock_outline,color: Color(0xFFB4B4B4),),
        suffixIcon: IconButton(
          icon: Icon(isVisible ? Icons.visibility : Icons.visibility_off),
          onPressed: onToggle,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Color(0xFFD0D0D0)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Color(0xFFD0D0D0)),
        ),
        hintStyle: const TextStyle(color: Color(0xFFB4B4B4)),
      ),
    );
  }
}
