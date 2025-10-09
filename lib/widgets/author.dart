import 'package:flutter/material.dart';
import 'package:lavij/widgets/KurdishText.dart';

class Author extends StatelessWidget {
  const Author({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          children: [
            KurdishText(
              text: 'موسی اسعد ابراهيم',
              fontSize: 18,
            ),
            KurdishText(
              text: ' مامۆستایێ هاریكار',
              fontSize: 18,
            ),
          ],
        ),
        SizedBox(width: 30), // space between text and image
        // square image
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            image: DecorationImage(
              image: AssetImage('assets/author_image.jpeg'),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ],
    );
  }
}
