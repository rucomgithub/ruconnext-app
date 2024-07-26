import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:th.ac.ru.uSmart/app_theme.dart';
import 'package:th.ac.ru.uSmart/pages/ImageLoader.dart';
import 'package:th.ac.ru.uSmart/providers/student_provider.dart';
import 'package:th.ac.ru.uSmart/utils/faculty_color.dart';
import 'package:th.ac.ru.uSmart/widget/Rubar.dart';
import 'package:th.ac.ru.uSmart/widget/ru_wallpaper.dart';
import 'package:th.ac.ru.uSmart/widget/top_bar.dart';
import '../login_page.dart';
import 'package:flutter/material.dart';
import '../model/homelist.dart';
import 'package:flip_card/flip_card.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../providers/authenprovider.dart';

class FlipCardPage extends StatefulWidget {
  const FlipCardPage({Key? key}) : super(key: key);

  @override
  _FlipCardPageState createState() => _FlipCardPageState();
}

class _FlipCardPageState extends State<FlipCardPage>
    with TickerProviderStateMixin {
  List<HomeList> homeList = HomeList.homeList;
  AnimationController? animationController;
  bool multiple = true;

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 800), vsync: this);
    super.initState();
    Provider.of<AuthenProvider>(context, listen: false).getProfile();
    Provider.of<StudentProvider>(context, listen: false).refreshData();
    Provider.of<StudentProvider>(context, listen: false).getImageProfile();
    Provider.of<StudentProvider>(context, listen: false).getStudent();
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
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double baseFontSize =
        screenWidth < 600 ? screenWidth * 0.05 : screenWidth * 0.03;
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isLightMode = brightness == Brightness.light;
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: AppTheme.nearlyWhite, // Change back arrow color to white
          ),
          title: Text(
            'บัตรนักศึกษา',
            style: TextStyle(
              fontSize: baseFontSize,
              fontFamily: AppTheme.ruFontKanit,
              color: AppTheme.nearlyWhite,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true, // Centers the title
          backgroundColor:
              AppTheme.ru_dark_blue, // Background color of the AppBar
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.help,
                color: AppTheme.nearlyWhite,
              ),
              onPressed: () {
                Get.toNamed("/cardhelp");
              },
            ),
          ],
        ),
        backgroundColor: isLightMode
            ? AppTheme.nearlyWhite
            : AppTheme.nearlyBlack.withOpacity(0.2),
        body: FutureBuilder<bool>(
            future: getData(),
            builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
              if (!snapshot.hasData) {
                return const SizedBox();
              } else {
                var authen = context.watch<AuthenProvider>();
                return authen.profile.studentCode != null
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Stack(
                              fit: StackFit.expand,
                              children: <Widget>[
                                RuWallpaper(),
                                Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: <Widget>[
                                    // _renderAppBar(context),
                                    Expanded(
                                      flex: 8,
                                      child: _renderContent(context),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      )
                    : LoginPage();
              }
            }));
  }

  _renderContent(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double baseFontSize =
        screenWidth < 600 ? screenWidth * 0.05 : screenWidth * 0.03;

    bool isLightMode = brightness == Brightness.light;

    var authen = context.watch<AuthenProvider>();
    var studentProv = context.watch<StudentProvider>();
    var region = studentProv.student.regionalnamethai!;
    region = region.replaceAll("จังหวัด", "");
    return Card(
      elevation: 0.0,
      margin: const EdgeInsets.only(
          left: 30.0, right: 30.0, top: 30.0, bottom: 30.0),
      color: const Color(0x00000000),
      child: FlipCard(
        direction: FlipDirection.HORIZONTAL,
        speed: 1000,
        onFlipDone: (status) {
          print(status);
        },
        front: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/ID.png'),
              fit: BoxFit.cover,
              opacity: 1.0,
            ),
            color: AppTheme.white,
            border: Border.all(
              color: AppTheme.white,
              width: 10,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10.0)),
                          child:
                              Image.asset('assets/images/Logo_VecRu_Thai.png'),
                        ),
                      )),
                  Container(
                    width: screenWidth * 0.5,
                    height: screenHeight * 0.08,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.credit_card_sharp,
                              size: baseFontSize - 6,
                              color: Colors.blue[900],
                            ),
                            SizedBox(width: 2),
                            Text('บัตรนักศึกษาอิเล็กทรอนิกส์',
                                style: TextStyle(
                                  fontFamily: AppTheme.ruFontKanit,
                                  fontSize: baseFontSize - 6,
                                  color: AppTheme.ru_text_ocean_blue,
                                )),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                  shape: BoxShape.rectangle,
                ),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(8.0, 16.0, 8.0, 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          Container(
                            height: screenHeight * 0.15,
                            width: screenWidth * 0.1,
                            decoration: BoxDecoration(
                              color: getFacultyColor(
                                  studentProv.student.facultynamethai!),
                              shape: BoxShape.rectangle,
                              border: Border.all(
                                color: Colors.black26,
                                width: 1,
                              ),
                            ),
                          ),
                          SizedBox(height: 8),
                          RotatedBox(
                            quarterTurns:
                                1, // Rotate 270 degrees (or 3 quarter-turns) counterclockwise
                            child: Text(
                              region,
                              style: TextStyle(
                                fontFamily: AppTheme.ruFontKanit,
                                fontSize: baseFontSize - 6,
                                color: AppTheme.ru_yellow,
                              ),
                            ),
                          )
                        ],
                      ),
                      ImageLoader(), //
                      QrImage(
                        data: authen.profile.studentCode!,
                        version: QrVersions.auto,
                        size: screenWidth * 0.15,
                        gapless: false,
                      )
                    ],
                  ),
                ),
              ),
              Container(
                height: screenHeight * 0.2,
                width: screenWidth * 0.6,
                child: Column(
                  children: [
                    Expanded(
                      flex: 4,
                      child: Container(
                        height: screenHeight * 0.1,
                        width: screenWidth * 0.6,
                        child: Container(
                          height: screenHeight * 0.05,
                          width: screenWidth * 0.6,
                          child: Padding(
                              padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('${studentProv.student.namethai!}',
                                      style: TextStyle(
                                        fontFamily: AppTheme.ruFontKanit,
                                        fontSize: baseFontSize - 6,
                                        color: AppTheme.white,
                                      )),
                                  Text(studentProv.student.nameeng!,
                                      style: TextStyle(
                                        fontFamily: AppTheme.ruFontKanit,
                                        fontSize: baseFontSize - 6,
                                        color: AppTheme.ru_yellow,
                                      ))
                                ],
                              )),
                        ),
                        color: AppTheme
                            .ru_dark_blue, // Set the color for the red stripes
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: Container(
                        height: screenHeight * 0.1,
                        width: screenWidth * 0.6,
                        child: Container(
                          height: screenHeight * 0.05,
                          width: screenWidth * 0.6,
                          child: Padding(
                              padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(studentProv.student.facultynamethai!,
                                      style: TextStyle(
                                        fontFamily: AppTheme.ruFontKanit,
                                        fontSize: baseFontSize - 6,
                                        color: AppTheme.ru_dark_blue,
                                      )),
                                  Text(studentProv.student.majornamethai!,
                                      style: TextStyle(
                                        fontFamily: AppTheme.ruFontKanit,
                                        fontSize: baseFontSize - 6,
                                        color: AppTheme.white,
                                      ))
                                ],
                              )),
                        ),
                        color: AppTheme
                            .ru_yellow, // Set the color for the blue stripes
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0.0, 4.0, 0.0, 16.0),
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
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              QrImage(
                data: studentProv.student.stdcode!,
                version: QrVersions.auto,
                size: screenWidth * 0.8,
                gapless: false,
                embeddedImage: AssetImage('assets/images/Logo_VecRu_Thai.png'),
                embeddedImageStyle: QrEmbeddedImageStyle(
                  size: Size(screenWidth * 0.2, screenWidth * 0.2),
                ),
              ),
              Text('Back',
                  style: TextStyle(
                    fontFamily: AppTheme.ruFontKanit,
                    fontSize: baseFontSize + 10,
                    color: AppTheme.darkText,
                  )),
            ],
          ),
        ),
      ),
    );
  }

  Widget appBar() {
    return SizedBox(
      height: AppBar().preferredSize.height,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 8, left: 8),
            child: Container(
              width: AppBar().preferredSize.height - 8,
              height: AppBar().preferredSize.height - 8,
              child: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: AppTheme.ru_yellow,
                ),
                onPressed: () {
                  // Handle back button pressed
                  Navigator.pop(context);
                },
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(
                  'บัตรนักศึกษาอิเล็กทรอนิกส์',
                  style: TextStyle(
                    fontSize: 22,
                    fontFamily: AppTheme.ruFontKanit,
                    color: AppTheme.ru_yellow,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8, right: 8),
            child: Container(
              width: AppBar().preferredSize.height,
              height: AppBar().preferredSize.height,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(32.0),
                      ),
                      onTap: () {
                        Get.toNamed("/cardhelp");
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.help,
                          color: AppTheme.ru_yellow,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
