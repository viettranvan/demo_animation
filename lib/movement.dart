import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Movement extends StatefulWidget {
  const Movement({Key? key}) : super(key: key);

  @override
  _MovementState createState() => _MovementState();
}

class _MovementState extends State<Movement>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _movementAnimation;

  @override
  void initState() {
    super.initState();
    // khởi tạo thời gian xảy ra của animation là 3s -> gọi repeat
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 3))
          ..repeat();

    // thay đổi kích thước từ 0 -> 400 và từ 400 -> 0
    _movementAnimation = TweenSequence(<TweenSequenceItem<double>>[
      TweenSequenceItem(tween: Tween(begin: 0.0, end: 400.0), weight: 10.0),
      TweenSequenceItem(tween: Tween(begin: 400.0, end: 0.0), weight: 10.0),
    ]).animate(_controller);
  }

  @override
  void dispose() {
    // hủy animation
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        const Center(child: Text("Move image from top to bottom and repeat")),
        AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Container(
              height: _movementAnimation.value,
            );
          },
        ),
        const FlutterLogo(size: 150),
      ],
    );
  }
}
