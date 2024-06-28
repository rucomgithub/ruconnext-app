import 'package:th.ac.ru.uSmart/app_theme.dart';
import 'package:th.ac.ru.uSmart/fitness_app/models/grade_list_data.dart';
import 'package:th.ac.ru.uSmart/main.dart';
import 'package:th.ac.ru.uSmart/model/insurance.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:th.ac.ru.uSmart/providers/insurance_provider.dart';

class InsuraceListView extends StatefulWidget {
  const InsuraceListView(
      {Key? key, this.mainScreenAnimationController, this.mainScreenAnimation})
      : super(key: key);

  final AnimationController? mainScreenAnimationController;
  final Animation<double>? mainScreenAnimation;

  @override
  _InsuraceListViewState createState() => _InsuraceListViewState();
}

class _InsuraceListViewState extends State<InsuraceListView>
    with TickerProviderStateMixin {
  AnimationController? animationController;
  List<GradeListData> gradeListData = GradeListData.tabIconsList;

  @override
  void initState() {
    //Provider.of<InsuranceProvider>(context, listen: false).getInsuracneAll();
    animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    super.initState();
  }

  Future<bool> getData() async {
    //Provider.of<InsuranceProvider>(context, listen: false).getInsuracneAll();
    await Future<dynamic>.delayed(const Duration(milliseconds: 600));
    return true;
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var loading = context.watch<InsuranceProvider>().isLoading;
    var insurance = context.watch<InsuranceProvider>().insurance;
    var insuranceerror = context.watch<InsuranceProvider>().insuranceerror;
    return loading
        ? Container(
            child: Column(
                children: [CircularProgressIndicator(), Text(insuranceerror)]))
        : Column(
            children: [
              Text(insuranceerror),
              AnimatedBuilder(
                animation: widget.mainScreenAnimationController!,
                builder: (BuildContext context, Widget? child) {
                  return FadeTransition(
                    opacity: widget.mainScreenAnimation!,
                    child: Transform(
                      transform: Matrix4.translationValues(0.0,
                          30 * (1.0 - widget.mainScreenAnimation!.value), 0.0),
                      child: Container(
                        height: insurance.detail!.length > 0 ? 250 : 10,
                        width: double.infinity,
                        child: ListView.builder(
                          padding: const EdgeInsets.only(
                              top: 0, bottom: 0, right: 16, left: 16),
                          itemCount: insurance.detail!.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (BuildContext context, int index) {
                            final int count = insurance.detail!.length > 10
                                ? 10
                                : insurance.detail!.length;
                            final Animation<double> animation =
                                Tween<double>(begin: 0.0, end: 1.0).animate(
                                    CurvedAnimation(
                                        parent: animationController!,
                                        curve: Interval(
                                            (1 / count) * index, 1.0,
                                            curve: Curves.fastOutSlowIn)));
                            animationController?.forward();
                            //return Text('data');
                            return InsuranceItemView(
                              detail: insurance.detail![index],
                              animation: animation,
                              animationController: animationController!,
                            );
                          },
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          );
  }
}

class InsuranceItemView extends StatelessWidget {
  const InsuranceItemView(
      {Key? key, this.detail, this.animationController, this.animation})
      : super(key: key);

  final Detail? detail;
  final AnimationController? animationController;
  final Animation<double>? animation;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController!,
      builder: (BuildContext context, Widget? child) {
        return FadeTransition(
          opacity: animation!,
          child: Transform(
            transform: Matrix4.translationValues(
                100 * (1.0 - animation!.value), 0.0, 0.0),
            child: InkWell(
              highlightColor: Colors.transparent,
              borderRadius: BorderRadius.all(Radius.circular(4.0)),
              onTap: () {
                // ondemand.ondemand.rECORD.detail.isEmpty
                // print(ondemand.error);
              },
              child: SizedBox(
                width: 280,
                child: Stack(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 32, left: 8, right: 8, bottom: 16),
                      child: Container(
                        decoration: BoxDecoration(
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                                color: HexColor('#000000').withOpacity(0.6),
                                offset: const Offset(1.1, 4.0),
                                blurRadius: 8.0),
                          ],
                          gradient: LinearGradient(
                            colors: <HexColor>[
                              HexColor('#1E88E5'),
                              HexColor('#64B5F6'),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: const BorderRadius.only(
                            bottomRight: Radius.circular(8.0),
                            bottomLeft: Radius.circular(8.0),
                            topLeft: Radius.circular(48.0),
                            topRight: Radius.circular(8.0),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 54, left: 16, right: 16, bottom: 8),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                '${detail!.nameInsurance!.toString()}',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: AppTheme.ruFontKanit,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  letterSpacing: 0.2,
                                  color: AppTheme.darkText,
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding:
                                      const EdgeInsets.only(top: 8, bottom: 8),
                                  child: SingleChildScrollView(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        SizedBox(
                                          height: 100.0,
                                          width: 200.0,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                '${detail?.expire?.toString() ?? ''}',
                                                style: TextStyle(
                                                  fontFamily:
                                                      AppTheme.ruFontKanit,
                                                  fontWeight: FontWeight.w200,
                                                  fontSize: 12,
                                                  letterSpacing: 0.2,
                                                  color: AppTheme.white,
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
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: <Widget>[
                                  Container(
                                    decoration: BoxDecoration(
                                      color: AppTheme.nearlyWhite,
                                      shape: BoxShape.circle,
                                      boxShadow: <BoxShadow>[
                                        BoxShadow(
                                            color: AppTheme.nearlyBlack
                                                .withOpacity(0.4),
                                            offset: Offset(2.0, 2.0),
                                            blurRadius: 4.0),
                                      ],
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: Image.asset(
                                          width: 30, 'assets/images/me.png'),
                                    ),
                                  ),
                                  Container(
                                    child: Padding(
                                      padding: const EdgeInsets.all(6.0),
                                      child: Text(
                                        detail!.studentCode.toString(),
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontFamily: AppTheme.ruFontKanit,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14,
                                          letterSpacing: 0.2,
                                          color: AppTheme.nearlyWhite,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 30,
                      left: 10,
                      child: Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: AppTheme.nearlyWhite.withOpacity(0.2),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 30,
                      left: 10,
                      child: SizedBox(
                        width: 40,
                        height: 40,
                        child: Image.asset('assets/images/news3.png'),
                        //child: Text(gradeListData!.),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
