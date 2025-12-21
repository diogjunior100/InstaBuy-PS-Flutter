import 'package:flutter/material.dart';
import '../../data/models/product_model.dart';

class ProductCard extends StatelessWidget {
  final ProductModel productModel;

  const ProductCard({
    super.key,
    required this.productModel,
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
              child: productModel.imageUrl != null
                  ? Image.network(
                      productModel.imageUrl!,
                      height: 80,
                      width: 80,
                      fit: BoxFit.cover,
                      errorBuilder: (ctx, error, stack) =>
                          const Icon(Icons.image_not_supported, size: 60),
                    )
                  : const Icon(Icons.image_not_supported, size: 60),
            ),

            const SizedBox(width: 16),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    productModel.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "R\$ $productModel.price",
                    style: const TextStyle(
                      fontSize: 15,
                      color: Colors.green,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
