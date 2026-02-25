import 'package:flutter/material.dart';

class MiniBar extends StatelessWidget {
  final double height;

  const MiniBar({super.key, required this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 20,
      height: height,
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(6),
      ),
    );
  }
}