import 'package:auto_route/annotations.dart';
import 'package:draw_straight_line_app/main.dart';
import 'package:flutter/material.dart';

@RoutePage()
class GameScreen extends StatelessWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('write a STRAIGHT line'),
        centerTitle: true,
        actions: [
          IconButton(icon: const Icon(Icons.arrow_back), onPressed: () {}),
        ],
      ),
      body: Center(
        child: Container(
          width: 200, // Length of the line
          height: 10, // Thickness of the line
          decoration: BoxDecoration(
            color: const Color.fromARGB(
              255,
              199,
              199,
              204,
            ), // Color of the line
            borderRadius: BorderRadius.circular(5), // Rounded edges
          ),
        ),
      ),
    );
  }
}
