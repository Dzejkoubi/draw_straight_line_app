import 'package:draw_straight_line_app/app/router/router.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  App({super.key});

  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _appRouter.config(),
      title: 'Draw Straight Line App',

      debugShowCheckedModeBanner: false,
    );
  }
}
