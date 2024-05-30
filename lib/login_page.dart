// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:auth_buttons/auth_buttons.dart' show GoogleAuthButton;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:th.ac.ru.uSmart/app_theme.dart';
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
              gradient: LinearGradient(
                  colors: [Color.fromARGB(255, 248, 248, 248), Color.fromARGB(255, 43, 72, 255)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter),
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
                                    inputText = text;
                                  });
                                },
                                decoration: InputDecoration(
                                  labelText:
                                      'Enter Student Code 10-digit Number',
                                       labelStyle: TextStyle(
                                    fontSize: 16,
                                    fontFamily: AppTheme.ruFontKanit,
                                  ),
                                ),
                                style: TextStyle(
                                  color: Colors.white, // Change the font color to your preference
                                  fontSize: 18, // Adjust the font size
                                  // Add more text style properties as needed
                                ),  
                                keyboardType: TextInputType.number,
                                maxLength: 10,
                              ),
                              if (inputText.length == 10)
                                if (inputText == targetValue)
                                  GoogleAuthButton(
                                    onPressed: () {
                                      authen.getAuthenGoogleDev(context);
                                    },
                                  )
                                else
                                  GoogleAuthButton(
                                    onPressed: () {
                                      authen.getAuthenGoogle(context);
                                    },
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
}
