// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:auth_buttons/auth_buttons.dart'
    show AuthButtonStyle, GoogleAuthButton;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:th.ac.ru.uSmart/app_theme.dart';
import 'package:th.ac.ru.uSmart/fitness_app/fitness_app_theme.dart';
import 'package:th.ac.ru.uSmart/widget/ru_wallpaper.dart';
import '../providers/authenprovider.dart';
import 'package:provider/provider.dart';

final usertest = dotenv.env['USERTEST'];

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  String inputText = '';
  final String targetValue = "$usertest";

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: _controller,
        curve: Interval((1 / 20) * 5, 1.0, curve: Curves.fastOutSlowIn)));

    //Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
    _controller.forward(); // Start the animation
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isLightMode = brightness == Brightness.light;
    return Container(
      color: FitnessAppTheme.background,
      child: Scaffold(
        backgroundColor:
            isLightMode ? AppTheme.nearlyWhite : AppTheme.nearlyBlack,
        body: Consumer<AuthenProvider>(
          builder: (context, authen, child) {
            if (authen.isLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return FadeTransition(
              opacity: _animation,
              child: Transform(
                transform: Matrix4.translationValues(
                    0.0, 30 * (1.0 - _animation.value), 0.0),
                child: Container(
                  decoration: BoxDecoration(
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                          color: AppTheme.nearlyBlack.withOpacity(0.2),
                          offset: const Offset(0, -2),
                          blurRadius: 8.0),
                    ],
                  ),
                  child: Stack(
                    children: [
                      RuWallpaper(),
                      SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 50, left: 20),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Image.asset('assets/images/rumail.png',
                                          height: 60),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                70 /
                                                100,
                                        height: 5,
                                        padding: const EdgeInsets.all(20.0),
                                        decoration: BoxDecoration(
                                          color: AppTheme.ru_yellow,
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(0.0),
                                            bottomLeft: Radius.circular(0.0),
                                          ),
                                        ),
                                      ),
                                      Text(
                                        'อีเมลนักศึกษา มหาวิทยาลัยรามคำแหง',
                                        style: TextStyle(
                                          color: AppTheme.ru_text_ocean_blue,
                                          fontSize: 18,
                                          fontFamily: AppTheme.ruFontKanit,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 20.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width *
                                        90 /
                                        100,
                                    height: MediaQuery.of(context).size.height *
                                        25 /
                                        100,
                                    padding: const EdgeInsets.all(20.0),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(50.0),
                                        bottomLeft: Radius.circular(50.0),
                                      ),
                                      image: DecorationImage(
                                        image: AssetImage(
                                            'assets/fitness_app/banner2.png'),
                                        fit: BoxFit
                                            .cover, // Adjust this property
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 20.0, left: 20, right: 20),
                              child: TextField(
                                  onChanged: (text) {
                                    setState(() {
                                      inputText = text;
                                    });
                                  },
                                  decoration: InputDecoration(
                                    labelText:
                                        'Enter Student Code 10-digit Number',
                                    labelStyle: TextStyle(
                                      color: AppTheme.ru_text_ocean_blue,
                                      fontSize: 18,
                                      fontFamily: AppTheme.ruFontKanit,
                                    ),
                                  ),
                                  style: TextStyle(
                                    color: AppTheme
                                        .ru_dark_blue, // Change the font color to your preference
                                    fontSize: 18, // Adjust the font size
                                    // Add more text style properties as needed
                                  ),
                                  keyboardType: TextInputType.number,
                                  maxLength: 10,
                                  cursorColor: AppTheme.ru_dark_blue),
                            ),
                            if (inputText.length == 10)
                              if (inputText == targetValue)
                                GoogleAuthButton(
                                  text: "เข้าสู่ระบบ",
                                  style: AuthButtonStyle(
                                    textStyle: TextStyle(
                                        color: AppTheme.ru_dark_blue,
                                        fontSize: 18,
                                        fontFamily: AppTheme.ruFontKanit,
                                        fontWeight: FontWeight.bold),
                                    buttonColor: AppTheme.nearlyWhite,
                                    iconSize: 45.0,
                                    borderRadius:
                                        20, // เพิ่มค่าให้มากเพื่อให้เป็นวงกลม
                                    width:
                                        240, // ขนาดความกว้างและความสูงให้เท่ากันเพื่อให้เป็นวงกลม
                                    height: 60,
                                    padding: EdgeInsets.all(0),
                                  ),
                                  onPressed: () {
                                    authen.getAuthenGoogleDev(context);
                                  },
                                )
                              else
                                GoogleAuthButton(
                                  text: "เข้าสู่ระบบ",
                                  style: AuthButtonStyle(
                                    textStyle: TextStyle(
                                        color: AppTheme.ru_dark_blue,
                                        fontSize: 18,
                                        fontFamily: AppTheme.ruFontKanit,
                                        fontWeight: FontWeight.bold),
                                    buttonColor: AppTheme.nearlyWhite,
                                    iconSize: 45.0,
                                    borderRadius:
                                        20, // เพิ่มค่าให้มากเพื่อให้เป็นวงกลม
                                    width:
                                        240, // ขนาดความกว้างและความสูงให้เท่ากันเพื่อให้เป็นวงกลม
                                    height: 60,
                                    padding: EdgeInsets.all(0),
                                  ),
                                  onPressed: () {
                                    authen.getAuthenGoogle(context);
                                  },
                                ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class HalfCircleContainer extends StatelessWidget {
  final String imagePath;

  HalfCircleContainer({required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: HalfCircleClipper(),
      child: Container(
        width: 200,
        height: 100,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(imagePath),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}

class HalfCircleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path()
      ..moveTo(size.width / 2, 0)
      ..arcToPoint(
        Offset(size.width / 2, size.height),
        radius: Radius.circular(size.width / 2),
        clockwise: true,
      )
      ..lineTo(size.width, size.height)
      ..lineTo(size.width, 0)
      ..close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
