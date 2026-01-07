// ignore_for_file: non_constant_identifier_names

import 'package:th.ac.ru.uSmart/app_theme.dart';
import 'package:th.ac.ru.uSmart/hotel_booking/model/hotel_list_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:th.ac.ru.uSmart/model/ruregis_list_data.dart';
import 'package:th.ac.ru.uSmart/providers/region_enroll_provider.dart';
import 'package:th.ac.ru.uSmart/widget/Rubar.dart';
import '../../hotel_booking/hotel_app_theme.dart';
import '../../providers/ruregis_provider.dart';

class RuregionSuccessScreen extends StatefulWidget {
  @override
  _RuregionSuccessScreenState createState() => _RuregionSuccessScreenState();
}

class _RuregionSuccessScreenState extends State<RuregionSuccessScreen>
    with TickerProviderStateMixin {
  AnimationController? animationController;
  List<RuregisListData> ruregisList = RuregisListData.ruregisList;
  List<HotelListData> hotelList = HotelListData.hotelList;
  final ScrollController _scrollController = ScrollController();

  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now().add(const Duration(days: 5));
  var profileData;
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
    Provider.of<RegionEnrollProvider>(context, listen: false)
        .getEnrollRegionProvApp();
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
    return Theme(
      data: HotelAppTheme.buildLightTheme(),
      child: Container(
        child: Provider.of<RuregisProvider>(context).isLoading == false
            ? Scaffold(
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
                          Column(children: <Widget>[
                            ProfileCard(),
                          ]),
                          // Add this SizedBox for spacing
                        ],
                      ),
                    ),
                  ],
                ),
              )
            : Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
      ),
    );
  }

  Widget ProfileCard() {
    var profile = context.watch<RuregisProvider>().ruregionApp;
    var ruregisProv = context.watch<RuregisProvider>();
    profileData = ruregisProv;
    var profileProv = context.watch<RegionEnrollProvider>();
    var examlocate = context.watch<RegionEnrollProvider>().examLocate;
    var isgrad = context.watch<RegionEnrollProvider>().isGrad;
    var mr30 = context
            .watch<RegionEnrollProvider>()
            .enrollruregion
            .receiptRu24RegionalResults ??
        [];
    var sumcredit = context.watch<RegionEnrollProvider>().sumIntCredit;
    var ruregisfeeProv = context
            .watch<RegionEnrollProvider>()
            .enrollruregion
            .receiptDetailRegionalResults ??
        [];
    var sumfee = context.watch<RegionEnrollProvider>().sumfee;

    return Row(
      children: [
        Expanded(
          child: Container(
            child: SingleChildScrollView(
              child: Card(
                margin: EdgeInsets.all(16.0),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      for (var i = 0;
                          i < profileProv.receiptRegionalResultsrec.length;
                          i++)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'ภาค/ปีการศึกษา :  ${profileProv.receiptRegionalResultsrec[i].rECEIPTSEMESTER!}/${profileProv.receiptRegionalResultsrec[i].rECEIPTYEAR!}',
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 12.0,
                              ),
                            ),
                            Text(
                              'ปีงบประมาณ : ${ruregisProv.fiscalyear}',
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 12.0,
                              ),
                            ),
                          ],
                        ),
                      SizedBox(height: 16.0), // Add space between rows
                      for (var i = 0;
                          i < profileProv.receiptRegionalResultsrec.length;
                          i++)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'วันที่ : ${profileProv.receiptRegionalResultsrec[i].rECEIPTDATE!} (${profileProv.receiptRegionalResultsrec[i].rECEIPTTIME!})',
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 12.0,
                              ),
                            ),
                            Text(
                              'เครื่องที่/เลขที่ : ${profileProv.receiptRegionalResultsrec[i].cOUNTERRECEIPTNO!}',
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 12.0,
                              ),
                            ),
                          ],
                        ),
                      SizedBox(height: 16.0), // Add space between rows
                      for (var i = 0;
                          i < profileProv.receiptRegionalResultsrec.length;
                          i++)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'ศูนย์สอบ : ${profileProv.receiptRegionalResultsrec[i].eXAMLOCATION!}',
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 12.0,
                              ),
                            ),
                          ],
                        ),
                      SizedBox(height: 16.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'ได้รับเงินจาก : ${profile.nAMETHAI!}',
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 12.0,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'รหัส : ${profile.sTDCODE!}',
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 12.0,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16.0), // Add space between rows
                      Row(
                        children: [
                          Expanded(
                            child: Table(
                              border: TableBorder.all(),
                              children: [
                                TableRow(
                                  children: [
                                    Container(
                                      color: Color.fromARGB(255, 181, 220,
                                          251), // Set the background color here
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            width: 32.0,
                                            height: 32.0,
                                            child: Checkbox(
                                              isError: true,
                                              tristate: true,
                                              value: isgrad,
                                              onChanged: null,
                                              visualDensity: VisualDensity
                                                  .compact, // You can adjust density for compactness
                                            ),
                                          ),
                                          Text(
                                            'ขอจบ',
                                            style: TextStyle(
                                              fontSize: 12.0,
                                              fontWeight: FontWeight.normal,
                                            ),
                                            textAlign: TextAlign.start,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      color: Color.fromARGB(255, 181, 220,
                                          251), // Set the background color here
                                      // Set the background color here
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        'รวม (บาท)',
                                        style: TextStyle(fontSize: 12.0),
                                      ),
                                    ),
                                  ],
                                ),
                                for (var i = 0; i < ruregisfeeProv.length; i++)
                                  TableRow(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                            '${ruregisfeeProv[i].fEENAME}',
                                            style: TextStyle(fontSize: 8.0)),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment
                                              .end, // Align text to the end (right)
                                          children: [
                                            Text(
                                              '${ruregisfeeProv[i].fEEAMOUNT}',
                                              style: TextStyle(fontSize: 12.0),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                TableRow(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text('รวมเงิน',
                                          style: TextStyle(fontSize: 11.0)),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment
                                            .end, // Align text to the end (right)
                                        children: [
                                          Text(
                                            '${sumfee}',
                                            style: TextStyle(fontSize: 14.0),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 16.0), // Add space between tables
                          Expanded(
                            child: Table(
                              border: TableBorder.all(),
                              children: [
                                TableRow(
                                  children: [
                                    Container(
                                      color: Color.fromARGB(255, 181, 220,
                                          251), // Set the background color here
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        'กระบวนวิชา',
                                        style: TextStyle(
                                            fontSize: 12.0,
                                            color: Colors
                                                .black), // Optional: Change text color for better contrast
                                      ),
                                    ),
                                    Container(
                                      color: Color.fromARGB(255, 181, 220,
                                          251), // Set the background color here
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        'หน่วยกิต',
                                        style: TextStyle(
                                            fontSize: 12.0,
                                            color: Colors
                                                .black), // Optional: Change text color for better contrast
                                      ),
                                    ),
                                  ],
                                ),
                                for (var i = 0; i < mr30.length; i++)
                                  TableRow(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text('${mr30[i].cOURSENO}',
                                            style: TextStyle(fontSize: 12.0)),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment
                                              .center, // Align text to the end (right)
                                          children: [
                                            Text(
                                              '${mr30[i].cREDIT}',
                                              style: TextStyle(fontSize: 12.0),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                TableRow(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text('รวม',
                                          style: TextStyle(fontSize: 12.0)),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment
                                            .center, // Align text to the end (right)
                                        children: [
                                          Text(
                                            '${sumcredit}',
                                            style: TextStyle(fontSize: 14.0),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
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
              color: Colors.grey.withValues(alpha: 0.2),
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
              child: Rubar(textTitle: 'หลักฐานการชำระเงิน'),
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
