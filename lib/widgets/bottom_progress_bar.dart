import 'package:flutter/material.dart';

class BottomProgressBar extends StatelessWidget {
  
  final BoxConstraints constraints;

  BottomProgressBar({required this.constraints});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      bottom: 0,
      child: SizedBox(
        width: constraints.maxWidth,
        height: 80,
        child: const Center(
          child: CircularProgressIndicator(),
          ),
        )
      );
  }

  
}