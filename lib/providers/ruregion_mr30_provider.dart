// import 'dart:convert';

// import 'package:dio/dio.dart';

import 'dart:convert';
import 'dart:math';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:th.ac.ru.uSmart/model/ruregion_mr30_model.dart';
import 'package:th.ac.ru.uSmart/model/ruregis_fee_model.dart';
import 'package:th.ac.ru.uSmart/services/ruregis_service.dart';
import 'package:flutter/material.dart';

class RuregionProvider extends ChangeNotifier {
  final _ruregisService = RuregisService();

  // List<Ruregis> _ruregis = [];
  String _error = '';
  String get error => _error;
  String filterStr = '';
  bool isLoading = false;
  bool isCourseDup = true;
  String examDup = '';

  Ruregisfee _ruregisfee = Ruregisfee();
  Ruregisfee get ruregisfee => _ruregisfee;

  // List<Ruregis> get ruregis => _ruregis;

  MR30RUREGION _mr30filter = MR30RUREGION();
  MR30RUREGION get mr30filter => _mr30filter;

  MR30RUREGION _mr30ruregion = MR30RUREGION();
  MR30RUREGION get mr30ruregion => _mr30ruregion;

  List<ResultsMr30> _mr30ruregionrec = [];
  List<ResultsMr30> get mr30ruregionrec => _mr30ruregionrec;

  MR30RUREGION _mr30sameruregion = MR30RUREGION();
  MR30RUREGION get mr30sameruregion => _mr30sameruregion;

  List<ResultsMr30> _mr30sameruregionrec = [];
  List<ResultsMr30> get mr30sameruregionrec => _mr30sameruregionrec;

  List<ResultsMr30> _mr30Compareruregionrec = [];
  List<ResultsMr30> get mr30Compareruregionrec => _mr30Compareruregionrec;

  Future<void> fetchMR30RUREGION(stdcode, sem, year) async {
    isLoading = true;
    _error = '';
    notifyListeners();
    try {
      final response =
          await _ruregisService.getMR30RUREGION(stdcode, sem, year);
      _mr30ruregion = response;

      filterMr30(filterStr);
    } on Exception catch (e) {
      isLoading = false;
      _error = 'เกิดข้อผิดพลาดดึงข้อมูลนักศึกษา';
    }

    //await _service.asyncName();

    isLoading = false;
    notifyListeners();
  }

  void filterMr30(String filter) {
    filterStr = filter;
    _mr30filter.results = _mr30ruregion.results
        ?.where((ResultsMr30 m) =>
            m.cOURSENO!.toUpperCase().contains(filterStr.toUpperCase()))
        .toList();
    filterStr = '';
    notifyListeners();
  }

  void removeRuregionPref(courseid) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _mr30ruregionrec.removeWhere((item) => item.cOURSENO == courseid);

    await prefs.setString('mr30ruregion', jsonEncode(_mr30ruregionrec));
    notifyListeners();
  }

void removeRuregisPref(courseid) async {
  print('provider remove $courseid');
  SharedPreferences prefs = await SharedPreferences.getInstance();
    print('provider remove $_mr30ruregionrec');
  // Print the cOURSENO of each item being checked and whether it matches courseid
  _mr30ruregionrec.removeWhere((item) {
    print('Checking item with cOURSENO: ${item.cOURSENO}');
    return item.cOURSENO == courseid;
  });

  await prefs.setString('mr30ruregis', jsonEncode(_mr30ruregionrec));
  notifyListeners();
}


  void courseSame(statusgrad) async {
    notifyListeners();
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final String mr30sameruregion = prefs.getString('mr30ruregion')!;
    var tmprec = [];
    if (mr30sameruregion != null) {
      int cntCourse = 0;

      _mr30sameruregionrec = ResultsMr30.decode(mr30sameruregion);
      _mr30Compareruregionrec = ResultsMr30.decode(mr30sameruregion);

      for (var i = 0; i < this._mr30sameruregionrec.length; i++) {
        var tmpStr = 1;

        for (var p = 0; p < i; p++) {
          // isCourseDup = false;
          if (_mr30sameruregionrec[i].eXAMDATESHOT ==
              _mr30sameruregionrec[p].eXAMDATESHOT) {
            cntCourse++;
            tmpStr++;
            _mr30sameruregionrec[p].cOURSEDUP = '*';
            _mr30sameruregionrec[i].cOURSEDUP = '*';
          }
        }

        tmprec.addAll({tmpStr});
        var maxTmpRec = tmprec[0];
        for (var i = 1; i < tmprec.length; i++) {
          if (tmprec[i] > maxTmpRec) {
            maxTmpRec = tmprec[i];
          }
        }
        print("ค่าที่มากที่สุดใน tmprec: $tmprec");
        print("statusgrad  $statusgrad");
        if (statusgrad == false) {
          //เช็ค neargrad=0

          if (maxTmpRec > 1) {
            print("maxTmpRec > 1 $isCourseDup");
            isCourseDup = true; //ขอจบ        status_graduate = true;
          } else {
            print("else  $isCourseDup");
            isCourseDup = false;
          }
        } else if (statusgrad == true && maxTmpRec > 4) {
          //เช็ค neargrad=1
          print("statusgrad == true && maxTmpRec > 4 $isCourseDup");
          isCourseDup = true; //ขอจบ
        } else {
          //เช็ค neargrad=1
          print("else $isCourseDup");
          isCourseDup = false;
        }
      }
    }
    print(isCourseDup);
    notifyListeners();
  }

  void addRuregionMR30(context, ResultsMr30 record) async {
    notifyListeners();
    print('s $record');
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (_mr30ruregionrec.isNotEmpty) {
      // print('not null $_mr30ruregionrec');
      final String mr30ruregion = prefs.getString('mr30ruregion')!;
      _mr30ruregionrec = ResultsMr30.decode(mr30ruregion);
      var dup = _mr30ruregionrec
          .where((ResultsMr30 r) => r.cOURSENO!.contains(record.cOURSENO!));
      if (dup.isNotEmpty) {
        var snackbar = SnackBar(
          content: Text('เลือกวิชาซ้ำ'),
          duration: Duration(milliseconds: 500), // Set the duration to 3 seconds
        );

        ScaffoldMessenger.of(context).showSnackBar(snackbar);
        //   _stringDup = 'เลือกซ้ำ';
        // print('เลือกซ้ำ ${_mr30ruregionrec}');
        // _mr30ruregionrec.removeWhere((item) => item.cOURSENO == record.cOURSENO);
      } else {
        var snackbar = SnackBar(
          content: Text('บันทึกสำเร็จ'),
          duration: Duration(milliseconds: 500), // Set the duration to 3 seconds
        );

        ScaffoldMessenger.of(context).showSnackBar(snackbar);
        //  _stringDup = 'บันทึกแล้ว';
        // print('บันทึกแล้ว $_mr30ruregionrec');
        _mr30ruregionrec.add(record);
      }
    } else {
      var snackbar = SnackBar(
        content: Text('บันทึกสำเร็จ'),
        duration: Duration(milliseconds: 500), // Set the duration to 3 seconds
      );

      ScaffoldMessenger.of(context).showSnackBar(snackbar);
      //  _stringDup = 'บันทึกแล้ว';
      //_mr30record.add(record);
      _mr30ruregionrec.add(record);
    }

    _mr30ruregion.results?.forEach((element) {
      var contain =
          _mr30ruregionrec.where((e) => element.cOURSENO == e.cOURSENO);
      if (contain.isNotEmpty) {
        //element.favorite = true;
      } else {
        // element.favorite = false;
      }
    });

    await prefs.setString('mr30ruregion', jsonEncode(_mr30ruregionrec));

    notifyListeners();
  }

  void addRuregisMR30(context, ResultsMr30 record) async {
    
    notifyListeners();
    print(record);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (_mr30ruregionrec.isNotEmpty) {
      final String mr30ruregion = prefs.getString('mr30ruregis')!;
      _mr30ruregionrec = ResultsMr30.decode(mr30ruregion);
      var dup = _mr30ruregionrec
          .where((ResultsMr30 r) => r.cOURSENO!.contains(record.cOURSENO!));
      if (dup.isNotEmpty) {
        var snackbar = SnackBar(
          content: Text('เลือกวิชาซ้ำ'),
          duration: Duration(milliseconds: 500), // Set the duration to 3 seconds
        );
        ScaffoldMessenger.of(context).showSnackBar(snackbar);
      } else {
        var snackbar = SnackBar(
          content: Text('บันทึกสำเร็จ'),
          duration: Duration(milliseconds: 500), // Set the duration to 3 seconds
        );
        ScaffoldMessenger.of(context).showSnackBar(snackbar);
        _mr30ruregionrec.add(record);
      }
    } else {
      var snackbar = SnackBar(
        content: Text('บันทึกสำเร็จ'),
        duration: Duration(milliseconds: 500), // Set the duration to 3 seconds
      );

      ScaffoldMessenger.of(context).showSnackBar(snackbar);
      _mr30ruregionrec.add(record);
    }

    _mr30ruregion.results?.forEach((element) {
      var contain =
          _mr30ruregionrec.where((e) => element.cOURSENO == e.cOURSENO);
      if (contain.isNotEmpty) {
      } else {
      }
    });

    await prefs.setString('mr30ruregis', jsonEncode(_mr30ruregionrec));

    notifyListeners();
  }
  
}
