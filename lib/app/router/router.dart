import 'package:auto_route/auto_route.dart';
import 'package:draw_straight_line_app/app/router/router.gr.dart';
import 'package:draw_straight_line_app/screens/game_screen/game_screen.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: GameRoute.page, initial: true),
    AutoRoute(page: ProfileRoute.page),
  ];
}
