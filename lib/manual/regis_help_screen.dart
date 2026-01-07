import 'package:flutter/material.dart';
import 'package:th.ac.ru.uSmart/manual/base_help_screen.dart';

class RegisHelpScreen extends StatelessWidget {
  const RegisHelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseHelpScreen(
      title: 'การใช้งานข้อมูลการลงทะเบียน',
      imageUrls: const [
        'https://drive.google.com/uc?export=view&id=1zMlWUZjHgKses_H_iRUyuSgFFkhPfkFk',
        'https://drive.google.com/uc?export=view&id=1uGBHh0ssqp-PblzXtUKHIali_C9EcLzC',
      ],
    );
  }
}
