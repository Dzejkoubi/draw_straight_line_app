import 'package:flutter/material.dart';

class RotationWidget extends StatelessWidget {
  const RotationWidget({
    super.key,
    required AnimationController rotateAnimationController,
  }) : _rotateAnimationController = rotateAnimationController;

  final AnimationController _rotateAnimationController;

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: _rotateAnimationController,
      alignment: Alignment.center,
      child: Container(
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 32),
        decoration: BoxDecoration(
          color: const Color(0xFFB8D3FF),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.3),
              offset: Offset(0, 3),
              blurRadius: 2,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Text('Animation widget')],
        ),
      ),
    );
  }
}
