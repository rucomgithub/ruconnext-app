import 'package:th.ac.ru.uSmart/app_theme.dart';
import 'package:th.ac.ru.uSmart/providers/region_receipt_provider.dart';
import 'package:th.ac.ru.uSmart/providers/ruregion_check_cart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../fitness_app/fitness_app_theme.dart';
import 'package:intl/intl.dart'; // อย่าลืม import

class ReceiptLocationExamView extends StatefulWidget {
  const ReceiptLocationExamView(
      {Key? key, this.mainScreenAnimationController, this.mainScreenAnimation})
      : super(key: key);

  final AnimationController? mainScreenAnimationController;
  final Animation<double>? mainScreenAnimation;
  @override
  _ReceiptLocationExamViewState createState() =>
      _ReceiptLocationExamViewState();
}

class _ReceiptLocationExamViewState extends State<ReceiptLocationExamView>
    with TickerProviderStateMixin {
  AnimationController? animationController;
  var dropdownvalue;
  @override
  void initState() {
    Provider.of<RuregionReceiptProvider>(context, listen: false)
        .getEnrollRegionProv('', '', '');
    animationController = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    super.initState();

    final provider =
        Provider.of<RuregionCheckCartProvider>(context, listen: false);
    provider.loadSavedStatus(); // ✅ โหลดค่าที่บันทึกไว้ก่อนหน้า
    provider.fetchLocationExam(); // ✅ โหลดศูนย์สอบ
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.mainScreenAnimationController!,
      builder: (BuildContext context, Widget? child) {
        var summary = context
            .watch<RuregionReceiptProvider>()
            .receiptRegionalResultsrec[0]
            .tOTALAMOUNT;
        var sumcredit = context.watch<RuregionReceiptProvider>().sumIntCredit;
        var courseregis = context
            .watch<RuregionReceiptProvider>()
            .receiptRu24RegionalResultsrec;
        var isLoading =
            context.watch<RuregionCheckCartProvider>().isLoadingLocation;
        return isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Container(
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 255, 255, 255),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                      offset: Offset(2, 2),
                    ),
                  ],
                ),
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'หน่วยกิตรวม',
                          style: TextStyle(
                            fontFamily: AppTheme.ruFontKanit,
                            fontWeight: FontWeight.normal,
                            fontSize: 18,
                            letterSpacing: 0.0,
                            color: FitnessAppTheme.nearlyBlack,
                          ),
                        ),
                        Text(
                          '$sumcredit หน่วย',
                          style: TextStyle(
                            fontFamily: AppTheme.ruFontKanit,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            letterSpacing: 0.0,
                            color: FitnessAppTheme.nearlyBlack,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'จำนวนวิชาลงทะเบียน',
                          style: TextStyle(
                            fontFamily: AppTheme.ruFontKanit,
                            fontWeight: FontWeight.normal,
                            fontSize: 18,
                            letterSpacing: 0.0,
                            color: FitnessAppTheme.nearlyBlack,
                          ),
                        ),
                        Text(
                          '${courseregis.length} วิชา',
                          style: TextStyle(
                            fontFamily: AppTheme.ruFontKanit,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            letterSpacing: 0.0,
                            color: FitnessAppTheme.nearlyBlack,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                        height: 10), // Add some space between the two texts
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'ค่าธรรมเนียมทั้งหมด',
                          style: TextStyle(
                            fontFamily: AppTheme.ruFontKanit,
                            fontWeight: FontWeight.normal,
                            fontSize: 18,
                            letterSpacing: 0.0,
                            color: FitnessAppTheme.nearlyBlack,
                          ),
                        ),
                        Text(
                          '${_formatAmount(summary)} บาท',
                          style: TextStyle(
                            fontFamily: AppTheme.ruFontKanit,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            letterSpacing: 0.0,
                            color: FitnessAppTheme.nearlyBlack,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
      },
    );
  }

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
