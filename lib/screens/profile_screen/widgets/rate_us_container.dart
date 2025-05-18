import 'dart:math' as Math;

import 'package:flutter/material.dart';

class RateUsContainer extends StatefulWidget {
  RateUsContainer({super.key});

  @override
  State<RateUsContainer> createState() => _RateUsContainerState();
}

class _RateUsContainerState extends State<RateUsContainer> {
  List<bool> isStarred = [false, false, false, false, false];

  bool _showButton = false;

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
                      _showButton = isStarred.contains(true);
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
                child: IgnorePointer(
                  ignoring: !_showButton,
                  child: AnimatedOpacity(
                    // key: ValueKey<bool>(_showButton),
                    opacity: _showButton ? 1 : 0,
                    duration: Duration(milliseconds: 300),
                    child: TextButton(
                      // key: ValueKey<bool>(_showButton),
                      onPressed: () {
                        //TODO: Send feedback
                      },
                      child: Text(
                        'Send',
                        style: TextStyle(color: Colors.blueGrey),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
