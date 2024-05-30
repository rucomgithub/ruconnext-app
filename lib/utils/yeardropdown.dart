import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:th.ac.ru.uSmart/app_theme.dart';
import '../providers/mr30_provider.dart';

class YearDropdownWidget extends StatefulWidget {
  const YearDropdownWidget({Key? key}) : super(key: key);

  @override
  _YearDropdownWidgetState createState() => _YearDropdownWidgetState();
}

class _YearDropdownWidgetState extends State<YearDropdownWidget> {
  String _selectedOption = "";
  List<String> _options = [];

  @override
  void initState() {
    super.initState();
    _loadOptions();
  }

  Future<void> _loadOptions() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jsonStr = prefs.getString('mr30year');
    List<String> options;
    if (jsonStr != null) {
      Map<String, dynamic> jsonData = jsonDecode(jsonStr);
      options = (jsonData["RECORDYEAR"] as List<dynamic>)
          .map((course) =>
              "${course["course_year"]}/${course["course_semester"]}")
          .toList();
      setState(() {
        _options = options ?? [];
        _selectedOption = _options.isNotEmpty ? _options.first : "";
      });
    }
  }

  Future<void> _saveSelectedOption(String selectedOption) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("selectedOption", selectedOption);
  }

  @override
  Widget build(BuildContext context) {
    var mr30prov = Provider.of<MR30Provider>(context, listen: false);
    return DropdownButton(
      icon: Padding(
          //Icon at tail, arrow bottom is default icon
          padding: EdgeInsets.only(left: 5),
          child: Icon(Icons.arrow_circle_down_sharp)),
      style: TextStyle(
        fontFamily: AppTheme.ruFontKanit,
          color: Colors.white, //Font color
          fontSize: 16 //font size on dropdown button
          ),
      value: _selectedOption,
      dropdownColor: Colors.blueGrey,
      items: _options.map((option) {
        return DropdownMenuItem(
          value: option,
          child: Text(option),
        );
      }).toList(),
      onChanged: (newValue) {
        setState(() {
          _selectedOption = newValue.toString();
          var year = newValue.toString().split("/");
          mr30prov.getAllMR30List(year[0], year[1]);
          _saveSelectedOption(_selectedOption);
        });
      },
    );
  }
}
