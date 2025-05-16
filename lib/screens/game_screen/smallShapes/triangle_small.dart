import 'package:flutter/material.dart';

class TriangleSmall extends StatelessWidget {
  const TriangleSmall({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      height: 15,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 199, 199, 204), // Color of the line
        borderRadius: BorderRadius.circular(5), // Rounded edges
      ),
    );
  }
}
