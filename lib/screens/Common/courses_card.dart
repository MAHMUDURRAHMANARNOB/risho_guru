import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String heading;
  final double rating;
  final VoidCallback onButtonPressed;

  const ProductCard({
    Key? key,
    required this.imageUrl,
    required this.title,
    required this.heading,
    required this.rating,
    required this.onButtonPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Image
            Image.network(imageUrl),
            const SizedBox(height: 10.0),

            // Title
            Text(
              title,
              style:
                  const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5.0),

            // Heading
            Text(heading),
            const SizedBox(height: 10.0),

            // Rating
            Row(
              children: [
                for (int i = 0; i < rating; i++)
                  const Icon(Icons.star, color: Colors.yellow),
              ],
            ),
            const SizedBox(height: 10.0),

            // Button
            ElevatedButton(
              onPressed: onButtonPressed,
              child: const Text('Buy Now'),
            ),
          ],
        ),
      ),
    );
  }
}
