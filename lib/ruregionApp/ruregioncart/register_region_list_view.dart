import 'package:th.ac.ru.uSmart/app_theme.dart';
import 'package:th.ac.ru.uSmart/model/checkregis_model.dart';

import 'package:th.ac.ru.uSmart/providers/ruregion_check_cart.dart';
import 'package:th.ac.ru.uSmart/providers/ruregis_mr30_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart'; // อย่าลืม import
import '../../fitness_app/fitness_app_theme.dart';
import '../../model/ruregion_mr30_model.dart';

class RuregionCartListView extends StatefulWidget {
  const RuregionCartListView(
      {Key? key, this.mainScreenAnimationController, this.mainScreenAnimation})
      : super(key: key);

  final AnimationController? mainScreenAnimationController;
  final Animation<double>? mainScreenAnimation;
  @override
  _RuregionCartListViewState createState() => _RuregionCartListViewState();
}

class _RuregionCartListViewState extends State<RuregionCartListView>
    with TickerProviderStateMixin {
  AnimationController? animationController;

  bool isChecked = false;
  @override
  void initState() {
    Provider.of<RuregionCheckCartProvider>(context, listen: false)
        .getCalPayRegionApp();
    Provider.of<RuregionCheckCartProvider>(context, listen: false)
        .isSuccessCalpay;
    // Provider.of<RuregionCheckCartProvider>(context, listen: false).courseSame();
    // Provider.of<RegisterProvider>(context, listen: false).getAllRegister();
    animationController = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    super.initState();
    // Timer.run(() {
    //   showCheckCredit(context);
    // });
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

  // void showCheckCredit(BuildContext context) {
  //   var ruregioncheckcart = context.watch<RuregionCheckCartProvider>();

  //   if (!ruregioncheckcart.isSuccessCalpay) {
  //     showDialog(
  //       context: context,
  //       builder: (context) {
  //         return AlertDialog(
  //           content: Column(
  //             mainAxisSize: MainAxisSize.min,
  //             children: [
  //               Text('${ruregioncheckcart.summary.message}'),
  //             ],
  //           ),
  //         );
  //       },
  //     );
  //   }
  // }

  Container mr30cart(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width *
          0.8, // Set a fixed width for the container
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
          var ruregioncheckcart = context.watch<RuregionCheckCartProvider>();
          return ruregioncheckcart.isLoadingCourse
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
                                        String name = ruregioncheckcart
                                            .mr30Apprec[index].cOURSENAME!;
                                        List<ResultsMr30> values =
                                            ruregioncheckcart.mr30Apprec;
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
          0.8, // Set a fixed width for the container
      margin: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: Color.fromARGB(255, 184, 220, 250)),
      ),
      child: AnimatedBuilder(
        animation: widget.mainScreenAnimationController!,
        builder: (BuildContext context, Widget? child) {
          var feeData = context.watch<RuregionCheckCartProvider>();
          return feeData.isLoadingCourse
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
                                  String name =
                                      feeData.summary.results![index].fEENAME!;
                                  List<ResultsFee> values =
                                      feeData.summary.results!;
                                  return AreaViewFee(
                                    index: index,
                                    name: name,
                                    values: feeData.summary.results!,
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
  final List<ResultsFee>? values;

  final AnimationController? animationController;
  final Animation<double>? animation;

  @override
  Widget build(BuildContext context) {
    // var ruregisfeeProv = context.watch<RuregionCheckCartProvider>();
    var feeData = context.watch<RuregionCheckCartProvider>().summary;

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
                      color: FitnessAppTheme.grey.withValues(alpha: 0.4),
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
                  splashColor:
                      FitnessAppTheme.nearlyDarkBlue.withValues(alpha: 0.2),
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
                                color: FitnessAppTheme.nearlyBlack,
                              ),
                            ),
                            Text(
                              'ราคา', // Replace with your right-aligned text
                              textAlign: TextAlign.end,
                              style: TextStyle(
                                fontFamily: AppTheme.ruFontKanit,
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                                color: FitnessAppTheme.nearlyBlack,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: values!.length * 30,
                        child: ListView.builder(
                          padding: const EdgeInsets.only(
                              left: 8, top: 0, right: 1, bottom: 0),
                          itemCount: values!.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              height: 25,
                              child: ListTile(
                                title: Text(
                                  '${values![index].fEENAME}  ',
                                  style: TextStyle(
                                    fontFamily: AppTheme.ruFontKanit,
                                    fontSize: 14,
                                    color: FitnessAppTheme.nearlyBlack,
                                  ),
                                ),
                                trailing: Text(
                                  '${_formatAmount(values![index].fEEAMOUNT)}',
                                  style: TextStyle(
                                    fontFamily: AppTheme.ruFontKanit,
                                    fontSize: 14,
                                    color: FitnessAppTheme.nearlyBlack,
                                  ),
                                ),
                              ),
                            );
                          },
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
                            Text(
                              'รวม ${_formatAmount(feeData.sumTotal)} บาท',
                              textAlign: TextAlign.end,
                              style: TextStyle(
                                fontFamily: AppTheme.ruFontKanit,
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                                color: FitnessAppTheme.nearlyBlack,
                              ),
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
  final List<ResultsMr30>? values;
  final AnimationController? animationController;
  final Animation<double>? animation;

  @override
  Widget build(BuildContext context) {
    var sumcredit = context.watch<RUREGISMR30Provider>().sumIntCredit;
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
                      color: FitnessAppTheme.grey.withValues(alpha: 0.4),
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
                  splashColor:
                      FitnessAppTheme.nearlyDarkBlue.withValues(alpha: 0.2),
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
                              'ทั้งหมด ${values!.length} วิชา ',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontFamily: AppTheme.ruFontKanit,
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                                color: FitnessAppTheme.nearlyBlack,
                              ),
                            ),
                            Text(
                              '$sumcredit หน่วยกิต', // Replace with y our right-aligned text
                              textAlign: TextAlign.end,
                              style: TextStyle(
                                fontFamily: AppTheme.ruFontKanit,
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                                color: FitnessAppTheme.nearlyBlack,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: values!.length * 30,
                        child: Builder(
                          builder: (context) {
                            // เรียงก่อนใช้ ListView
                            values!.sort((a, b) => a.cOURSENO!
                                .toLowerCase()
                                .compareTo(b.cOURSENO!.toLowerCase()));

                            return ListView.builder(
                              padding: const EdgeInsets.only(
                                  left: 8, top: 0, right: 1, bottom: 0),
                              itemCount: values!.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Container(
                                  height: 25,
                                  child: ListTile(
                                    title: RichText(
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                            text:
                                                '${index + 1}. ${values![index].cOURSENO} (${values![index].cREDIT})',
                                            style: TextStyle(
                                              fontFamily: AppTheme.ruFontKanit,
                                              fontSize: 14,
                                              color:
                                                  FitnessAppTheme.nearlyBlack,
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
                                                '${values![index].cOURSEDUP ?? ' '}',
                                            style: TextStyle(color: Colors.red),
                                          ),
                                          TextSpan(
                                            text:
                                                ' ${values![index].eXAMDATE} (${values![index].eXAMPERIOD})',
                                            style: TextStyle(
                                              fontFamily: AppTheme.ruFontKanit,
                                              fontSize: 14,
                                              color:
                                                  FitnessAppTheme.nearlyBlack,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      )
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
