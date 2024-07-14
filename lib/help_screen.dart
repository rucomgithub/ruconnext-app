import 'package:get/get.dart';
import 'package:th.ac.ru.uSmart/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:th.ac.ru.uSmart/widget/ru_wallpaper.dart';
import 'package:th.ac.ru.uSmart/widget/top_menu_bar.dart';

class HelpScreen extends StatefulWidget {
  @override
  _HelpScreenState createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isLightMode = brightness == Brightness.light;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'ช่วยเหลือ ?',
          style: TextStyle(
            fontSize: 22,
            fontFamily: AppTheme.ruFontKanit,
            color: AppTheme.nearlyWhite,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true, // Centers the title
        backgroundColor:
            AppTheme.ru_dark_blue, // Background color of the AppBar
        // actions: <Widget>[
        //   IconButton(
        //     icon: Icon(
        //       Icons.help,
        //       color: AppTheme.nearlyWhite,
        //     ),
        //     onPressed: () {
        //       Get.toNamed("/manual");
        //     },
        //   ),
        // ],
      ),
      backgroundColor:
          isLightMode ? AppTheme.nearlyWhite : AppTheme.nearlyBlack,
      body: Container(
        decoration: BoxDecoration(
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                offset: const Offset(0, -2),
                blurRadius: 8.0),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Stack(
                children: [
                  RuWallpaper(),
                  Column(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(
                            top: MediaQuery.of(context).padding.top,
                            left: 16,
                            right: 16),
                        child: Image.asset('assets/images/helpImage.png'),
                      ),
                      Container(
                        padding: const EdgeInsets.only(top: 8),
                        child: Text(
                          'ช่วยเหลือ?',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: isLightMode ? Colors.black : Colors.white),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(top: 16),
                        child: Text(
                          'มหาวิทยาลัยรามคำแหง\n282 ถนนรามคำแหง แขวงหัวหมาก เขตบางกะปิ กรุงเทพมหานคร 10240.\nหมายเลขโทรศัพท์ : 0-2310-8000, หมายเลขโทรสาร 0-2310-8022 \nWebsite : www.ru.ac.th',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 16,
                              color: isLightMode ? Colors.black : Colors.white),
                        ),
                      ),
                      // Expanded(
                      //   child: Padding(
                      //     padding: const EdgeInsets.all(8.0),
                      //     child: Center(
                      //       child: Container(
                      //         width: 140,
                      //         height: 40,
                      //         decoration: BoxDecoration(
                      //           color: isLightMode ? Colors.blue : Colors.white,
                      //           borderRadius: const BorderRadius.all(Radius.circular(4.0)),
                      //           boxShadow: <BoxShadow>[
                      //             BoxShadow(
                      //                 color: Colors.grey.withOpacity(0.6),
                      //                 offset: const Offset(4, 4),
                      //                 blurRadius: 8.0),
                      //           ],
                      //         ),
                      //         child: Material(
                      //           color: Colors.transparent,
                      //           child: InkWell(
                      //             onTap: () {},
                      //             child: Center(
                      //               child: Padding(
                      //                 padding: const EdgeInsets.all(4.0),
                      //                 child: Text(
                      //                   'คู่มือการใช้งาน',
                      //                   style: TextStyle(
                      //                     fontWeight: FontWeight.w500,
                      //                     color: isLightMode ? Colors.white : Colors.black,
                      //                   ),
                      //                 ),
                      //               ),
                      //             ),
                      //           ),
                      //         ),
                      //       ),
                      //     ),
                      //   ),
                      // )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
