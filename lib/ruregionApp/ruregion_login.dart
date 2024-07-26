// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:auth_buttons/auth_buttons.dart' show GoogleAuthButton;
import 'package:get/get.dart';
import 'package:th.ac.ru.uSmart/app_theme.dart';
import 'package:th.ac.ru.uSmart/providers/authen_regis.dart';
import 'package:th.ac.ru.uSmart/providers/ruregis_provider.dart';
import '../providers/authenprovider.dart';
import 'package:provider/provider.dart';

class RuregionAppLoginPage extends StatefulWidget {
  const RuregionAppLoginPage({super.key});

  @override
  State<RuregionAppLoginPage> createState() => _RuregionAppLoginPageState();
}

class _RuregionAppLoginPageState extends State<RuregionAppLoginPage> {
  String inputStudentCode = '';
  String inputPassword = '';
  final String targetValue = "6299999991";

  @override
  Widget build(BuildContext context) {
   var msgButtonLogin = context.watch<AuthenRuRegionAppProvider>().msgSaveButtonLogin;
   var isload = context.watch<AuthenRuRegionAppProvider>().isLoadingLogin;
    return Scaffold(
      body: Consumer<AuthenProvider>(
        builder: (context, authen, child) {
          if (authen.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [
                Color.fromARGB(255, 248, 248, 248),
                Color.fromARGB(255, 43, 72, 255)
              ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
            ),
            child: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Image.asset('assets/images/logo.png', height: 80),
                      const SizedBox(height: 200),
                      TextField(
                        onChanged: (text) {
                          setState(() {
                            inputStudentCode = text;
                          });
                        },
                        decoration: InputDecoration(
                          labelText: 'รหัสนักศึกษา',
                          labelStyle: TextStyle(
                            fontSize: 16,
                            fontFamily: AppTheme.ruFontKanit,
                          ),
                        ),
                        style: TextStyle(
                          color: Colors
                              .white, // Change the font color to your preference
                          fontSize: 18, // Adjust the font size
                          // Add more text style properties as needed
                        ),
                        keyboardType: TextInputType.number,
                        maxLength: 10,
                      ),
                      TextField(
                        onChanged: (text) {
                          setState(() {
                            inputPassword = text;
                          });
                        },
                        decoration: InputDecoration(
                          labelText: 'รหัสผ่านเดียวกับ e-service',
                          labelStyle: TextStyle(
                            fontSize: 16,
                            fontFamily: AppTheme.ruFontKanit,
                          ),
                        ),
                        style: TextStyle(
                          color: Colors
                              .white, // Change the font color to your preference
                          fontSize: 18, // Adjust the font size
                          // Add more text style properties as needed
                        ),
                        keyboardType: TextInputType.text,
                      ),
                      if (inputStudentCode.length == 10 &&
                          inputStudentCode.length > 0)
                        ElevatedButton(
                          onPressed: isload ? null: () {
                            doLogin(inputStudentCode, inputPassword);
                            // Get.toNamed('/ruregionhome'); // ทำอะไรก็ตามเมื่อปุ่มถูกกด
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                      Color.fromARGB(255, 164, 193,
                                    163)), // เปลี่ยนสีปุ่ม
                          ),
                          child: Text('$msgButtonLogin'),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void doLogin(usr, pwd) {
    Provider.of<AuthenRuRegionAppProvider>(context, listen: false)
        .getAuthenRuRegionApp(context, usr, pwd);

  }
}
