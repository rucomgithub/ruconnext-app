import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:th.ac.ru.uSmart/app_theme.dart';
import 'package:th.ac.ru.uSmart/providers/ruregion_check_cart.dart';
import 'package:th.ac.ru.uSmart/providers/ruregis_provider.dart';
import '../../fitness_app/fitness_app_theme.dart';

class LocationExamView extends StatefulWidget {
  const LocationExamView({
    Key? key,
    this.mainScreenAnimationController,
    this.mainScreenAnimation,
  }) : super(key: key);

  final AnimationController? mainScreenAnimationController;
  final Animation<double>? mainScreenAnimation;

  @override
  _LocationExamViewState createState() => _LocationExamViewState();
}

class _LocationExamViewState extends State<LocationExamView>
    with TickerProviderStateMixin {
  AnimationController? animationController;

  @override
  void initState() {
    super.initState();
    _loadData(); // โหลดข้อมูลตอนเปิดครั้งแรก
  }

  Future<void> _loadData() async {
    final provider =
        Provider.of<RuregionCheckCartProvider>(context, listen: false);
    provider.loadSavedStatus(); // ✅ โหลดค่าที่บันทึกไว้ก่อนหน้า
    provider.fetchLocationExam(); // ✅ โหลดศูนย์สอบ

    animationController = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
  }

  void _openReceiptPage() async {
    await Navigator.pushNamed(context, '/ruregionAppreceipt');

    print('📦 กลับมาจากหน้า receipt แล้ว');
    _loadData(); // refresh อีกครั้ง
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
        var provider = context.watch<RuregionCheckCartProvider>();
        var locationexam = provider.locationexam;
        var isLoading = provider.isLoadingLocation;
        var ruregisProv = context.watch<RuregisProvider>().ruregionApp;

        return isLoading
            ? const Center(child: CircularProgressIndicator())
            : Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // ✅ Checkbox ขอจบ
                    if (ruregisProv.gRADUATESTATUS!)
                      Container(
                        margin: const EdgeInsets.only(right: 8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.1),
                              offset: const Offset(1, 1),
                              blurRadius: 3,
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Row(
                            children: [
                              Checkbox(
                                checkColor: Colors.white,
                                value: provider.statusGrad,
                                onChanged: (bool? value) {
                                  provider.getStatusGraduate(value ?? false);
                                  provider.checkButtonComfirm();
                                },
                              ),
                              const Text(
                                'ขอจบ',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.black87,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                    // ✅ Dropdown ศูนย์สอบ
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12.0),
                          border: Border.all(
                            color: provider.examLocation.isEmpty
                                ? Colors.red
                                : Colors.blue,
                            width: provider.examLocation.isEmpty ? 2.0 : 1.0,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withValues(alpha: 0.5),
                              spreadRadius: 2,
                              blurRadius: 7,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: DropdownButtonFormField<String>(
                          decoration: const InputDecoration(
                            hintText: 'เลือกศูนย์สอบ',
                            filled: true,
                            border: InputBorder.none,
                          ),
                          initialValue: provider.examLocation.isEmpty
                              ? null
                              : provider.examLocation,
                          dropdownColor: Colors.white,
                          items: locationexam.results
                                  ?.map((item) => DropdownMenuItem<String>(
                                        value: item.rEGIONALEXAMNO.toString(),
                                        child: Text(
                                          item.eXAMLOCATIONNAMETHAI.toString(),
                                          style: TextStyle(
                                            fontFamily: AppTheme.ruFontKanit,
                                            fontWeight: FontWeight.normal,
                                            fontSize: 12,
                                            color: FitnessAppTheme.nearlyBlack,
                                          ),
                                        ),
                                      ))
                                  .toList() ??
                              [],
                          onChanged: (newVal) {
                            if (newVal != null) {
                              provider.getLocationExam(newVal);
                              provider.checkButtonComfirm();

                              if (!provider.isCourseDup ||
                                  !provider.isSuccessCalpay) {
                                showCloseApp(context);
                              }
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              );
      },
    );
  }

  void showCloseApp(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        var provider = context.watch<RuregionCheckCartProvider>();
        List<TextSpan> textSpans = [];

        if (!provider.isCourseDup) {
          textSpans.add(TextSpan(
            text: '• ${provider.msgDup}\n\n',
            style: TextStyle(
              fontFamily: AppTheme.ruFontKanit,
              fontSize: 15,
              color: FitnessAppTheme.nearlyBlack,
            ),
          ));
        }

        if (!provider.isSuccessCalpay) {
          textSpans.add(TextSpan(
            text: '• ${provider.summary.message}',
            style: TextStyle(
              fontFamily: AppTheme.ruFontKanit,
              fontSize: 15,
              color: FitnessAppTheme.nearlyBlack,
            ),
          ));
        }

        return AlertDialog(
          content: Text.rich(TextSpan(children: textSpans)),
          actions: [
            TextButton(
              child: Text(
                'ตกลง',
                style: TextStyle(
                  fontFamily: AppTheme.ruFontKanit,
                  color: Color.fromARGB(255, 54, 82, 60),
                ),
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      },
    );
  }
}
