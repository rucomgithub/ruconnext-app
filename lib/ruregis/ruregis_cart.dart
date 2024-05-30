// ignore_for_file: non_constant_identifier_names

import 'dart:async';
import 'dart:convert';

import 'package:th.ac.ru.uSmart/app_theme.dart';
import 'package:th.ac.ru.uSmart/hotel_booking/model/hotel_list_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:th.ac.ru.uSmart/model/ruregion_mr30_model.dart';
import 'package:th.ac.ru.uSmart/model/ruregis_list_data.dart';
import 'package:th.ac.ru.uSmart/providers/ruregion_mr30_provider.dart';
import 'package:th.ac.ru.uSmart/widget/Rubar.dart';
import '../hotel_booking/hotel_app_theme.dart';
import '../providers/ruregis_provider.dart';
import '../providers/ruregis_fee_provider.dart';
import 'package:get/get.dart';
import '../providers/mr30_provider.dart';
import 'package:th.ac.ru.uSmart/pages/ImageLoader.dart';

class RuregisCartScreen extends StatefulWidget {
  @override
  _RuregisCartScreenState createState() => _RuregisCartScreenState();
}

class _RuregisCartScreenState extends State<RuregisCartScreen>
    with TickerProviderStateMixin {
  AnimationController? animationController;
  List<RuregisListData> ruregisList = RuregisListData.ruregisList;
  List<HotelListData> hotelList = HotelListData.hotelList;
  final ScrollController _scrollController = ScrollController();

  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now().add(const Duration(days: 5));
  String dropdownValue = 'one';
  List<String> fruits = ['Apple', 'Banana', 'Grapes', 'Orange', 'Mango'];
  var dropdownvalue;
  bool isChecked = false;

  var courseMr30;
  var feeData;
  var profileData;
  var checkCredit;
  bool isCourseDup = true;
  var stdcode;
  var semester;
  var year;
  var fiscalyear;
  var tel;
  var msgcredit;

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    super.initState();
    semester = Provider.of<RuregisProvider>(context, listen: false).semester;
    year = Provider.of<RuregisProvider>(context, listen: false).year;
    Provider.of<RuregisProvider>(context, listen: false).fetchProfileRuregis();
    Provider.of<RuregisProvider>(context, listen: false).fetchLocationExam();
    var mr30 =
        Provider.of<RuregionProvider>(context, listen: false).mr30ruregionrec;
    Provider.of<RuregionProvider>(context, listen: false).courseSame(isChecked);
    stdcode = Provider.of<RuregisProvider>(context, listen: false).stdcode;
    Provider.of<RuregisFeeProvider>(context, listen: false).fetchFeeRuregis();
    Provider.of<RuregisFeeProvider>(context, listen: false).summaryFee();
    msgcredit =
        Provider.of<RuregisFeeProvider>(context, listen: false).summary.message;
    Provider.of<RuregisFeeProvider>(context, listen: false)
        .getCalPay(mr30, stdcode, semester, year);
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    return true;
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //context.read<RuregisProvider>().getAllRuregis();

    // var mr30 = context.watch<MR30Provider>();
    //Provider.of<RuregionProvider>(context).courseSame(isChecked);
    // context.watch<RuregionProvider>().courseSame(isChecked);
    ;
    return Theme(
      data: HotelAppTheme.buildLightTheme(),
      child: Container(
        child: Scaffold(
          body: Provider.of<RuregisFeeProvider>(context).isLoading == false
              ? Stack(
                  children: <Widget>[
                    InkWell(
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      onTap: () {
                        FocusScope.of(context).requestFocus(FocusNode());
                      },
                      child: Column(
                        children: <Widget>[
                          getAppBarUI(),
                          Column(children: <Widget>[
                            ProfileCard(),
                          ]),
                          Column(children: <Widget>[
                            LocationExam(),
                          ]),
                          Expanded(
                            child: SummaryData(),
                          ),
                          Expanded(
                            child: CourseRUREGIMR30(),
                          ),
                          SizedBox(height: 1), // Add this SizedBox for spacing
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                            child: SizedBox(
                              width: double.infinity,
                              child: Column(
                                children: [
                                  if (dropdownvalue == null)
                                    Align(
                                      alignment: Alignment.bottomCenter,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          // Action when button is pressed
                                        },
                                        style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all<Color>(
                                                  Color.fromARGB(255, 134, 134,
                                                      134)), // Button color
                                        ),
                                        child: Text(
                                            'โปรดเลือกศูนย์สอบสอบก่อนกดยืนยัน'),
                                      ),
                                    ),
                                  if (isCourseDup == true &&
                                      dropdownvalue != null)
                                    Align(
                                      alignment: Alignment.bottomCenter,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          // Action when button is pressed
                                        },
                                        style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all<Color>(
                                                  Color.fromARGB(255, 253, 71,
                                                      30)), // Button color
                                        ),
                                        child: Text('โปรดตรวจสอบวันและคาบสอบ'),
                                      ),
                                    ),
                                  if (dropdownvalue != null &&
                                      checkCredit == false &&
                                      isCourseDup == false)
                                    Align(
                                      alignment: Alignment.bottomCenter,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          // Action when button is pressed
                                        },
                                        style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all<Color>(
                                                  Color.fromARGB(255, 253, 71,
                                                      30)), // Button color
                                        ),
                                        child: Text('$msgcredit'),
                                      ),
                                    ),
                                  if (dropdownvalue != null &&
                                      checkCredit == true &&
                                      isCourseDup == false)
                                    Align(
                                      alignment: Alignment.bottomCenter,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          saveEnroll();
                                        },
                                        style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all<Color>(
                                                  Colors.green), // Button color
                                        ),
                                        child: Text('ยืนยันวิชา'),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                )
              : Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
        ),
      ),
    );
  }

  void saveEnroll() {
    Map<String, dynamic> jsonCourse = {
      "STD_CODE": "",
      "COURSE_NO": "",
      "CREDIT": ""
    };
    var arrCourse = [];
    courseMr30.forEach((element) => {
          jsonCourse = {
            "STD_CODE": "${stdcode}",
            "COURSE_NO": element.cOURSENO,
            "CREDIT": (element.cREDIT.toString())
          },
          arrCourse.add(jsonCourse)
        });
    // mr 30

    Map<String, dynamic> jsonFee = {
      "FEE_NO": "",
      "FEE_NAME": "",
      "FEE_AMOUNT": "",
      "FEE_TYPE": ""
    };
    var arrFee = [];
    // print('feeeeeeeeeeeeeeeeee $feeData');
    feeData.results.forEach((element) => {
          //  print(element.fEENO),
          jsonFee = {
            "FEE_NO": element.fEENO,
            "FEE_NAME": element.fEENAME,
            "FEE_AMOUNT": element.fEEAMOUNT,
            "FEE_TYPE": element.fEETYPE
          },
          arrFee.add(jsonFee)
        });
    // fee
    // print(isChecked);
    var nearGrad;
    if (isChecked == true) {
      nearGrad = "1";
    } else {
      nearGrad = "0";
    }
    // print(arrCourse);
    var params = {
      "STD_CODE": profileData.ruregis.sTDCODE!,
      "FISCAL_YEAR": fiscalyear,
      "STUDY_YEAR": year,
      "STUDY_SEMESTER": semester,
      "TOTAL_AMOUNT": (feeData.sumTotal).toString(),
      "NEAR_GRADUATE": nearGrad,
      "TELEPHONE_NO": profileData.ruregis.mOBILETELEPHONE,
      "STD_STATUS_CURRENT": profileData.ruregis.sTDSTATUSCURRENT,
      "REGIONAL_EXAM_NO": dropdownvalue,
      "ENROLL_DATA": arrCourse,
      "FEE_DETAIL": arrFee,
    };

    Provider.of<RuregisProvider>(context, listen: false).postEnroll(params);
    //print('${context.watch<RuregisProvider>().msgSaveEnroll}');

    showAlert(context);
  }

  void showAlert(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        final provider = Provider.of<RuregisProvider>(context);
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (provider.isLoading == false) Text(provider.msgSaveEnroll),
              if (provider.isLoading == true) CircularProgressIndicator(),
            ],
          ),
        );
      },
    );
  }

  Widget Graduate() {
    // print(isChecked);
    return Row(
      children: [
        Checkbox(
          checkColor: Colors.white,
          value: isChecked,
          onChanged: (bool? value) {
            setState(() {
              isChecked = value!;
              Provider.of<RuregionProvider>(context, listen: false)
                  .courseSame(isChecked);
            });
          },
        ),
        Text('ขอจบ'),
      ],
    );
  }

  Widget LocationExam() {
    var ruregisfeeProv = context.watch<RuregisProvider>();

    var nameLocation;
    return Column(
      children: <Widget>[
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DropdownButton(
              hint: Text('เลือกศูนย์สอบ'),
              items: ruregisfeeProv.locationexam.results!.map((item) {
                nameLocation = item.eXAMLOCATIONNAMETHAI.toString();
                return DropdownMenuItem(
                  value: item.rEGIONALEXAMNO.toString(),
                  child: Text(item.eXAMLOCATIONNAMETHAI.toString()),
                );
              }).toList(),
              onChanged: (newVal) {
                setState(() {
                  dropdownvalue = newVal;
                  Provider.of<RuregionProvider>(context, listen: false)
                      .courseSame(isChecked);
                });
              },
              value: dropdownvalue,
            ),
          ],
        ),
      ],
    );
  }

  Widget ProfileCard() {
    var ruregisProv = context.watch<RuregisProvider>();
    semester = ruregisProv.semester;
    year = ruregisProv.year;
    fiscalyear = ruregisProv.fiscalyear;
    profileData = ruregisProv;
    return Container(
        child: SingleChildScrollView(
      child: Card(
        margin: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              leading: CircleAvatar(
                radius: 30,
                backgroundImage: AssetImage('assets/images/ID.png'),
              ),
              title: Text(
                ruregisProv.ruregis.nAMETHAI!,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                ),
              ),
              subtitle: Text(
                '${ruregisProv.ruregis.fACULTYNAMETHAI!} สาขา${ruregisProv.ruregis.mAJORNAMETHAI!} หลักสูตร${ruregisProv.ruregis.cURRNAMETHAI!}  ',
                style: TextStyle(
                  fontSize: 12.0,
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }

  Widget CourseRUREGIMR30() {
    var mr30 = context.watch<RuregionProvider>().mr30ruregionrec;
    var sumcredit = context.watch<RuregisFeeProvider>().sumIntCredit;
    var sameCourse = context.watch<RuregionProvider>().mr30sameruregionrec;
    isCourseDup = context.watch<RuregionProvider>().isCourseDup;
    courseMr30 = mr30;

    return Card(
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: mr30.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Row(
                    children: [
                      Expanded(
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: '${sameCourse[index].cOURSEDUP ?? ' '}',
                                style: TextStyle(color: Colors.red),
                              ),
                              TextSpan(
                                text:
                                    '${sameCourse[index].cOURSENO} (${sameCourse[index].eXAMDATE} ${sameCourse[index].eXAMPERIOD})',
                                style: TextStyle(color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Text('${sameCourse[index].cREDIT}'),
                    ],
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'รวม $sumcredit หน่วยกิต',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget CourseRUREGIMR301() {
    var mr30 = context.watch<RuregionProvider>().mr30ruregionrec;
    var sumcredit = context.watch<RuregisFeeProvider>().sumIntCredit;
    var sameCourse = context.watch<RuregionProvider>().mr30sameruregionrec;
    courseMr30 = mr30;
    return Container(
      height: 90,
      child: Expanded(
        child: ListView.builder(
            itemCount: mr30.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    InkWell(
                      onTap: () => print('Go to profile'),
                      child: Container(
                        height: 70,
                        width: 70,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('image/profileIcon.png'),
                              fit: BoxFit.fill,
                            ),
                            shape: BoxShape.circle),
                      ),
                    ),
                    Text("YOU WANT THAT TEXT")
                  ],
                ),
              );
            }),
      ),
    );
  }

  Widget SummaryData() {
    var ruregisfeeProv = context.watch<RuregisFeeProvider>();
    feeData = context.watch<RuregisFeeProvider>().summary;
    checkCredit = context.watch<RuregisFeeProvider>().summary.success;
    //print(isChecked);// Define isChecked variable

    return Card(
      child: Container(
        child: Column(
          children: <Widget>[
            ListTile(
              title: Row(
                children: [
                  Expanded(
                    child: Text(
                      'ชื่อค่าธรรมเนียม',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Text(
                    'ราคา',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: ruregisfeeProv.summary.results!.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Row(
                      children: [
                        Expanded(
                          child: Text(
                            ' ${ruregisfeeProv.summary.results![index].fEENAME}',
                          ),
                        ),
                        Text(
                          '${ruregisfeeProv.summary.results![index].fEEAMOUNT}',
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            profileData.ruregis.gRADUATESTATUS
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Graduate(),
                          ),
                          Text(
                            'ค่าธรรมเนียมทั้งหมด ${ruregisfeeProv.summary.sumTotal}',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.end,
                          ),
                        ],
                      ),
                    ],
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Divider(),
                          ),
                          Text(
                            'ค่าธรรมเนียมทั้งหมด ${ruregisfeeProv.summary.sumTotal}',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.end,
                          ),
                        ],
                      ),
                    ],
                  ),
            // Row(
            //   mainAxisAlignment:
            //       MainAxisAlignment.end, // Aligns the row to the right
            //   // Row to place Checkbox and Texts together
            //   children: [
            //     if (profileData.ruregis.gRADUATESTATUS == true)
            //       Row(children: [
            //         Graduate(),
            //         Text(
            //           'ค่าธรรมเนียมทั้งหมด ${ruregisfeeProv.summary.sumTotal}',
            //           style: TextStyle(
            //             fontSize: 16,
            //             fontWeight: FontWeight.bold,
            //           ),
            //         ),
            //       ]),
            //     if (profileData.ruregis.gRADUATESTATUS == false)
            //       Text(
            //         'ค่าธรรมเนียมทั้งหมด ${ruregisfeeProv.summary.sumTotal} ',
            //         style: TextStyle(
            //           fontSize: 16,
            //           fontWeight: FontWeight.bold,
            //         ),
            //       ),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }

  Widget getAppBarUI() {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.background,
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              offset: const Offset(0, 2),
              blurRadius: 8.0),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top, left: 8, right: 8),
        child: Row(
          children: <Widget>[
            Container(
              alignment: Alignment.centerLeft,
              width: AppBar().preferredSize.height + 0,
              height: AppBar().preferredSize.height,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(32.0),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(Icons.arrow_back),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Rubar(textTitle: 'ตะกร้าวิชาที่เลือก'),
            ),
            Container(
              width: AppBar().preferredSize.height + 40,
              height: AppBar().preferredSize.height,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
              ),
            )
          ],
        ),
      ),
    );
  }
}
