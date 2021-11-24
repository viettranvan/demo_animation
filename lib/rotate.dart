import 'package:flutter/material.dart';
import 'dart:math' as math;

class Rotate extends StatefulWidget {
  const Rotate({Key? key}) : super(key: key);

  @override
  State<Rotate> createState() => _RotateState();
}

class _RotateState extends State<Rotate> with SingleTickerProviderStateMixin {
  late final AnimationController _logoController;
  late Animation _logoAnimation;

  bool isRotate = false;

  @override
  void initState() {
    super.initState();
    // khởi tạo với thời gian xảy ra của animation là 1 giây
    _logoController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));

    // Tween kế thừa từ Animatable<T> -> hỗ trợ nhiều kiều khác ngoài double
    // Tween là một đối tượng không có trạng thái, chỉ có lưu giá trị begin và end
    // khởi tạo giá trị bắt đầu = 0, end = pi = 180
    _logoAnimation = Tween(begin: 0.0, end: math.pi)
        .animate(_logoController); // để sử dụng Tween, cần phải gọi animate() và đặt
                                  // vào 1 AnimationController -> trả về 1 Animation

    // dùng cho các thông báo về thay đổi trạng thái của animaton
    _logoController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        isRotate =
            true; // nếu status == AnimationStatus.completed, gán isRotate = true
      } else {
        isRotate = false;
      }
    });
  }

  @override
  void dispose() {
    _logoController.dispose(); // huỷ animation

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Center(child: Text("Rotation animation")),
          const SizedBox(height: 20.0),
          AnimatedBuilder(
            // animation: nó mong đợi 1 animationController chịu  trách nhiệm kiểm soát animation
            // trong trường hợp này là _logoController sẽ điều khiển xoay FlutterLogo
            animation: _logoController,
            // builder: một callback() được gọi mỗi khi giá trị của animation thay đổi
            builder: (context, child) {
              // Transform.rotate: là widget đặc biệt giúp chuyển đổi con của nó bằng cách
              // xoay một góc với giá trị được truyền vào qua thuộc tính angle
              return Transform.rotate(
                angle: _logoAnimation.value,
                child: child,
              );
            },
            child: const FlutterLogo(size: 200),
          ),
          const SizedBox(height: 50.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: () {
                    setState(() {
                      isRotate // nếu isRotate = true -> reverse ngược lại -> forward
                          ? _logoController.reverse()
                          : _logoController.forward();
                    });
                  },
                  child: const Text("Rotate")),
            ],
          ),
        ],
      ),
    );
  }
}
