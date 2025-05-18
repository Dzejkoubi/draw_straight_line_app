import 'dart:math' as Math;

import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:draw_straight_line_app/main.dart';
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

class _UserBoardState extends State<UserBoard> {
  bool isToggled = true;

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
              child: ListView.builder(
                itemCount: instruments.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        isToggled = !isToggled;
                      });
                    },
                    child: AnimatedItem(instruments, index),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }

  AnimatedContainer AnimatedItem(PostgrestList instruments, int index) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      margin: EdgeInsets.all(10),
      padding: isToggled ? EdgeInsets.all(10) : EdgeInsets.all(50),
      curve: Curves.easeInSine,
      decoration: BoxDecoration(
        borderRadius:
            isToggled ? BorderRadius.circular(5) : BorderRadius.circular(25),
        boxShadow:
            isToggled
                ? [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ]
                : [],
        color: isToggled ? Colors.blue : Colors.lightBlueAccent,
      ),
      child: Text(instruments[index]['name']),
    );
  }
}

class RateUsContainer extends StatefulWidget {
  RateUsContainer({super.key});

  @override
  State<RateUsContainer> createState() => _RateUsContainerState();
}

class _RateUsContainerState extends State<RateUsContainer> {
  List<bool> isStarred = [false, false, false, false, false];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      child: Column(
        children: [
          Text('Rate us'),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(child: SizedBox()),
              for (int i = 0; i < isStarred.length; i++)
                IconButton(
                  onPressed: () {
                    setState(() {
                      if (isStarred[i] &&
                          (i == isStarred.lastIndexWhere((star) => star))) {
                        for (int j = 0; j < isStarred.length; j++) {
                          isStarred[j] = false;
                        }
                      } else {
                        isStarred[i] = !isStarred[i];
                        for (int j = 0; j < isStarred.length; j++) {
                          if (j < i) {
                            isStarred[j] = true;
                          } else if (j > i) {
                            isStarred[j] = false;
                          }
                        }
                      }
                    });
                  },
                  icon: TweenAnimationBuilder<double>(
                    tween: Tween(
                      begin: isStarred[i] ? 20.0 : 30.0,
                      end: isStarred[i] ? 30 : 20,
                    ),
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeOut,
                    builder: (context, size, child) {
                      return TweenAnimationBuilder<double>(
                        tween: Tween(
                          begin: 0,
                          end:
                              isStarred[i]
                                  ? 360 * Math.pi / 180
                                  : 36 * Math.pi / 180,
                        ),
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeOut,
                        builder: (context, rotation, _) {
                          return Transform.rotate(
                            angle: rotation,
                            child: Icon(
                              Icons.star,
                              size: size,
                              color: isStarred[i] ? Colors.amber : Colors.grey,
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              Expanded(
                child: TextButton(onPressed: () {}, child: Text('Send')),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
