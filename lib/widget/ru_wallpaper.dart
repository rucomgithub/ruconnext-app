import 'package:flutter/material.dart';

class RuWallpaper extends StatelessWidget {
  const RuWallpaper({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/bg.png'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
