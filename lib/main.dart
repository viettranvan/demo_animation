import 'package:demo_animation/rotate.dart';
import 'package:demo_animation/scale.dart';
import 'package:flutter/material.dart';
import 'movement.dart';

void main() {
  runApp(const MaterialApp(home: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Animation"),
        ),
        bottomSheet: const TabBar(
          unselectedLabelColor: Colors.grey,
          labelColor: Colors.blue,
          tabs: [
            Tab(icon: Icon(Icons.rotate_90_degrees_ccw)),
            Tab(icon: Icon(Icons.linear_scale)),
            Tab(icon: Icon(Icons.transform)),
          ],
        ),
        body: const TabBarView(
          children: [
            Rotate(),
            Scale(),
            Movement(),
          ],
        ),
      ),
    );
  }
}
