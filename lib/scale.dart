import 'package:flutter/material.dart';

class Scale extends StatefulWidget {
  const Scale({Key? key}) : super(key: key);

  @override
  State<Scale> createState() => _ScaleState();
}

class _ScaleState extends State<Scale> with TickerProviderStateMixin {
  late final AnimationController _logoController, _heartController;
  late final Animation<double> _logoAnimation, _heartAnimation;
  late Animation<Color?> _colorAnimation;

  bool isFav = false;

  @override
  void initState() {
    super.initState();
    // khởi tạo với thời gian xảy ra của animation là 1 giây
    // _logoController sẽ điều khiển scale FlutterLogo
    _logoController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1))
          ..repeat(reverse: true);

    _logoAnimation = CurvedAnimation(
      parent: _logoController,
      curve: Curves.fastOutSlowIn,
    );

    // khởi tạo với thời gian xảy ra của animation là 500 milliseconds
    // _heartController sẽ điều khiển scale up, down trái tim
    _heartController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));

    // _colorAnimation: cho phép thay đổi giá trị màu từ mày grey[400] -> red
    _colorAnimation = ColorTween(begin: Colors.grey[400], end: Colors.red)
        .animate(_heartController);


    _heartAnimation = TweenSequence(<TweenSequenceItem<double>>[
      TweenSequenceItem<double>(
          tween: Tween(begin: 150.0, end: 180.0), weight: 50.0),
      TweenSequenceItem<double>(
          tween: Tween(begin: 180.0, end: 150.0), weight: 50.0),
    ]).animate(
      CurvedAnimation(parent: _heartController, curve: Curves.bounceIn)
    );

    _heartController.addStatusListener((AnimationStatus status) {
      if (status == AnimationStatus.completed) {
        isFav = true;
      } else {
        isFav = false;
      }
    });
  }

  @override
  void dispose() {
    // hủy animation
    _logoController.dispose();
    _heartController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Center(child: Text("Scale Transition")),
          ScaleTransition(
            scale: _logoAnimation,
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: FlutterLogo(size: 150.0),
            ),
          ),
          const SizedBox(height: 10.0),
          const Center(child: Text("Scale up, down Animation")),
          const SizedBox(height: 10.0),
          AnimatedBuilder(
            animation: _heartController,
            builder: (context, child) {
              return IconButton(
                icon: const Icon(Icons.favorite),
                onPressed: () {
                  isFav // nếu isFav = true thì reverse ngược lại thì forward
                      ? _heartController.reverse()
                      : _heartController.forward();
                },
                color: _colorAnimation.value,
                iconSize: _heartAnimation.value,
              );
            },
          ),
        ],
      ),
    );
  }
}
