import 'package:flutter/material.dart';

class CircleSmall extends StatelessWidget {
  const CircleSmall({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 199, 199, 204), // Color of the circle
        shape: BoxShape.circle, // Shape of the container
      ),
    );
  }
}
