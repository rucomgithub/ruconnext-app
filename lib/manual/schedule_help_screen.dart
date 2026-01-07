import 'package:flutter/material.dart';
import 'package:th.ac.ru.uSmart/manual/base_help_screen.dart';

class ScheduleHelpScreen extends StatelessWidget {
  const ScheduleHelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseHelpScreen(
      title: 'หน้าปฏิทินกิจกรรม',
      imageUrls: const [
        'https://drive.google.com/uc?export=view&id=1Ejdbbwr-fIn92Udn2LeOF_RYjBXhdw_3',
      ],
    );
  }
}
