// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i3;
import 'package:draw_straight_line_app/screens/game_screen/game_screen.dart'
    as _i1;
import 'package:draw_straight_line_app/screens/profile_screen/profile_screen.dart'
    as _i2;

/// generated route for
/// [_i1.GameScreen]
class GameRoute extends _i3.PageRouteInfo<void> {
  const GameRoute({List<_i3.PageRouteInfo>? children})
    : super(GameRoute.name, initialChildren: children);

  static const String name = 'GameRoute';

  static _i3.PageInfo page = _i3.PageInfo(
    name,
    builder: (data) {
      return const _i1.GameScreen();
    },
  );
}

/// generated route for
/// [_i2.ProfileScreen]
class ProfileRoute extends _i3.PageRouteInfo<void> {
  const ProfileRoute({List<_i3.PageRouteInfo>? children})
    : super(ProfileRoute.name, initialChildren: children);

  static const String name = 'ProfileRoute';

  static _i3.PageInfo page = _i3.PageInfo(
    name,
    builder: (data) {
      return const _i2.ProfileScreen();
    },
  );
}
