import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:draw_straight_line_app/main.dart';
import 'package:flutter/material.dart';

@RoutePage()
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            context.router.pop();
          },
        ),
      ),
      body: Center(child: Text("User profile")),
    );
  }
}
