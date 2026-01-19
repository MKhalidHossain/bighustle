import 'package:flutter/material.dart';

class DrivingLicenseCard extends StatelessWidget {
  const DrivingLicenseCard({
    super.key,
    this.imageAssetPath = '',
    this.imageUrl = '',
  });

  final String imageAssetPath;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    final hasNetworkImage = imageUrl.isNotEmpty;
    final hasAssetImage = imageAssetPath.isNotEmpty;
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Container(
        height: 150,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: const Color(0xFFE0E0E0)),
        ),
        child: hasNetworkImage
            ? Image.network(
                imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => const SizedBox.shrink(),
              )
            : hasAssetImage
                ? Image.asset(
                    imageAssetPath,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => const SizedBox.shrink(),
                  )
                : const SizedBox.shrink(),
      ),
    );
  }
}
