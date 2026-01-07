import 'package:flutter/material.dart';
import 'package:th.ac.ru.uSmart/manual/base_help_screen.dart';

class MR30HelpScreen extends StatelessWidget {
  const MR30HelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseHelpScreen(
      title: 'หน้า มร.30',
      imageUrls: const [
        'https://service.ru.ac.th/assets/ruconnext/mr30/6.png',
        'https://service.ru.ac.th/assets/ruconnext/mr30/7.png',
        'https://service.ru.ac.th/assets/ruconnext/mr30/8.png',
        'https://service.ru.ac.th/assets/ruconnext/mr30/9.png',
        'https://service.ru.ac.th/assets/ruconnext/mr30/10.png',
      ],
    );
  }
}
