import 'package:auto_route/auto_route.dart';
import 'package:draw_straight_line_app/screens/profile_screen/widgets/rate_us_container.dart';
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
      body: UserBoard(),
    );
  }
}

class UserBoard extends StatefulWidget {
  const UserBoard({super.key});

  @override
  State<UserBoard> createState() => _UserBoardState();
}

class _UserBoardState extends State<UserBoard> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [RateUsContainer(), Divider(), Expanded(child: Boxes())],
    );
  }
}

class Boxes extends StatefulWidget {
  const Boxes({super.key});

  @override
  State<Boxes> createState() => _BoxesState();
}

class _BoxesState extends State<Boxes> with TickerProviderStateMixin {
  final Duration animaitonDuration = const Duration(milliseconds: 1000);
  final List<BoxData> _initialData = [
    BoxData('Animation Controller', Color(0xFFF1D9FF)),
    BoxData('AnimatedWidget', Color(0xFFD2E4FF)),
    BoxData('Animation Builder', Color(0xFFD2E4FF)),
    BoxData('Tween', Color(0xFFD2E4FF)),
  ];

  final List<BoxData> _endData = [
    BoxData('Tween', Color(0xFFD2E4FF)),
    BoxData('Curve', Color(0xFFD2E4FF)),
    BoxData('Animation Controller', Color(0xFFD2E4FF)),
    BoxData('AnimatedWidget', Color(0xFFD2E4FF)),
  ];

  late List<bool> _boxesChanged;
  late List<AnimationController> _controllers;
  late List<Animation<double>> _scaleYAnimationsData;

  @override
  void initState() {
    super.initState();

    _boxesChanged = List.generate(_initialData.length, (_) => false);

    _controllers = List.generate(
      _initialData.length,
      (_) => AnimationController(vsync: this, duration: animaitonDuration),
    );

    _scaleYAnimationsData = List.generate(_initialData.length, (index) {
      return Tween<double>(begin: 1.0, end: 0.0).animate(
        CurvedAnimation(parent: _controllers[index], curve: Curves.easeInOut),
      );
    });

    // Start the animations with a delay for each box
    for (int i = 0; i < _controllers.length; i++) {
      final int boxIndex = i; // Capture the index for the closure
      Future.delayed(Duration(milliseconds: i * 500), () {
        if (mounted) {
          // Add listener to detect when box is smallest
          _controllers[i].addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              // Animation just reached its end (smallest point)
              setState(() {
                _boxesChanged[boxIndex] = true;
              });
            }
          });

          // Run the animation forward and then reverse it once
          _controllers[i].forward().then((_) {
            if (mounted) {
              _controllers[i].reverse();
            }
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      padding: const EdgeInsets.all(16),
      childAspectRatio: 2.0,
      crossAxisCount: 2,
      mainAxisSpacing: 20,
      crossAxisSpacing: 20,
      children: List.generate(_initialData.length, (index) {
        return AnimatedBuilder(
          animation: _controllers[index],
          builder: (context, child) {
            final data =
                _boxesChanged[index] ? _endData[index] : _initialData[index];

            return Transform.scale(
              alignment: Alignment.center,
              scaleY: _scaleYAnimationsData[index].value,
              child: Container(
                height: 100,
                decoration: BoxDecoration(
                  color: data.color,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 5,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                alignment: Alignment.center,
                child:
                    _scaleYAnimationsData[index].value > 0.05
                        ? Text(
                          data.title,
                          style: const TextStyle(color: Colors.black),
                        )
                        : null,
              ),
            );
          },
        );
      }),
    );
  }
}

class BoxData {
  final String title;
  final Color color;

  BoxData(this.title, this.color);
}
