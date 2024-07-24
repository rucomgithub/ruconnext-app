import 'dart:convert';
import 'package:th.ac.ru.uSmart/providers/register_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MasterRegisterYearDropdownWidget extends StatefulWidget {
  const MasterRegisterYearDropdownWidget({Key? key}) : super(key: key);

  @override
  _MasterRegisterYearDropdownWidgetState createState() =>
      _MasterRegisterYearDropdownWidgetState();
}

class _MasterRegisterYearDropdownWidgetState
    extends State<MasterRegisterYearDropdownWidget> {
  String _selectedOption = "";
  List<String> _options = [];

  @override
  void initState() {
    super.initState();

    _loadOptions();
  }

  Future<void> _loadOptions() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jsonStr = prefs.getString('registeryear');
    //print('jsonStr ${jsonStr}');
    List<String> options;
    if (jsonStr != null) {
      Map<String, dynamic> jsonData = jsonDecode(jsonStr);
      options = (jsonData["RECORD"] as List<dynamic>)
          .map((course) => "${course["year"]}")
          .toList();
      setState(() {
        _options = options;
        _selectedOption = _options.isNotEmpty ? _options.first : "";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var registerprov = Provider.of<RegisterProvider>(context, listen: false);
    return DropdownButton(
      icon: Padding(
          //Icon at tail, arrow bottom is default icon
          padding: EdgeInsets.only(left: 5),
          child: Icon(Icons.arrow_circle_down_sharp)),
      style: TextStyle(
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
          //print(_selectedOption);
          registerprov.getAllRegisterByYear(_selectedOption);
        });
      },
    );
  }
}
