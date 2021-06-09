import 'package:flutter/material.dart';

class CoursePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('金牌课程'),
      ),
      body: Container(
        alignment: Alignment.center,
        child: const Text('金牌课程', style: TextStyle(fontSize: 40.0),),
      ),
    );
  }
}