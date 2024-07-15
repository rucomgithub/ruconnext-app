import 'package:flutter/material.dart';
import 'package:th.ac.ru.uSmart/grade/grade_app_home_screen.dart';
import 'package:th.ac.ru.uSmart/home_screen.dart';
import 'package:th.ac.ru.uSmart/registers/register_home_screen.dart';
import 'package:th.ac.ru.uSmart/today/today_home_screen.dart';
import '../services/mr30service.dart';

class HomeProvider extends ChangeNotifier {
  final _service = MR30Service();
  String _title = "สวัสดีตอนเช้า";
  String get title => _title;

  IconData _icon = Icons.brightness_5;
  IconData get icon => _icon;

  ColorFilter _colorFilter =
      ColorFilter.mode(Color.fromARGB(255, 221, 211, 116), BlendMode.modulate);
  ColorFilter get colorFilter => _colorFilter;

  StatefulWidget _page = MyHomePage();
  StatefulWidget get page => _page;

  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  void setIndex(int index) {
    _currentIndex = index;
    setPage(index);
    notifyListeners();
  }

  void setPage(int index) async {
    print('getSetPage');
    switch (index) {
      case 0:
        _page = MyHomePage();
        break;
      case 1:
        _page = GradeAppHomeScreen();
        break;
      case 2:
        _page = TodayHomeScreen();
        break;
      case 3:
        _page = RegisterHomeScreen();
        break;
    }
    notifyListeners();
  }

  void getTimeHomePage() async {
    print('getTimeHome');
    _title = await getTitile();
    _icon = await getIcon();
    _colorFilter = await getColorFilter();
    notifyListeners();
  }

  Future<String> getTitile() async {
    final hour = DateTime.now().hour;
    if (hour >= 6 && hour < 12) {
      return 'สวัสดีตอนเช้า';
    } else if (hour >= 12 && hour < 18) {
      return 'สวัสดีตอนบ่าย';
    } else {
      return 'สวัสดีตอนเย็น';
    }
  }

  Future<IconData> getIcon() async {
    final hour = DateTime.now().hour;
    if (hour >= 6 && hour < 12) {
      return Icons.brightness_5;
    } else if (hour >= 12 && hour < 18) {
      return Icons.brightness_6;
    } else {
      return Icons.brightness_2;
    }
  }

  Future<ColorFilter> getColorFilter() async {
    final hour = DateTime.now().hour;

    if (hour >= 6 && hour < 12) {
      return ColorFilter.mode(
          Colors.yellow.withOpacity(0.5), BlendMode.modulate);
    } else if (hour >= 12 && hour < 18) {
      return ColorFilter.mode(
          Colors.orange.withOpacity(0.5), BlendMode.modulate);
    } else {
      return ColorFilter.mode(
          Colors.blueGrey.withOpacity(0.5), BlendMode.modulate);
    }
  }
}
