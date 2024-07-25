// ignore_for_file: non_constant_identifier_names

import 'package:th.ac.ru.uSmart/app_theme.dart';
import 'package:th.ac.ru.uSmart/hotel_booking/model/hotel_list_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:th.ac.ru.uSmart/model/ruregis_list_data.dart';
import 'package:th.ac.ru.uSmart/providers/region_enroll_provider.dart';
import 'package:th.ac.ru.uSmart/widget/Rubar.dart';
import '../hotel_booking/hotel_app_theme.dart';
import '../providers/ruregis_provider.dart';
import '../providers/ruregis_fee_provider.dart';
import 'package:get/get.dart';
import '../providers/mr30_provider.dart';

class RuRegisConfirmScreen extends StatefulWidget {
  @override
  _RuRegisConfirmScreenState createState() => _RuRegisConfirmScreenState();
}

class _RuRegisConfirmScreenState extends State<RuRegisConfirmScreen>
    with TickerProviderStateMixin {
  AnimationController? animationController;
  List<RuregisListData> ruregisList = RuregisListData.ruregisList;
  List<HotelListData> hotelList = HotelListData.hotelList;
  final ScrollController _scrollController = ScrollController();

  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now().add(const Duration(days: 5));
  var profileData;
  var stdcodeGlobal;
  var semGlobal;
  var yearGlobal;
  bool _isChecked = true;

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    super.initState();
    var stdcode = Provider.of<RuregisProvider>(context, listen: false).stdcode;
    var semester =
        Provider.of<RuregisProvider>(context, listen: false).semester;
    var year = Provider.of<RuregisProvider>(context, listen: false).year;
    Provider.of<RuregisProvider>(context, listen: false).fetchCounterRegion();
    Provider.of<RegionEnrollProvider>(context, listen: false)
        .getEnrollRegionProv(stdcode, semester, year);
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
    var std = context.read<RuregisProvider>().ruregis.sTDCODE;
    var sem = context.read<RuregisProvider>().semester;
    var year = context.read<RuregisProvider>().year;
    bool ctrlQR = true;
    ctrlQR = context.read<RuregisProvider>().ctrlQR;
    var ctrlqrmsg = context.read<RuregisProvider>().ctrlMsgQR;
    return Theme(
      data: HotelAppTheme.buildLightTheme(),
      child: Provider.of<RuregisProvider>(context).isLoading == false
          ? Container(
              child: Scaffold(
                body: Stack(
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
                          Column(
                            children: <Widget>[
                              ProfileCard(),
                            ],
                          ),

                          Expanded(
                            child: SummaryData(),
                          ),
                          Expanded(
                            child: CourseRUREGIMR30(context),
                          ),
                          SizedBox(height: 1), // Add this SizedBox for spacing
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                            child: SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: ctrlQR
                                    ? null
                                    : () {
                                        // Show the confirmation dialog
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title:
                                                  Text('ยืนยันการรับ QR CODE'),
                                              content: Text(
                                                  'สามารถรับ QR CODE ได้ครั้งเดียว'),
                                              actions: <Widget>[
                                                TextButton(
                                                  onPressed: () {
                                                    // Close the dialog
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: Text('ยกเลิก'),
                                                ),
                                                ElevatedButton(
                                                  onPressed: () {
                                                    saveEnroll(std, sem,
                                                        year); // Add your logic here for when the user confirms
                                                    // Close the dialog
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: Text('ยืนยัน'),
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      },
                                child: Text(ctrlQR
                                    ? '$ctrlqrmsg'
                                    : 'กดเพื่อรับ QR CODE'), // Button text based on `ctrlQR`
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          : Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            ),
    );
  }

  Widget CourseRUREGIMR30(BuildContext context) {
    var mr30 = context
            .watch<RegionEnrollProvider>()
            .enrollruregion
            .receiptRu24RegionalResults ??
        [];
    var sumcredit = context.read<RegionEnrollProvider>().sumIntCredit;
    // Calculate total credits

    return Container(
      padding: EdgeInsets.all(10.0),
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'วิชาที่ลงทะเบียน ${mr30.length} วิชา',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
                decoration: TextDecoration.underline,
              ),
            ),
            Flexible(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: mr30.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            ' ${index + 1}. ${mr30[index].cOURSENO} (${mr30[index].cREDIT}) ${mr30[index].eXAMDATEPERIOD}'),
                      ],
                    ),
                  );
                },
              ),
            ),
            // Footer showing total credits
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
      ),
    );
  }

  void saveEnroll(std, sem, year) {
    var params = {
      "STD_CODE": "$std",
      "STUDY_SEMESTER": "$sem",
      "STUDY_YEAR": "$year",
      "TELEPHONE_NO": "06"
    };

    Provider.of<RegionEnrollProvider>(context, listen: false).postQR(params);
  }

  

  Widget SummaryData() {
    var ruregisfeeProv = context
        .watch<RegionEnrollProvider>()
        .enrollruregion
        .receiptDetailRegionalResults;
    var sumfee = context.watch<RegionEnrollProvider>().sumfee;

    return Container(
      padding: EdgeInsets.all(10.0),
      child: Card(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'ค่าธรรมเนียม',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.start,
                  ),
                  Text(
                    'ราคา',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.end,
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: ruregisfeeProv!.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                '${ruregisfeeProv[index].fEENAME}',
                                textAlign: TextAlign.start,
                              ),
                            ),
                            Text(
                              '${ruregisfeeProv[index].fEEAMOUNT}',
                              textAlign: TextAlign.end,
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            // Footer showing total fee amount
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'ค่าธรรมเนียมรวม',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '$sumfee', // Display total fee amount here
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget ProfileCard() {
    var ruregisProv = context.watch<RuregisProvider>();
    profileData = ruregisProv;
    var examlocate = context.watch<RegionEnrollProvider>().examLocate;
    var isgrad = context.watch<RegionEnrollProvider>().isGrad;

    return Row(
      // Use Row to layout widgets horizontally
      children: [
        Expanded(
          // Expanded to make the Card take up all available horizontal space
          child: Container(
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
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Checkbox(
                                isError: true,
                                tristate: true,
                                value: isgrad,
                                onChanged: null,
                              ),
                              Text(
                                'ขอจบ',
                                style: TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.normal,
                                ),
                                textAlign: TextAlign.start,
                              ),
                            ],
                          ),
                          Text(
                            '${examlocate}',
                            style: TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.normal,
                            ),
                            textAlign: TextAlign.start,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
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
              child: Rubar(textTitle: 'ยืนยันการลงทะเบียน'),
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
