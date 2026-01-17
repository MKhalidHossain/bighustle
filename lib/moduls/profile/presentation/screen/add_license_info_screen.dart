import 'package:flutter/material.dart';

const Color _fieldBorderColor = Color(0xFFBDBDBD);
const Color _fieldHintColor = Color(0xFF9A9A9A);
const Color _fieldLabelColor = Color(0xFF222222);
const Color _primaryBlue = Color(0xFF1976F3);

class AddLicenseInfoScreen extends StatelessWidget {
  const AddLicenseInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black87),
        title: const Text(
          'Add Your License Info',
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          children: [
            const Text(
              'Personal Info',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 18),
            const _LabeledInput(
              label: 'Name',
              hintText: 'Write here',
            ),
            const SizedBox(height: 14),
            const _LabeledInput(
              label: 'User Photo',
              hintText: 'Select a file (jpg/png)',
              readOnly: true,
              suffixIcon: const Icon(
                Icons.attach_file,
                color: Color(0xFF4A4A4A),
              ),
            ),
            const SizedBox(height: 14),
            const _LabeledInput(
              label: 'License Number',
              hintText: 'Write here',
            ),
            const SizedBox(height: 14),
            const _LabeledInput(
              label: 'State',
              hintText: 'Select State',
              readOnly: true,
              suffixIcon: const Icon(
                Icons.keyboard_arrow_down_rounded,
                color: Color(0xFF4A4A4A),
              ),
            ),
            const SizedBox(height: 14),
            const _LabeledInput(
              label: 'Expiration Date',
              hintText: 'MM/DD/YYYY',
            ),
            const SizedBox(height: 14),
            const _LabeledInput(
              label: 'License Class',
              hintText: 'Select State',
              readOnly: true,
              suffixIcon: const Icon(
                Icons.keyboard_arrow_down_rounded,
                color: Color(0xFF4A4A4A),
              ),
            ),
            const SizedBox(height: 14),
            const _LabeledInput(
              label: 'Upload License Photo',
              hintText: 'Select a file (jpg/png)',
              readOnly: true,
              suffixIcon: const Icon(
                Icons.attach_file,
                color: Color(0xFF4A4A4A),
              ),
            ),
            const SizedBox(height: 26),
            SizedBox(
              height: 50,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: _primaryBlue,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Submit',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

class _LabeledInput extends StatelessWidget {
  const _LabeledInput({
    required this.label,
    required this.hintText,
    this.readOnly = false,
    this.suffixIcon,
    this.keyboardType,
  });

  final String label;
  final String hintText;
  final bool readOnly;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: _fieldLabelColor,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          readOnly: readOnly,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: const TextStyle(color: _fieldHintColor),
            suffixIcon: suffixIcon,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 12,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: _fieldBorderColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: _fieldBorderColor),
            ),
          ),
        ),
      ],
    );
  }
}
