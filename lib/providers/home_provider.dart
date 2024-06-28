import 'package:flutter/material.dart';
import '../services/mr30service.dart';

class HomeProvider extends ChangeNotifier {
  final _service = MR30Service();
  String _title = "สวัสดีตอนเช้า";
  String get title => _title;

  IconData _icon = Icons.brightness_5;
  IconData get icon => _icon;

  ColorFilter _colorFilter =
      ColorFilter.mode(Color.fromARGB(255, 250, 225, 0), BlendMode.modulate);
  ColorFilter get colorFilter => _colorFilter;

  void getTimeHomePage() async {
    //print('getTimeHome');
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
          Color.fromARGB(255, 250, 225, 0), BlendMode.modulate);
    } else if (hour >= 12 && hour < 18) {
      return ColorFilter.mode(
          Color.fromARGB(255, 252, 152, 3), BlendMode.modulate);
    } else {
      return ColorFilter.mode(
          Color.fromARGB(255, 2, 139, 250), BlendMode.modulate);
    }
  }
}
