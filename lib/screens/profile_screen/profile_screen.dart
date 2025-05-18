import 'dart:math' as Math;

import 'package:auto_route/auto_route.dart';
import 'package:draw_straight_line_app/screens/profile_screen/widgets/rate_us_container.dart';
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

class _UserBoardState extends State<UserBoard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleYAnimation;

  bool _onFirst = true;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    _scaleYAnimation = Tween<double>(
      begin: 1.0,
      end: 0.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        setState(() => _onFirst = !_onFirst);
        _controller.forward();
      }
    });

    // _controller.addListener(() {
    //   print('Animation value: ${_scaleYAnimation.value}');
    // });

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
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
                      Expanded(
                        child: AnimatedBuilder(
                          animation: _controller,
                          builder: (context, child) {
                            final atMin = _scaleYAnimation.value < 0.5;
                            return Transform(
                              alignment: Alignment.center,
                              transform:
                                  Matrix4.identity()
                                    ..scale(1.0, _scaleYAnimation.value, 1.0),
                              child: Container(
                                margin: const EdgeInsets.all(10),
                                padding: const EdgeInsets.symmetric(
                                  vertical: 32,
                                  horizontal: 16,
                                ),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color:
                                      _onFirst
                                          ? const Color(0xFFD2E4FF)
                                          : const Color(0xFFF1D9FF),
                                  borderRadius: BorderRadius.circular(16),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.3),
                                      offset: const Offset(0, 3),
                                      blurRadius: 2,
                                    ),
                                  ],
                                ),
                                child: Text(
                                  _onFirst ? 'Tween' : 'Animation Controller',
                                  style: const TextStyle(color: Colors.black),
                                  maxLines: 1,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      Expanded(child: Container()),
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
}
