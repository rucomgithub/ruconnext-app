// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:auth_buttons/auth_buttons.dart'
    show AuthButtonStyle, GoogleAuthButton;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:th.ac.ru.uSmart/app_theme.dart';
import 'package:th.ac.ru.uSmart/widget/ru_wallpaper.dart';
import '../providers/authenprovider.dart';
import 'package:provider/provider.dart';

final usertest = dotenv.env['USERTEST'];

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // final _googleSingIn = GoogleSignIn();
  // // ignore: non_constant_identifier_names
  // Future<Profile> GetGoogleToken() async {
  //   GoogleSignInAccount? user = await _googleSingIn.signIn();
  //   print('user: ${user}');
  //   GoogleSignInAuthentication googleSignInAuthentication =
  //       await user!.authentication;
  //   return Profile();
  // }

  // Future<void> login(Map<dynamic, dynamic>? formValue) async {
  //   Profile profile = await GetGoogleToken();
  //   // ignore: avoid_print
  //   print('profile: ${profile.toJson()}');

  //   SharedPreferences prefs = await SharedPreferences.getInstance();

  //   await prefs.setString('profile', jsonEncode(profile.toJson()));

  //   print(profile);

  //   //get token from server
  //   try {
  //     var params = {"std_code": '${profile.studentCode}'};

  //     var response = await Dio().post(
  //       'https://backend-services.ru.ac.th/ru-smart-api/google/authorization',
  //       options: Options(
  //         headers: {
  //           HttpHeaders.contentTypeHeader: "application/json",
  //           "authorization": "Bearer ${profile.googleToken}",
  //         },
  //       ),
  //       data: jsonEncode(params),
  //     );

  //     Rutoken token = Rutoken.fromJson(response.data);
  //     // ignore: avoid_print
  //     print('RUToken : ${token.accessToken}');

  //     await prefs.setString('token', jsonEncode(token));

  //     Get.offNamedUntil('/home', (route) => false);
  //   } on DioError catch (err) {
  //     final errorMessage = DioException.fromDioError(err).toString();
  //     var snackbar = SnackBar(content: Text('${errorMessage}'));
  //     ScaffoldMessenger.of(context).showSnackBar(snackbar);
  //     await _googleSingIn.disconnect();
  //   } catch (e) {
  //     var snackbar = SnackBar(content: Text('${e.toString()}'));
  //     ScaffoldMessenger.of(context).showSnackBar(snackbar);
  //     await _googleSingIn.disconnect();
  //   }
  // }

  String inputText = '';
  final String targetValue = "$usertest";

  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isLightMode = brightness == Brightness.light;
    return Scaffold(
      backgroundColor:
          isLightMode ? AppTheme.nearlyWhite : AppTheme.nearlyBlack,
      body: Consumer<AuthenProvider>(
        builder: (context, authen, child) {
          if (authen.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Container(
            decoration: BoxDecoration(
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: AppTheme.ru_text_light_blue.withOpacity(0.2),
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.asset('assets/images/rumail.png',
                                    height: 60),
                                Container(
                                  width: MediaQuery.of(context).size.width *
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
                              width:
                                  MediaQuery.of(context).size.width * 90 / 100,
                              height:
                                  MediaQuery.of(context).size.height * 25 / 100,
                              padding: const EdgeInsets.all(20.0),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(50.0),
                                  bottomLeft: Radius.circular(50.0),
                                ),
                                image: DecorationImage(
                                  image: AssetImage('assets/hotel/SBB.png'),
                                  fit: BoxFit.cover, // Adjust this property
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
                              labelText: 'Enter Student Code 10-digit Number',
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
                            cursorColor: AppTheme.ru_yellow),
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
          );
        },
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
