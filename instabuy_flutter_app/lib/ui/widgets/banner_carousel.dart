import 'package:flutter/material.dart';

class BannerCarousel extends StatelessWidget {
  final String? imageUrl;

  const BannerCarousel({
    super.key,
    this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: imageUrl != null
                  ? Image.network(
                      imageUrl!,
                      height: 80,
                      width: 80,
                      fit: BoxFit.cover,
                      errorBuilder: (ctx, error, stack) =>
                          const Icon(Icons.image_not_supported, size: 60),
                    )
                  : const Icon(Icons.image_not_supported, size: 60),
            ),

            const SizedBox(width: 16),
          ],
        ),
      ),
    );
  }
}
