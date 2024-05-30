import 'package:flutter/material.dart';
import 'package:th.ac.ru.uSmart/app_theme.dart';

Color getFacultyColor(String facultyName) {
  switch (facultyName) {
    case 'คณะนิติศาสตร์':
      return Colors.white;
    case 'คณะบริหารธุรกิจ':
      return Colors.blue;
    case 'คณะมนุษยศาสตร์':
      return Colors.orange;
    case 'คณะศึกษาศาสตร์':
      return Colors.pink;
    case 'คณะศึกษาศาสตร์':
      return Colors.pink;
    case 'คณะรัฐศาสตร์':
      return Colors.red;
    case 'คณะวิทยาศาสตร์':
      return Colors.yellow;
    case 'คณะเศรษฐศาสตร์':
      return Colors.purple;
    case 'คณะวิศวกรรมศาสตร์':
      return Color.fromARGB(255, 95, 10, 4);
    case 'คณะสื่อสารมวลชน':
      return Colors.green;
    case 'คณะทัศนมาตรศาสตร์':
      return Color.fromARGB(255, 3, 56, 5);
    case 'คณะศิลปกรรมศาสตร์':
      return Color.fromARGB(255, 202, 211, 149);
    case 'คณะพัฒนาทรัพยากรมนุษย์':
      return Colors.grey;
    case 'คณะรัฐประศาสนศาสตร์':
      return Color.fromARGB(255, 73, 52, 50);
    // Add more cases for other faculties
    default:
      return AppTheme.ru_dark_blue;
  }
}
