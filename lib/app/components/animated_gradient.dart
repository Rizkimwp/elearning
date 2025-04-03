import 'package:flutter/material.dart';
import 'dart:async';

class AnimatedGradientBackground extends StatefulWidget {
  const AnimatedGradientBackground({super.key});

  @override
  _AnimatedGradientBackgroundState createState() => _AnimatedGradientBackgroundState();
}

class _AnimatedGradientBackgroundState extends State<AnimatedGradientBackground> {
  List<Color> colors = [Colors.blue, Colors.purple, Colors.red]; 
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(seconds: 2), (timer) {
      setState(() {
        currentIndex = (currentIndex + 1) % colors.length;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(seconds: 2),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [colors[currentIndex], colors[(currentIndex + 1) % colors.length]],
          begin: Alignment.bottomRight,
          end: Alignment.bottomRight,
        ),
      ),
    );
  }
}
