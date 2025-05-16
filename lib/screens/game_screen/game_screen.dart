import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:draw_straight_line_app/model/provider/shape_provider.dart';
import 'package:draw_straight_line_app/screens/game_screen/draw_area_widget.dart';
import 'package:draw_straight_line_app/screens/game_screen/smallShapes/circle_small.dart';
import 'package:draw_straight_line_app/screens/game_screen/smallShapes/line_small.dart';
import 'package:draw_straight_line_app/screens/game_screen/smallShapes/triangle_small.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

@RoutePage()
class GameScreen extends StatelessWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: NewShapeButton(),
        title: const Text('Draw a STRAIGHT line'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              context.router.pushPath('/profile');
            },
          ),
        ],
      ),
      body: SafeArea(child: Center(child: DrawAreaWidget())),
    );
  }
}

class NewShapeButton extends StatelessWidget {
  const NewShapeButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: () {
        switch (context.watch<ShapeProvider>().activeShapeIndex) {
          case 0:
            return const LineSmall();
          case 1:
            return const CircleSmall();
          case 2:
            return const TriangleSmall();
          case 3:
            return const Icon(Icons.square);
          default:
            return const LineSmall();
        }
      }(),
      onPressed: () {
        context.read<ShapeProvider>().changeActiveShape();
        print(
          'Active shape index: ${context.read<ShapeProvider>().activeShapeIndex}',
        );
      },
    );
  }
}
