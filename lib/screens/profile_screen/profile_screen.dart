import 'dart:math' as Math;

import 'package:auto_route/auto_route.dart';
import 'package:draw_straight_line_app/screens/profile_screen/widgets/rate_us_container.dart';
import 'package:draw_straight_line_app/screens/profile_screen/widgets/rotating_widget.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

@RoutePage()
class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

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
      body: UserBoard(),
    );
  }
}

class UserBoard extends StatefulWidget {
  UserBoard({super.key});

  final _future = Supabase.instance.client.from('instruments').select();

  @override
  State<UserBoard> createState() => _UserBoardState();
}

class _UserBoardState extends State<UserBoard> with TickerProviderStateMixin {
  late AnimationController _rotateAnimationController;
  // late Animation<double> _curvedRotateAnimation = CurvedAnimation(
  //   parent: _rotateAnimationController,
  //   curve: Curves.easeOut,
  // );

  @override
  void initState() {
    _rotateAnimationController = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    )..repeat();

    _rotateAnimationController.repeat();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: widget._future,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator.adaptive());
        }
        final instruments = snapshot.data!;
        return Column(
          children: [
            RateUsContainer(),
            Divider(),
            Expanded(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RotationWidget(
                        rotateAnimationController: _rotateAnimationController,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _rotateAnimationController.dispose();
    super.dispose();
  }
}

// class SquashBoxTween extends StatefulWidget {
//   final Widget child;
//   const SquashBoxTween({super.key, required this.child});

//   @override
//   State<SquashBoxTween> createState() => _SquashBoxTweenState();
// }

// class _SquashBoxTweenState extends State<SquashBoxTween> {
//   bool _squashed = false;

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         ElevatedButton(
//           child: Text(_squashed ? 'Un-squash' : 'Squash'),
//           onPressed: () => setState(() => _squashed = !_squashed),
//         ),
//         TweenAnimationBuilder<double>(
//           tween: Tween(begin: 1.0, end: _squashed ? 0.0 : 1.0),
//           duration: const Duration(milliseconds: 300),
//           curve: Curves.easeInOut,
//           builder: (context, scaleY, child) {
//             return Transform(
//               alignment: Alignment.center,
//               transform: Matrix4.diagonal3Values(1, scaleY, 1),
//               child: child,
//             );
//           },
//           child: widget.child,
//         ),
//       ],
//     );
//   }
// }
