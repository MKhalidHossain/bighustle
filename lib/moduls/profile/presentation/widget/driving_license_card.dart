import 'package:flutter/material.dart';

class DrivingLicenseCard extends StatelessWidget {
  const DrivingLicenseCard({super.key, required this.imageAssetPath});

  final String imageAssetPath;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Container(
        height: 150,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: const Color(0xFFE0E0E0)),
        ),
        child: imageAssetPath.isEmpty
            ? const SizedBox.shrink()
            : Image.asset(
                imageAssetPath,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => const SizedBox.shrink(),
              ),
      ),
    );
  }
}
