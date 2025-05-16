import 'package:flutter/material.dart';

class LineSmall extends StatelessWidget {
  const LineSmall({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 5,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 199, 199, 204), // Color of the line
        borderRadius: BorderRadius.circular(2), // Rounded edges
      ),
    );
  }
}
