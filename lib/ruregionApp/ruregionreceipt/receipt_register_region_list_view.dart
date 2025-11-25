import 'package:th.ac.ru.uSmart/app_theme.dart';
import 'package:th.ac.ru.uSmart/model/checkregis_model.dart';
import 'package:th.ac.ru.uSmart/model/enroll_region_model.dart';
import 'package:th.ac.ru.uSmart/providers/region_receipt_provider.dart';

import 'package:th.ac.ru.uSmart/providers/register_provider.dart';
import 'package:th.ac.ru.uSmart/providers/ruregion_check_cart.dart';
import 'package:th.ac.ru.uSmart/providers/ruregis_fee_provider.dart';
import 'package:th.ac.ru.uSmart/providers/ruregis_mr30_provider.dart';
import 'package:th.ac.ru.uSmart/providers/ruregis_provider.dart';
import 'package:th.ac.ru.uSmart/registers/register_nodata_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart'; // อย่าลืม import

import '../../fitness_app/fitness_app_theme.dart';
import '../../model/register_model.dart';

class ReceiptRuregionCartListView extends StatefulWidget {
  const ReceiptRuregionCartListView(
      {Key? key, this.mainScreenAnimationController, this.mainScreenAnimation})
      : super(key: key);

  final AnimationController? mainScreenAnimationController;
  final Animation<double>? mainScreenAnimation;
  @override
  _ReceiptRuregionCartListViewState createState() =>
      _ReceiptRuregionCartListViewState();
}

class _ReceiptRuregionCartListViewState
    extends State<ReceiptRuregionCartListView> with TickerProviderStateMixin {
  AnimationController? animationController;

  bool isChecked = false;
  @override
  void initState() {
    Provider.of<RuregionReceiptProvider>(context, listen: false)
        .getEnrollRegionProv('6299499991', '2', '2568');

    animationController = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          mr30cart(context),
          fee(context),
        ],
      ),
    );
  }

  Container mr30cart(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width *
          0.68, // Set a fixed width for the container
      // height: MediaQuery.of(context).size.height * 0.5,
      margin: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: Color.fromARGB(255, 184, 220, 250)),
      ),
      child: AnimatedBuilder(
        animation: widget.mainScreenAnimationController!,
        builder: (BuildContext context, Widget? child) {
          var ruregionreceipt = context.watch<RuregionReceiptProvider>();
          return ruregionreceipt.isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Row(
                  children: [
                    Expanded(
                      child: Stack(
                        children: <Widget>[
                          SizedBox(
                            height: MediaQuery.of(context).padding.bottom,
                          ),
                          FadeTransition(
                            opacity: widget.mainScreenAnimation!,
                            child: Transform(
                              transform: Matrix4.translationValues(
                                  0.0,
                                  30 *
                                      (1.0 - widget.mainScreenAnimation!.value),
                                  0.0),
                              child: AspectRatio(
                                aspectRatio: 1.0,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.only(left: 1, right: 1),
                                  child: GridView(
                                    padding: const EdgeInsets.only(
                                        left: 1, right: 1, top: 1, bottom: 1),
                                    physics: const BouncingScrollPhysics(),
                                    scrollDirection: Axis.vertical,
                                    children: List<Widget>.generate(
                                      1,
                                      (int index) {
                                        final int count = 1;
                                        final Animation<double> animation =
                                            Tween<double>(begin: 0.0, end: 1.0)
                                                .animate(
                                          CurvedAnimation(
                                            parent: animationController!,
                                            curve: Interval(
                                                (1 / count) * index, 1.0,
                                                curve: Curves.fastOutSlowIn),
                                          ),
                                        );
                                        animationController?.forward();
                                        String name = ruregionreceipt
                                            .receiptRu24RegionalResultsrec[
                                                index]
                                            .cOURSENO!;
                                        List<ReceiptRu24RegionalResults>
                                            values = ruregionreceipt
                                                .receiptRu24RegionalResultsrec;
                                        return AreaView(
                                          index: index,
                                          name: name,
                                          values: values,
                                          animation: animation,
                                          animationController:
                                              animationController!,
                                        );
                                      },
                                    ),
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 1,
                                      mainAxisSpacing: 24.0,
                                      crossAxisSpacing: 24.0,
                                      childAspectRatio: 1.0,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
        },
      ),
    );
  }

  Container fee(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width *
          0.68, // Set a fixed width for the container
      margin: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: Color.fromARGB(255, 184, 220, 250)),
      ),
      child: AnimatedBuilder(
        animation: widget.mainScreenAnimationController!,
        builder: (BuildContext context, Widget? child) {
          var feeData = context.watch<RuregionReceiptProvider>();
          return feeData.isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Stack(
                  children: <Widget>[
                    SizedBox(
                      height: MediaQuery.of(context).padding.bottom,
                    ),
                    FadeTransition(
                      opacity: widget.mainScreenAnimation!,
                      child: Transform(
                        transform: Matrix4.translationValues(
                            0.0,
                            30 * (1.0 - widget.mainScreenAnimation!.value),
                            0.0),
                        child: AspectRatio(
                          aspectRatio: 1.0,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 1, right: 1),
                            child: GridView(
                              padding: const EdgeInsets.only(
                                  left: 1, right: 1, top: 1, bottom: 1),
                              physics: const BouncingScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              children: List<Widget>.generate(
                                1,
                                (int index) {
                                  final int count = 1;
                                  final Animation<double> animation =
                                      Tween<double>(begin: 0.0, end: 1.0)
                                          .animate(
                                    CurvedAnimation(
                                      parent: animationController!,
                                      curve: Interval((1 / count) * index, 1.0,
                                          curve: Curves.fastOutSlowIn),
                                    ),
                                  );
                                  animationController?.forward();
                                  String name = feeData
                                      .enrollruregion
                                      .receiptDetailRegionalResults![index]
                                      .fEENAME!;
                                  List<ReceiptDetailRegionalResults> values =
                                      feeData.enrollruregion
                                          .receiptDetailRegionalResults!;
                                  return AreaViewFee(
                                    index: index,
                                    name: name,
                                    values: feeData.enrollruregion
                                        .receiptDetailRegionalResults!,
                                    animation: animation,
                                    animationController: animationController!,
                                  );
                                },
                              ),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 1,
                                mainAxisSpacing: 24.0,
                                crossAxisSpacing: 24.0,
                                childAspectRatio: 1.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
        },
      ),
    );
  }
}

class AreaViewFee extends StatelessWidget {
  const AreaViewFee({
    Key? key,
    this.index,
    this.name,
    this.values,
    this.animationController,
    this.animation,
  }) : super(key: key);

  final int? index;
  final String? name;
  final List<ReceiptDetailRegionalResults>? values;

  final AnimationController? animationController;
  final Animation<double>? animation;

  @override
  Widget build(BuildContext context) {
    var ruregisfeeProv = context.watch<RuregionReceiptProvider>();
    // var feeData = context.watch<RuregionReceiptProvider>().receiptDetailRegionalResultsrec;
    var receiptheader =
        context.watch<RuregionReceiptProvider>().receiptRegionalResultsrec;
    return AnimatedBuilder(
      animation: animationController!,
      builder: (BuildContext context, Widget? child) {
        return FadeTransition(
          opacity: animation!,
          child: Transform(
            transform: Matrix4.translationValues(
                0.0, 50 * (1.0 - animation!.value), 0.0),
            child: Container(
              decoration: BoxDecoration(
                color: FitnessAppTheme.white,
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(8.0),
                    bottomLeft: Radius.circular(8.0),
                    bottomRight: Radius.circular(8.0),
                    topRight: Radius.circular(8.0)),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: FitnessAppTheme.grey.withOpacity(0.4),
                      offset: const Offset(1.1, 1.1),
                      blurRadius: 10.0),
                ],
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  focusColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                  splashColor: FitnessAppTheme.nearlyDarkBlue.withOpacity(0.2),
                  onTap: () {},
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.only(
                            left: 10, bottom: 1, top: 10, right: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'รายการค่าธรรมเนียม',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontFamily: AppTheme.ruFontKanit,
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                                color: Color.fromARGB(255, 146, 145, 145),
                              ),
                            ),
                            Text(
                              'ราคา', // Replace with your right-aligned text
                              textAlign: TextAlign.end,
                              style: TextStyle(
                                fontFamily: AppTheme.ruFontKanit,
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                                color: Color.fromARGB(255, 146, 145, 145),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(
                            left: 8, top: 0, right: 5, bottom: 10),
                        // ❌ ไม่ต้องกำหนด height ให้พอดีกับข้อมูลอัตโนมัติ
                        child: Column(
                          children: List.generate(values!.length, (index) {
                            return Container(
                              height: 25,
                              child: ListTile(
                                dense: true,
                                contentPadding: EdgeInsets.zero,
                                title: Text(
                                  '${values![index].fEENAME}',
                                  style: TextStyle(
                                    fontFamily: AppTheme.ruFontKanit,
                                    fontSize: 16,
                                    color: FitnessAppTheme.nearlyBlack,
                                  ),
                                ),
                                trailing: Text(
                                  _formatAmount(values![index].fEEAMOUNT),
                                  style: TextStyle(
                                    fontFamily: AppTheme.ruFontKanit,
                                    fontSize: 16,
                                    color: FitnessAppTheme.nearlyBlack,
                                  ),
                                ),
                              ),
                            );
                          }),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(
                            left: 10, bottom: 1, top: 10, right: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontFamily: AppTheme.ruFontKanit,
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                                color: FitnessAppTheme.nearlyBlack,
                              ),
                            ),
                            // Text(
                            //   'รวม ${receiptheader[0].tOTALAMOUNT} บาท', // Replace with your right-aligned text
                            //   textAlign: TextAlign.end,
                            //   style: TextStyle(
                            //     fontFamily: AppTheme.ruFontKanit,
                            //     fontWeight: FontWeight.w600,
                            //     fontSize: 18,
                            //     color: FitnessAppTheme.nearlyBlack,
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
    /// ✅ ฟังก์ชันจัดรูปแบบตัวเลข เช่น 1000 → 1,000
  String _formatAmount(dynamic amount) {
    try {
      final numValue = num.parse(amount.toString());
      final formatter = NumberFormat('#,###');
      return formatter.format(numValue);
    } catch (e) {
      return amount.toString(); // ถ้าไม่ใช่ตัวเลข คืนค่าเดิม
    }
  }
}

class AreaView extends StatelessWidget {
  const AreaView({
    Key? key,
    this.index,
    this.name,
    this.values,
    this.animationController,
    this.animation,
  }) : super(key: key);

  final int? index;
  final String? name;
  final List<ReceiptRu24RegionalResults>? values;
  final AnimationController? animationController;
  final Animation<double>? animation;

  @override
  Widget build(BuildContext context) {
    var sumcredit = context.watch<RuregionReceiptProvider>().sumIntCredit;
    bool isCourseDup = true;
    isCourseDup = context.watch<RuregionCheckCartProvider>().isCourseDup;

    return AnimatedBuilder(
      animation: animationController!,
      builder: (BuildContext context, Widget? child) {
        return FadeTransition(
          opacity: animation!,
          child: Transform(
            transform: Matrix4.translationValues(
                0.0, 50 * (1.0 - animation!.value), 0.0),
            child: Container(
              decoration: BoxDecoration(
                color: FitnessAppTheme.white,
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(8.0),
                    bottomLeft: Radius.circular(8.0),
                    bottomRight: Radius.circular(8.0),
                    topRight: Radius.circular(8.0)),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: FitnessAppTheme.grey.withOpacity(0.4),
                      offset: const Offset(1.1, 1.1),
                      blurRadius: 10.0),
                ],
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  focusColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                  splashColor: FitnessAppTheme.nearlyDarkBlue.withOpacity(0.2),
                  onTap: () {},
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.only(
                            left: 10, bottom: 1, top: 10, right: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            RichText(
                              textAlign: TextAlign.start,
                              text: TextSpan(
                                style: TextStyle(
                                  fontFamily: AppTheme.ruFontKanit,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18,
                                ),
                                children: [
                                  TextSpan(
                                    text: 'ทั้งหมด ',
                                    style: TextStyle(
                                        color:
                                            Color.fromARGB(255, 146, 145, 145)),
                                  ),
                                  TextSpan(
                                    text: '${values!.length}',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  TextSpan(
                                    text: ' วิชา',
                                    style: TextStyle(
                                        color:
                                            Color.fromARGB(255, 146, 145, 145)),
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              'วันและคาบสอบ', // Replace with your right-aligned text
                              textAlign: TextAlign.end,
                              style: TextStyle(
                                fontFamily: AppTheme.ruFontKanit,
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                                color: Color.fromARGB(255, 146, 145, 145),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(
                            left: 8, top: 0, right: 5, bottom: 10),
                        // เอา height ออก เพื่อให้สูงพอดีเนื้อหา
                        child: Column(
                          children: List.generate(values!.length, (index) {
                            return Container(
                              height: 25,
                              child: ListTile(
                                dense: true,
                                contentPadding: EdgeInsets.zero,
                                title: RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text:
                                            '${index + 1}. ${values![index].cOURSENO} (${values![index].cREDIT})',
                                        style: TextStyle(
                                          fontFamily: AppTheme.ruFontKanit,
                                          fontSize: 16,
                                          color: FitnessAppTheme.nearlyBlack,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                trailing: RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text:
                                            ' ${values![index].eXAMDATE} (${values![index].eXAMPERIOD})',
                                        style: TextStyle(
                                          fontFamily: AppTheme.ruFontKanit,
                                          fontSize: 16,
                                          color: FitnessAppTheme.nearlyBlack,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
      
    );
    
  }
  
}
