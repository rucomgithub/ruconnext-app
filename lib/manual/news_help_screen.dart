import 'package:flutter/material.dart';
import 'package:th.ac.ru.uSmart/manual/base_help_screen.dart';

class NewsHelpScreen extends StatelessWidget {
  const NewsHelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseHelpScreen(
      title: 'หน้าประชาสัมพันธ์',
      imageUrls: const [
        'https://drive.google.com/uc?export=view&id=1OoJPGg8LYy18-NGItrh3DEr6deF-lpFM',
        'https://drive.google.com/uc?export=view&id=1czbdMcZf2MjQt5NVMLRZ5jY8uGZmzOOU',
      ],
    );
  }
}
