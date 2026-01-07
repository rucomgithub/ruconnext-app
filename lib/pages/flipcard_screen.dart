import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:th.ac.ru.uSmart/app_theme.dart';
import 'package:th.ac.ru.uSmart/pages/ImageLoader.dart';
import 'package:th.ac.ru.uSmart/providers/student_provider.dart';
import 'package:th.ac.ru.uSmart/utils/faculty_color.dart';
import 'package:th.ac.ru.uSmart/widget/ru_wallpaper.dart';
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

    // Set context first before calling any methods
    Provider.of<StudentProvider>(context, listen: false).context = context;

    // Call after frame is built to avoid "setState during build" error
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<AuthenProvider>(context, listen: false).getProfile();
      Provider.of<StudentProvider>(context, listen: false).refreshData();
    });
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 500));

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
            : AppTheme.nearlyBlack.withValues(alpha: 0.2),
        body: FutureBuilder<bool>(
            future: getData(),
            builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
              if (!snapshot.hasData) {
                return const SizedBox();
              } else {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Stack(
                        fit: StackFit.expand,
                        children: <Widget>[
                          RuWallpaper(),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
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
                );
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

    // Check if there's an error
    if (studentProv.error.isNotEmpty) {
      return Center(
        child: Container(
          margin: const EdgeInsets.all(16.0),
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
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
                studentProv.error,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                  fontFamily: AppTheme.ruFontKanit,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Provider.of<StudentProvider>(context, listen: false)
                      .refreshData();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.ru_dark_blue,
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                ),
                child: Text(
                  'ลองอีกครั้ง',
                  style: TextStyle(
                    fontFamily: AppTheme.ruFontKanit,
                    fontSize: 14,
                    color: AppTheme.nearlyWhite,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    // Check if data is loaded
    if (studentProv.isLoading ||
        studentProv.student.regionalnamethai == null ||
        studentProv.student.regionalnamethai == '' ||
        studentProv.student.facultynamethai == null ||
        studentProv.student.facultynamethai == '' ||
        studentProv.student.namethai == null ||
        studentProv.student.namethai == '' ||
        studentProv.student.nameeng == null ||
        studentProv.student.nameeng == '' ||
        studentProv.student.majornamethai == null ||
        studentProv.student.majornamethai == '' ||
        studentProv.student.stdcode == null ||
        studentProv.student.stdcode == '' ||
        authen.profile.studentCode == null ||
        authen.profile.studentCode == '' ||
        authen.profile.email == null ||
        authen.profile.email == '') {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(AppTheme.ru_dark_blue),
            ),
            SizedBox(height: 16),
            Text(
              'กำลังโหลดข้อมูล...',
              style: TextStyle(
                fontFamily: AppTheme.ruFontKanit,
                fontSize: baseFontSize,
                color:
                    isLightMode ? AppTheme.ru_dark_blue : AppTheme.nearlyWhite,
              ),
            ),
          ],
        ),
      );
    }

    var region = studentProv.student.regionalnamethai!;
    region = region.replaceAll("จังหวัด", "");

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
        child: AspectRatio(
          aspectRatio: 0.63,
          child: FlipCard(
            direction: FlipDirection.HORIZONTAL,
            speed: 1000,
            onFlipDone: (status) {
              print(status);
            },
            front: ClipRRect(
              borderRadius: BorderRadius.circular(16.0),
              child: Container(
                decoration: BoxDecoration(
                  color: AppTheme.white,
                  image: DecorationImage(
                    image: const AssetImage('assets/images/ID.png'),
                    fit: BoxFit.cover,
                    opacity: isLightMode ? 0.85 : 0.45,
                  ),
                  boxShadow: const <BoxShadow>[
                    BoxShadow(
                      color: AppTheme.ru_yellow,
                      offset: Offset(2.0, 2.0),
                      blurRadius: 12.0,
                      spreadRadius: 1.0,
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      // Header Section
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 50,
                                height: 60,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: Image.asset(
                                    'assets/images/Logo_VecRu_Thai.png',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Flexible(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'มหาวิทยาลัยรามคำแหง',
                                      style: AppTheme.body1.copyWith(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Text(
                                      'Ramkhamhaeng University',
                                      style:
                                          AppTheme.body2.copyWith(fontSize: 10),
                                      overflow: TextOverflow.ellipsis,
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
                                  getFacultyColor(
                                      studentProv.student.facultynamethai!),
                                  getFacultyColor(
                                          studentProv.student.facultynamethai!)
                                      .withOpacity(0.3),
                                ],
                              ),
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                        ],
                      ),
                      // Middle Section - Image and Info
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 140,
                            height: 160,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: getFacultyColor(
                                          studentProv.student.facultynamethai!)
                                      .withOpacity(0.3),
                                  blurRadius: 12,
                                  offset: const Offset(0, 4),
                                  spreadRadius: 2,
                                ),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: ImageLoader(),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 12),
                            decoration: BoxDecoration(
                              color: AppTheme.ru_dark_blue.withOpacity(0.95),
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: AppTheme.ru_yellow.withOpacity(0.2),
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
                                    fontFamily: AppTheme.ruFontKanit,
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
                                    fontFamily: AppTheme.ruFontKanit,
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
                              color: AppTheme.ru_yellow.withOpacity(0.95),
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: AppTheme.ru_dark_blue.withOpacity(0.2),
                                  blurRadius: 8,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                Text(
                                  studentProv.student.majornamethai!,
                                  style: const TextStyle(
                                    color: AppTheme.ru_dark_blue,
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: AppTheme.ruFontKanit,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
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
                                        region,
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: AppTheme.ru_dark_blue
                                              .withOpacity(0.8),
                                          fontWeight: FontWeight.w500,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      // Bottom Section - QR Code
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
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
                                      color: AppTheme.ru_dark_blue,
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
                      spreadRadius: 1.0,
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        children: [
                          SizedBox(
                            width: 60,
                            height: 70,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12.0),
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
                              borderRadius: BorderRadius.circular(1),
                            ),
                          ),
                        ],
                      ),
                      Expanded(
                        child: Center(
                          child: Container(
                            constraints: const BoxConstraints(maxWidth: 220),
                            padding: const EdgeInsets.all(20.0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20.0),
                              boxShadow: [
                                BoxShadow(
                                  color: AppTheme.ru_yellow.withOpacity(0.4),
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
                              embeddedImageStyle: const QrEmbeddedImageStyle(
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
