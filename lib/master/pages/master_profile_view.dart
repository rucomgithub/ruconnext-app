import 'package:flip_card/flip_card.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:th.ac.ru.uSmart/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:th.ac.ru.uSmart/master/models/master_grade_list_data.dart';
import 'package:th.ac.ru.uSmart/master/pages/master_image_loader.dart';
import 'package:th.ac.ru.uSmart/master/providers/master_provider.dart';
import 'package:th.ac.ru.uSmart/providers/authenprovider.dart';
import 'package:th.ac.ru.uSmart/utils/faculty_color.dart';

class MasterProfileView extends StatefulWidget {
  const MasterProfileView(
      {Key? key, this.mainScreenAnimationController, this.mainScreenAnimation})
      : super(key: key);

  final AnimationController? mainScreenAnimationController;
  final Animation<double>? mainScreenAnimation;

  @override
  _MasterProfileViewState createState() => _MasterProfileViewState();
}

class _MasterProfileViewState extends State<MasterProfileView>
    with TickerProviderStateMixin {
  AnimationController? animationController;
  List<MasterGradeListData> gradeListData = MasterGradeListData.tabIconsList;

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 200), vsync: this);
    super.initState();
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 100));
    return true;
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var authen = context.read<AuthenProvider>();
    var studentProv = context.watch<MasterProvider>();
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isLightMode = brightness == Brightness.light;
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double baseFontSize =
        screenWidth < 600 ? screenWidth * 0.05 : screenWidth * 0.03;

    return studentProv.student.stdcode!.isEmpty
        ? Container(
            padding:
                const EdgeInsets.only(top: 8, bottom: 8, right: 0, left: 0),
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 240, 232, 232),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8.0),
                  bottomLeft: Radius.circular(8.0),
                  bottomRight: Radius.circular(8.0),
                  topRight: Radius.circular(48.0)),
            ),
            child: Text('${studentProv.error}'))
        : AnimatedBuilder(
            animation: widget.mainScreenAnimationController!,
            builder: (BuildContext context, Widget? child) {
              return FadeTransition(
                opacity: widget.mainScreenAnimation!,
                child: Transform(
                  transform: Matrix4.translationValues(
                      0.0, 30 * (1.0 - widget.mainScreenAnimation!.value), 0.0),
                  child: Container(
                    height: screenHeight * 0.85,
                    width: double.infinity,
                    child: Card(
                      elevation: 0.0,
                      margin: const EdgeInsets.only(
                          left: 10.0, right: 10.0, top: 10.0, bottom: 10.0),
                      color: const Color(0x00000000),
                      child: FlipCard(
                        direction: FlipDirection.HORIZONTAL,
                        speed: 1000,
                        onFlipDone: (status) {
                          // print(status);
                        },
                        front: Container(
                          decoration: BoxDecoration(
                            color: AppTheme.white,
                            image: DecorationImage(
                              image: AssetImage('assets/images/ID.png'),
                              fit: BoxFit.cover,
                              opacity: isLightMode ? 0.8 : 0.4,
                            ),
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                  color: AppTheme.ru_yellow,
                                  offset: Offset(1.1, 1.1),
                                  blurRadius: 10.0),
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                      width: screenWidth * 0.15,
                                      height: screenHeight * 0.1,
                                      child: Padding(
                                        padding: EdgeInsets.all(7.0),
                                        child: ClipRRect(
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(10.0)),
                                          child: Image.asset(
                                              'assets/images/Logo_VecRu_Thai.png'),
                                        ),
                                      )),
                                  Container(
                                    width: screenWidth * 0.65,
                                    height: screenHeight * 0.08,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text('มหาวิทยาลัยรามคำแหง',
                                            style: TextStyle(
                                              fontFamily: AppTheme.ruFontKanit,
                                              fontSize: baseFontSize - 6,
                                              color: AppTheme.ru_dark_blue,
                                            )),
                                        Text('Ramkhamhaeng University',
                                            style: TextStyle(
                                              fontFamily: AppTheme.ruFontKanit,
                                              fontSize: baseFontSize - 6,
                                              color: AppTheme.ru_yellow,
                                            )),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Icon(
                                              Icons.credit_card_sharp,
                                              size: baseFontSize - 8,
                                              color: Colors.blue[900],
                                            ),
                                            SizedBox(width: 2),
                                            Text(
                                                'บัตรนักศึกษาอิเล็กทรอนิกส์ ${authen.roletext}',
                                                style: TextStyle(
                                                  fontFamily:
                                                      AppTheme.ruFontKanit,
                                                  fontSize: baseFontSize - 8,
                                                  color: AppTheme
                                                      .ru_text_ocean_blue,
                                                )),
                                          ],
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: screenWidth * 0.15,
                                    child: Column(
                                      children: [
                                        Container(
                                          height: screenHeight * 0.1,
                                          width: screenWidth * 0.05,
                                          decoration: BoxDecoration(
                                            color: getFacultyMasterColor(
                                                studentProv
                                                    .student.facultynamethai!),
                                            shape: BoxShape.rectangle,
                                            border: Border.all(
                                              color: Colors.black26,
                                              width: 1,
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 20),
                                        RotatedBox(
                                          quarterTurns:
                                              1, // Rotate 270 degrees (or 3 quarter-turns) counterclockwise
                                          child: Text(
                                            studentProv
                                                .student.regionalnamethai!,
                                            style: TextStyle(
                                              fontFamily: AppTheme.ruFontKanit,
                                              fontSize: baseFontSize - 10,
                                              color:
                                                  AppTheme.ru_text_ocean_blue,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: screenWidth * 0.6,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: MasterImageLoader(),
                                        ),
                                        Column(
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                color: AppTheme.ru_dark_blue,
                                                borderRadius: BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(10.0),
                                                    bottomLeft:
                                                        Radius.circular(3.0),
                                                    bottomRight:
                                                        Radius.circular(3.0),
                                                    topRight:
                                                        Radius.circular(10.0)),
                                                boxShadow: <BoxShadow>[
                                                  BoxShadow(
                                                      color: AppTheme.ru_yellow,
                                                      offset: Offset(1.1, 1.1),
                                                      blurRadius: 5.0),
                                                ],
                                              ),
                                              child: Container(
                                                height: screenHeight * 0.1,
                                                width: screenWidth * 0.6,
                                                child: Padding(
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            0, 20, 0, 20),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                            '${studentProv.student.namethai!}',
                                                            style: TextStyle(
                                                              fontFamily: AppTheme
                                                                  .ruFontKanit,
                                                              fontSize:
                                                                  baseFontSize -
                                                                      8,
                                                              color: AppTheme
                                                                  .ru_yellow,
                                                            )),
                                                        Text(
                                                            studentProv.student
                                                                .nameeng!,
                                                            style: TextStyle(
                                                              fontFamily: AppTheme
                                                                  .ruFontKanit,
                                                              fontSize:
                                                                  baseFontSize -
                                                                      8,
                                                              color: AppTheme
                                                                  .ru_yellow,
                                                            ))
                                                      ],
                                                    )),
                                              ), // Set the color for the red stripes
                                            ),
                                            Container(
                                              decoration: BoxDecoration(
                                                color: AppTheme.ru_yellow,
                                                borderRadius: BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(3.0),
                                                    bottomLeft:
                                                        Radius.circular(10.0),
                                                    bottomRight:
                                                        Radius.circular(10.0),
                                                    topRight:
                                                        Radius.circular(3.0)),
                                                boxShadow: <BoxShadow>[
                                                  BoxShadow(
                                                      color:
                                                          AppTheme.ru_dark_blue,
                                                      offset: Offset(1.1, 1.1),
                                                      blurRadius: 5.0),
                                                ],
                                              ),
                                              child: Container(
                                                height: screenHeight * 0.1,
                                                width: screenWidth * 0.6,
                                                child: Padding(
                                                    padding: EdgeInsets.all(8),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                            studentProv.student
                                                                .majornamethai!,
                                                            style: TextStyle(
                                                              fontFamily: AppTheme
                                                                  .ruFontKanit,
                                                              fontSize:
                                                                  baseFontSize -
                                                                      8,
                                                              color: AppTheme
                                                                  .ru_dark_blue,
                                                            )),
                                                        // Text(studentProv.student.facultynamethai!,
                                                        //     style: TextStyle(
                                                        //       fontFamily: AppTheme.ruFontKanit,
                                                        //       fontSize: baseFontSize - 8,
                                                        //       color: AppTheme.white,
                                                        //     ))
                                                      ],
                                                    )),
                                              ),
                                              // Set the color for the blue stripes
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: screenWidth * 0.15,
                                    child: QrImage(
                                      data: authen.profile.studentCode!,
                                      version: QrVersions.auto,
                                      size: screenWidth * 0.15,
                                      gapless: false,
                                    ),
                                  )
                                ],
                              ),
                              Padding(
                                padding:
                                    EdgeInsets.fromLTRB(0.0, 4.0, 0.0, 16.0),
                                child: Column(
                                  children: [
                                    Container(
                                      height: screenHeight * 0.1,
                                      width: screenWidth * 0.6,
                                      child: Padding(
                                        padding: EdgeInsets.all(5.0),
                                        child: Image.network(
                                            'http://beta-e-service.ru.ac.th:8001/misservice/generate/barcode.php?barcode=${authen.profile.email!.substring(0, 10)}&width=${screenWidth * 0.6}&height=${screenHeight * 0.1}'),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        back: Container(
                          decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 113, 156, 156),
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.0)),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              QrImage(
                                data: authen.profile.studentCode!,
                                version: QrVersions.auto,
                                size: screenWidth * 0.75,
                                gapless: false,
                                embeddedImage: AssetImage(
                                    'assets/images/Logo_VecRu_Thai.png'),
                                embeddedImageStyle: QrEmbeddedImageStyle(
                                  size: Size(50, 50),
                                ),
                              ),
                              Text('Back',
                                  style: Theme.of(context)
                                      .textTheme
                                      .displayMedium),
                            ],
                          ),
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
