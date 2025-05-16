import 'dart:math';

import 'package:draw_straight_line_app/model/provider/shape_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DrawAreaWidget extends StatefulWidget {
  const DrawAreaWidget({super.key});

  @override
  State<DrawAreaWidget> createState() => _DrawAreaWidgetState();
}

class _DrawAreaWidgetState extends State<DrawAreaWidget> {
  Color generateRandomColor() {
    int firstNum = Random().nextInt(256);
    int secondNum = Random().nextInt(256);
    int thirdNum = Random().nextInt(256);
    return Color.fromARGB(255, firstNum, secondNum, thirdNum);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Consumer<ShapeProvider>(
              builder: (context, provider, child) {
                // Return the appropriate CustomPaint based on active shape
                switch (provider.activeShapeIndex) {
                  case 0: // Line
                    return CustomPaint(
                      painter: LinePainter(),
                      size: const Size(300, 300),
                    );
                  case 1: // Circle
                    return CustomPaint(
                      painter: CirclePainter(),
                      size: const Size(300, 300),
                    );
                  case 2: // Triangle
                    return CustomPaint(
                      painter: TrianglePainter(),
                      size: const Size(300, 300),
                    );
                  case 3: // Square
                    return CustomPaint(
                      painter: SquarePainter(),
                      size: const Size(300, 300),
                    );
                  default:
                    return CustomPaint(
                      painter: CirclePainter(),
                      size: const Size(300, 300),
                    );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class CirclePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final paint =
        Paint()
          ..color = const Color(0xFFC7C7CC)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 15.0
          ..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, 140, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class LinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = const Color(0xFFC7C7CC)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 15.0
          ..strokeCap = StrokeCap.round;

    // Draw a horizontal line in the center
    canvas.drawLine(
      Offset(size.width * 0.1, size.height / 2),
      Offset(size.width * 0.9, size.height / 2),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class TrianglePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = const Color(0xFFC7C7CC)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 15.0
          ..strokeJoin = StrokeJoin.round; // Rounded corners

    final path = Path();
    // Start at top center
    path.moveTo(size.width / 2, size.height * 0.1);
    // Bottom right
    path.lineTo(size.width * 0.85, size.height * 0.85);
    // Bottom left
    path.lineTo(size.width * 0.15, size.height * 0.85);
    // Close path back to top
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class SquarePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = const Color(0xFFC7C7CC)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 15.0;

    // Create a rounded rectangle
    final rect = Rect.fromLTWH(
      size.width * 0.15,
      size.height * 0.15,
      size.width * 0.7,
      size.height * 0.7,
    );

    final radius = Radius.circular(20.0); // Rounded corners
    final rrect = RRect.fromRectAndRadius(rect, radius);

    canvas.drawRRect(rrect, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
