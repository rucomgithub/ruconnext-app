import 'package:th.ac.ru.uSmart/app_theme.dart';
import 'package:th.ac.ru.uSmart/fitness_app/models/grade_list_data.dart';
import 'package:th.ac.ru.uSmart/main.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:th.ac.ru.uSmart/model/rotcs_register.dart';
import 'package:th.ac.ru.uSmart/providers/rotcs_provider.dart';

class RotcsRegisterListView extends StatefulWidget {
  const RotcsRegisterListView(
      {Key? key, this.mainScreenAnimationController, this.mainScreenAnimation})
      : super(key: key);

  final AnimationController? mainScreenAnimationController;
  final Animation<double>? mainScreenAnimation;

  @override
  _RotcsRegisterListViewState createState() => _RotcsRegisterListViewState();
}

class _RotcsRegisterListViewState extends State<RotcsRegisterListView>
    with TickerProviderStateMixin {
  AnimationController? animationController;
  List<GradeListData> gradeListData = GradeListData.tabIconsList;

  @override
  void initState() {
    Provider.of<RotcsProvider>(context, listen: false).getAllRegister();
    animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    super.initState();
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
    var loading = context.watch<RotcsProvider>().isLoading;
    var register = context.watch<RotcsProvider>().rotcsregister;
    var error = context.watch<RotcsProvider>().rotcserror;
    return loading
        ? Container(child: SizedBox())
        : Column(
            children: [
              AnimatedBuilder(
                animation: widget.mainScreenAnimationController!,
                builder: (BuildContext context, Widget? child) {
                  return FadeTransition(
                    opacity: widget.mainScreenAnimation!,
                    child: Transform(
                      transform: Matrix4.translationValues(0.0,
                          30 * (1.0 - widget.mainScreenAnimation!.value), 0.0),
                      child: Container(
                        height: register.detail!.length > 0 ? 200 : 10,
                        width: double.infinity,
                        child: ListView.builder(
                          padding: const EdgeInsets.only(
                              top: 0, bottom: 0, right: 16, left: 16),
                          itemCount: register.detail!.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (BuildContext context, int index) {
                            final int count = register.detail!.length > 10
                                ? 10
                                : register.detail!.length;
                            final Animation<double> animation =
                                Tween<double>(begin: 0.0, end: 1.0).animate(
                                    CurvedAnimation(
                                        parent: animationController!,
                                        curve: Interval(
                                            (1 / count) * index, 1.0,
                                            curve: Curves.fastOutSlowIn)));
                            animationController?.forward();
                            //return Text('data');
                            return RotcsRegesterItemView(
                              detail: register.detail![index],
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

class RotcsRegesterItemView extends StatelessWidget {
  const RotcsRegesterItemView(
      {Key? key, this.detail, this.animationController, this.animation})
      : super(key: key);

  final RotcsRegisterDetail? detail;
  final AnimationController? animationController;
  final Animation<double>? animation;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double baseFontSize =
        screenWidth < 600 ? screenWidth * 0.05 : screenWidth * 0.03;
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
                width: screenWidth * 0.45,
                child: Stack(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 8, left: 8, right: 8, bottom: 8),
                      child: Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/images/ID.png'),
                            fit: BoxFit.cover,
                            opacity: 0.04,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: AppTheme.ru_dark_blue.withOpacity(0.4),
                              spreadRadius: 2,
                              blurRadius: 4,
                              offset: Offset(4, 4),
                            ),
                          ],
                          gradient: LinearGradient(
                            colors: <HexColor>[
                              HexColor("#FF19196B"),
                              HexColor("#FF1919EB"),
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
                              top: 50, left: 16, right: 8, bottom: 8),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'ประจำปี ${detail!.yearReport}',
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontFamily: AppTheme.ruFontKanit,
                                      fontSize: baseFontSize - 8,
                                      color: AppTheme.nearlyWhite,
                                    ),
                                  ),
                                  Text(
                                    'สถานศึกษาวิชาทหาร ${detail!.locationArmy}',
                                    style: TextStyle(
                                      fontFamily: AppTheme.ruFontKanit,
                                      fontSize: baseFontSize - 10,
                                      color: AppTheme.white,
                                    ),
                                  ),
                                  Text(
                                    '${detail!.typeReport}',
                                    style: TextStyle(
                                      fontFamily: AppTheme.ruFontKanit,
                                      fontSize: baseFontSize - 8,
                                      color: AppTheme.ru_yellow,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
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
                                    child: Icon(Icons.save),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      child: Text(
                                        'ชั้นปีที่ ${detail!.layerReport}',
                                        style: TextStyle(
                                          fontFamily: AppTheme.ruFontKanit,
                                          fontSize: baseFontSize - 6,
                                          color: AppTheme.ru_yellow,
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
                      top: 10,
                      left: 10,
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: AppTheme.nearlyWhite.withOpacity(0.2),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 15,
                      left: 15,
                      child: SizedBox(
                        width: 30,
                        height: 30,
                        child: CircleAvatar(
                          backgroundImage:
                              AssetImage('assets/fitness_app/AF1.png'),
                          radius: 50,
                        ),
                        //child: Text(gradeListData!.),
                      ),
                    ),
                    Positioned(
                      top: 20,
                      left: 55,
                      child: Container(
                        child: Text(
                          'รายงานตัว นศท.',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontFamily: AppTheme.ruFontKanit,
                            fontSize: baseFontSize - 4,
                            color: AppTheme.ru_yellow,
                          ),
                        ),
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
