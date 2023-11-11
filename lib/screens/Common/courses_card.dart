import 'package:flutter/material.dart';

import '../../ui/colors.dart';

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
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: AppColors.backgroundColorDark,
        ),
        child: ListView(
          /*mainAxisSize: MainAxisSize.min,*/
          addAutomaticKeepAlives: true,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          children: [
            // Image
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10.0),
                topRight: Radius.circular(10.0),
              ),
              child: Image.network(
                imageUrl,
                width: double.infinity,
                height: 150,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 10.0),
            // Title
            Container(
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10.0),
                  Text(
                    title,
                  ),
                  const SizedBox(height: 5.0),
                  // Heading
                  Text(
                    heading,
                    style: const TextStyle(
                        fontSize: 16.0, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10.0),
                  // Rating
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            rating.toString(),
                          ),
                          Icon(
                            Icons.star,
                            color: Colors.grey,
                            size: 14,
                          ),
                        ],
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primaryColor),
                        onPressed: () {
                          onButtonPressed;
                        },
                        child: Text("Enroll now"),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10.0),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
