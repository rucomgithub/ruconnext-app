import 'package:flip_card/flip_card.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:th.ac.ru.uSmart/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:th.ac.ru.uSmart/master/models/master_grade_list_data.dart';
import 'package:th.ac.ru.uSmart/master/pages/master_Image_graduate.dart';
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
    return studentProv.student.stdcode!.isEmpty
        ? Center(
            child: Container(
              margin: const EdgeInsets.all(16.0),
              padding:
                  const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 240, 232, 232),
                borderRadius: BorderRadius.circular(16.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8.0,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.error_outline,
                    size: 48,
                    color: Colors.redAccent,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    '${studentProv.error}',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          )
        : AnimatedBuilder(
            animation: widget.mainScreenAnimationController!,
            builder: (BuildContext context, Widget? child) {
              return FadeTransition(
                opacity: widget.mainScreenAnimation!,
                child: Transform(
                  transform: Matrix4.translationValues(
                      0.0, 30 * (1.0 - widget.mainScreenAnimation!.value), 0.0),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 20.0),
                      child: AspectRatio(
                        aspectRatio: 0.63,
                        child: FlipCard(
                          direction: FlipDirection.HORIZONTAL,
                          speed: 1000,
                          onFlipDone: (status) {
                            // print(status);
                          },
                          front: ClipRRect(
                            borderRadius: BorderRadius.circular(16.0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: AppTheme.white,
                                image: DecorationImage(
                                  image:
                                      const AssetImage('assets/images/ID.png'),
                                  fit: BoxFit.cover,
                                  opacity: isLightMode ? 0.85 : 0.45,
                                ),
                                boxShadow: const <BoxShadow>[
                                  BoxShadow(
                                      color: AppTheme.ru_yellow,
                                      offset: Offset(2.0, 2.0),
                                      blurRadius: 12.0,
                                      spreadRadius: 1.0),
                                ],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                              width: 50,
                                              height: 60,
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                                child: Image.asset(
                                                  'assets/images/Logo_VecRu_Thai.png',
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(width: 10),
                                            Flexible(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'มหาวิทยาลัยรามคำแหง',
                                                    style:
                                                        AppTheme.body1.copyWith(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 13,
                                                    ),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                  Text(
                                                    'Ramkhamhaeng University',
                                                    style: AppTheme.body2
                                                        .copyWith(fontSize: 10),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 4),
                                        Container(
                                          height: 4,
                                          decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                              colors: [
                                                getFacultyMasterColor(
                                                    studentProv.student
                                                        .facultynamethai!),
                                                getFacultyMasterColor(
                                                        studentProv.student
                                                            .facultynamethai!)
                                                    .withOpacity(0.3),
                                              ],
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(2),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: 140,
                                          height: 160,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            boxShadow: [
                                              BoxShadow(
                                                color: getFacultyMasterColor(
                                                        studentProv.student
                                                            .facultynamethai!)
                                                    .withOpacity(0.3),
                                                blurRadius: 12,
                                                offset: const Offset(0, 4),
                                                spreadRadius: 2,
                                              ),
                                            ],
                                          ),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            child: MasterImageGraduate(),
                                          ),
                                        ),
                                        const SizedBox(height: 16),
                                        Container(
                                          width: double.infinity,
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 16, vertical: 12),
                                          decoration: BoxDecoration(
                                            color: AppTheme.ru_dark_blue
                                                .withOpacity(0.95),
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            boxShadow: [
                                              BoxShadow(
                                                color: AppTheme.ru_yellow
                                                    .withOpacity(0.2),
                                                blurRadius: 8,
                                                offset: const Offset(0, 2),
                                              ),
                                            ],
                                          ),
                                          child: Column(
                                            children: [
                                              Text(
                                                studentProv.student.namethai!,
                                                style: const TextStyle(
                                                  color: AppTheme.ru_yellow,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily:
                                                      AppTheme.ruFontKanit,
                                                ),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.center,
                                              ),
                                              const SizedBox(height: 4),
                                              Text(
                                                studentProv.student.nameeng!,
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 12,
                                                  fontFamily:
                                                      AppTheme.ruFontKanit,
                                                ),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.center,
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(height: 12),
                                        Container(
                                          width: double.infinity,
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 16, vertical: 10),
                                          decoration: BoxDecoration(
                                            color: AppTheme.ru_yellow
                                                .withOpacity(0.95),
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            boxShadow: [
                                              BoxShadow(
                                                color: AppTheme.ru_dark_blue
                                                    .withOpacity(0.2),
                                                blurRadius: 8,
                                                offset: const Offset(0, 2),
                                              ),
                                            ],
                                          ),
                                          child: Column(
                                            children: [
                                              Text(
                                                studentProv
                                                    .student.majornamethai!,
                                                style: const TextStyle(
                                                  color: AppTheme.ru_dark_blue,
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily:
                                                      AppTheme.ruFontKanit,
                                                ),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.center,
                                              ),
                                              const SizedBox(height: 4),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    Icons.location_on,
                                                    size: 12,
                                                    color: AppTheme.ru_dark_blue
                                                        .withOpacity(0.7),
                                                  ),
                                                  const SizedBox(width: 4),
                                                  Flexible(
                                                    child: Text(
                                                      studentProv.student
                                                          .regionalnamethai!,
                                                      style: TextStyle(
                                                        fontSize: 10,
                                                        color: AppTheme
                                                            .ru_dark_blue
                                                            .withOpacity(0.8),
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black
                                                    .withOpacity(0.1),
                                                blurRadius: 6,
                                                offset: const Offset(0, 2),
                                              ),
                                            ],
                                          ),
                                          child: QrImageView(
                                            data: authen.profile.studentCode!,
                                            version: QrVersions.auto,
                                            size: 70,
                                            gapless: false,
                                          ),
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8.0),
                                            child: Column(
                                              children: [
                                                Text(
                                                  'รหัสนักศึกษา',
                                                  style: TextStyle(
                                                    fontSize: 10,
                                                    color: AppTheme.ru_dark_blue
                                                        .withOpacity(0.7),
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                                const SizedBox(height: 4),
                                                Text(
                                                  authen.profile.studentCode!,
                                                  style: const TextStyle(
                                                    fontSize: 14,
                                                    color:
                                                        AppTheme.ru_dark_blue,
                                                    fontWeight: FontWeight.bold,
                                                    letterSpacing: 1,
                                                  ),
                                                ),
                                              ],
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
                          back: ClipRRect(
                            borderRadius: BorderRadius.circular(16.0),
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    AppTheme.ru_dark_blue,
                                    AppTheme.ru_dark_blue.withOpacity(0.9),
                                  ],
                                ),
                                boxShadow: const <BoxShadow>[
                                  BoxShadow(
                                      color: AppTheme.ru_yellow,
                                      offset: Offset(2.0, 2.0),
                                      blurRadius: 12.0,
                                      spreadRadius: 1.0),
                                ],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(24.0),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Column(
                                      children: [
                                        SizedBox(
                                          width: 60,
                                          height: 70,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(12.0),
                                            child: Image.asset(
                                              'assets/images/Logo_VecRu_Thai.png',
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 12),
                                        const Text(
                                          'มหาวิทยาลัยรามคำแหง',
                                          style: TextStyle(
                                            color: AppTheme.ru_yellow,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: AppTheme.ruFontKanit,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        const Text(
                                          'Ramkhamhaeng University',
                                          style: TextStyle(
                                            color: Colors.white70,
                                            fontSize: 11,
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        Container(
                                          height: 2,
                                          width: 100,
                                          decoration: BoxDecoration(
                                            color: AppTheme.ru_yellow,
                                            borderRadius:
                                                BorderRadius.circular(1),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Expanded(
                                      child: Center(
                                        child: Container(
                                          constraints: const BoxConstraints(
                                              maxWidth: 220),
                                          padding: const EdgeInsets.all(20.0),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(20.0),
                                            boxShadow: [
                                              BoxShadow(
                                                color: AppTheme.ru_yellow
                                                    .withOpacity(0.4),
                                                blurRadius: 16,
                                                spreadRadius: 3,
                                              ),
                                            ],
                                          ),
                                          child: QrImageView(
                                            data: authen.profile.studentCode!,
                                            version: QrVersions.auto,
                                            size: 180,
                                            gapless: false,
                                            embeddedImage: const AssetImage(
                                                'assets/images/Logo_VecRu_Thai.png'),
                                            embeddedImageStyle:
                                                const QrEmbeddedImageStyle(
                                              size: Size(50, 50),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Column(
                                      children: [
                                        const Text(
                                          'Student ID',
                                          style: TextStyle(
                                            color: Colors.white70,
                                            fontSize: 11,
                                            letterSpacing: 1,
                                          ),
                                        ),
                                        const SizedBox(height: 6),
                                        Text(
                                          authen.profile.studentCode!,
                                          style: const TextStyle(
                                            color: AppTheme.ru_yellow,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: 2,
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
                    ),
                  ),
                ),
              );
            },
          );
  }
}
