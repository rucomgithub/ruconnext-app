import 'package:flutter/material.dart';
import 'package:th.ac.ru.uSmart/manual/base_help_screen.dart';

class HomeHelpScreen extends StatelessWidget {
  const HomeHelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseHelpScreen(
      title: 'หน้าแรก',
      imageUrls: const [
        'https://service.ru.ac.th/assets/ruconnext/home/1.png',
        'https://service.ru.ac.th/assets/ruconnext/home/2.png',
        'https://service.ru.ac.th/assets/ruconnext/home/3.png',
        'https://service.ru.ac.th/assets/ruconnext/home/4.png',
        'https://service.ru.ac.th/assets/ruconnext/home/5.png',
      ],
    );
  }
}
