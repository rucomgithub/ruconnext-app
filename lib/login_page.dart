// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:auth_buttons/auth_buttons.dart'
    show AuthButtonStyle, GoogleAuthButton;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:th.ac.ru.uSmart/app_theme.dart';
import 'package:th.ac.ru.uSmart/widget/ru_wallpaper.dart';
import '../providers/authenprovider.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

final String? usertest = dotenv.env['USERTEST'];

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  String inputText = '';
  final List<String> targetValue = usertest?.split(',') ?? [];

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 800),
    );
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: _controller,
        curve: Interval(0.0, 1.0, curve: Curves.easeOutCubic)));
    _controller.forward();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.dark,
        ),
        iconTheme: IconThemeData(
          color: AppTheme.nearlyWhite,
        ),
        title: Text(
          'เข้าสู่ระบบ',
          style: AppTheme.headline,
        ),
        centerTitle: true,
        backgroundColor: AppTheme.ru_dark_blue,
      ),
      backgroundColor: AppTheme.nearlyWhite,
      body: Consumer<AuthenProvider>(
        builder: (context, authen, child) {
          if (authen.isLoading) {
            return Center(
              child: CircularProgressIndicator(
                color: AppTheme.ru_yellow,
              ),
            );
          }
          return FadeTransition(
            opacity: _animation,
            child: Stack(
              children: [
                // Wallpaper Background
                Positioned.fill(
                  child: RuWallpaper(),
                ),
                SingleChildScrollView(
                  child: Column(
                    children: [
                      // Header Section with Logo
                      SafeArea(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 12, left: 12, right: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Logo Row
                              Padding(
                                padding: const EdgeInsets.only(left: 8),
                                child: Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(12),
                                      decoration: BoxDecoration(
                                        color: AppTheme.nearlyWhite,
                                        borderRadius: BorderRadius.circular(16),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black
                                                .withValues(alpha: 0.1),
                                            blurRadius: 10,
                                            offset: Offset(0, 4),
                                          ),
                                        ],
                                      ),
                                      child: Image.asset(
                                        'assets/images/rumail.png',
                                        height: 40,
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'RU Connext',
                                          style: TextStyle(
                                            fontFamily: AppTheme.ruFontKanit,
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold,
                                            color: AppTheme.ru_dark_blue,
                                          ),
                                        ),
                                        Container(
                                          height: 3,
                                          width: 80,
                                          decoration: BoxDecoration(
                                            color: AppTheme.ru_yellow,
                                            borderRadius:
                                                BorderRadius.circular(2),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 8),
                              Padding(
                                padding: const EdgeInsets.only(left: 8),
                                child: Text(
                                  'อีเมลนักศึกษา มหาวิทยาลัยรามคำแหง',
                                  style: TextStyle(
                                    fontFamily: AppTheme.ruFontKanit,
                                    fontSize: 13,
                                    color: AppTheme.ru_text_ocean_blue,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      // Banner Section
                      Padding(
                        padding: const EdgeInsets.only(top: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              width: screenWidth * 0.85,
                              height: screenHeight * 0.18,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(32),
                                  bottomLeft: Radius.circular(32),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withValues(alpha: 0.1),
                                    blurRadius: 15,
                                    offset: Offset(0, 5),
                                  ),
                                ],
                                image: DecorationImage(
                                  image: AssetImage(
                                      'assets/fitness_app/banner2.png'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Main Content Card
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppTheme.nearlyWhite,
                            borderRadius: BorderRadius.circular(24),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.08),
                                blurRadius: 20,
                                offset: Offset(0, 8),
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(24.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 16),
                                // Welcome Text
                                Center(
                                  child: Column(
                                    children: [
                                      Text(
                                        'ยินดีต้อนรับ',
                                        style: TextStyle(
                                          fontFamily: AppTheme.ruFontKanit,
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                          color: AppTheme.ru_dark_blue,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        'เข้าสู่ระบบด้วยอีเมลนักศึกษา',
                                        style: TextStyle(
                                          fontFamily: AppTheme.ruFontKanit,
                                          fontSize: 14,
                                          color: AppTheme.ru_text_ocean_blue,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 32),

                                // Student ID Input
                                Text(
                                  'รหัสนักศึกษา',
                                  style: TextStyle(
                                    fontFamily: AppTheme.ruFontKanit,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: AppTheme.ru_dark_blue,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade100,
                                    borderRadius: BorderRadius.circular(16),
                                    border: Border.all(
                                      color: inputText.length == 10
                                          ? AppTheme.ru_dark_blue
                                          : Colors.transparent,
                                      width: 2,
                                    ),
                                  ),
                                  child: TextField(
                                    onChanged: (text) {
                                      setState(() {
                                        inputText = text;
                                      });
                                    },
                                    decoration: InputDecoration(
                                      hintText: 'กรอกรหัสนักศึกษา 10 หลัก',
                                      hintStyle: TextStyle(
                                        fontFamily: AppTheme.ruFontKanit,
                                        fontSize: 14,
                                        color: Colors.grey.shade500,
                                      ),
                                      prefixIcon: Icon(
                                        Icons.person_outline_rounded,
                                        color: AppTheme.ru_dark_blue,
                                      ),
                                      border: InputBorder.none,
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                        horizontal: 16,
                                        vertical: 16,
                                      ),
                                      counterText: '',
                                    ),
                                    style: TextStyle(
                                      fontFamily: AppTheme.ruFontKanit,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: AppTheme.ru_dark_blue,
                                      letterSpacing: 2,
                                    ),
                                    keyboardType: TextInputType.number,
                                    maxLength: 10,
                                    cursorColor: AppTheme.ru_dark_blue,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                // Character counter
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    '${inputText.length}/10',
                                    style: TextStyle(
                                      fontFamily: AppTheme.ruFontKanit,
                                      fontSize: 12,
                                      color: inputText.length == 10
                                          ? AppTheme.ru_dark_blue
                                          : Colors.grey.shade500,
                                      fontWeight: inputText.length == 10
                                          ? FontWeight.bold
                                          : FontWeight.normal,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 32),

                                // Login Button
                                if (inputText.length == 10)
                                  AnimatedOpacity(
                                    opacity: inputText.length == 10 ? 1.0 : 0.0,
                                    duration: Duration(milliseconds: 300),
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          width: double.infinity,
                                          height: 56,
                                          child: ElevatedButton.icon(
                                            onPressed: () {
                                              showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return AlertDialog(
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              16),
                                                    ),
                                                    title: Text(
                                                      'แจ้งเตือน',
                                                      style: TextStyle(
                                                        fontFamily: AppTheme
                                                            .ruFontKanit,
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: AppTheme
                                                            .ru_dark_blue,
                                                      ),
                                                    ),
                                                    content: Text(
                                                      'นักศึกษาต้องเข้าสู่ระบบด้วย @rumail.ru.ac.th เท่านั้น',
                                                      style: TextStyle(
                                                        fontFamily: AppTheme
                                                            .ruFontKanit,
                                                        fontSize: 14,
                                                        color: AppTheme
                                                            .ru_text_ocean_blue,
                                                      ),
                                                    ),
                                                    actions: [
                                                      TextButton(
                                                        onPressed: () {
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                        child: Text(
                                                          'ยกเลิก',
                                                          style: TextStyle(
                                                            fontFamily: AppTheme
                                                                .ruFontKanit,
                                                            fontSize: 14,
                                                            color: Colors.grey,
                                                          ),
                                                        ),
                                                      ),
                                                      ElevatedButton(
                                                        onPressed: () {
                                                          Navigator.of(context)
                                                              .pop();
                                                          if (targetValue
                                                              .contains(
                                                                  inputText)) {
                                                            authen
                                                                .getAuthenGoogleDev(
                                                                    context,
                                                                    inputText);
                                                          } else {
                                                            authen
                                                                .getAuthenGoogle(
                                                                    context);
                                                          }
                                                        },
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                          backgroundColor:
                                                              AppTheme
                                                                  .ru_dark_blue,
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8),
                                                          ),
                                                        ),
                                                        child: Text(
                                                          'ตกลง',
                                                          style: TextStyle(
                                                            fontFamily: AppTheme
                                                                .ruFontKanit,
                                                            fontSize: 14,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  );
                                                },
                                              );
                                            },
                                            icon: Image.asset(
                                              'assets/images/google_logo.png',
                                              height: 24,
                                              errorBuilder:
                                                  (context, error, stackTrace) {
                                                return Icon(
                                                  Icons.g_mobiledata_rounded,
                                                  size: 28,
                                                  color: AppTheme.ru_dark_blue,
                                                );
                                              },
                                            ),
                                            label: Text(
                                              'เข้าสู่ระบบด้วย @rumail.ru.ac.th',
                                              style: TextStyle(
                                                fontFamily:
                                                    AppTheme.ruFontKanit,
                                                fontSize: 15,
                                                fontWeight: FontWeight.w600,
                                                color: AppTheme.ru_dark_blue,
                                              ),
                                            ),
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  AppTheme.nearlyWhite,
                                              elevation: 2,
                                              shadowColor: Colors.black
                                                  .withValues(alpha: 0.1),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(16),
                                                side: BorderSide(
                                                  color: Colors.grey.shade300,
                                                  width: 1,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                if (inputText.length < 10)
                                  Container(
                                    width: double.infinity,
                                    height: 56,
                                    decoration: BoxDecoration(
                                      color: Colors.grey.shade200,
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: Center(
                                      child: Text(
                                        'กรุณากรอกรหัสนักศึกษาให้ครบ 10 หลัก',
                                        style: TextStyle(
                                          fontFamily: AppTheme.ruFontKanit,
                                          fontSize: 14,
                                          color: Colors.grey.shade500,
                                        ),
                                      ),
                                    ),
                                  ),

                                const SizedBox(height: 32),

                                // Divider with text
                                Row(
                                  children: [
                                    Expanded(
                                      child: Divider(
                                        color: Colors.grey.shade300,
                                        thickness: 1,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16),
                                      child: Text(
                                        'ลงทะเบียนอีเมล',
                                        style: TextStyle(
                                          fontFamily: AppTheme.ruFontKanit,
                                          fontSize: 12,
                                          color: Colors.grey.shade500,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Divider(
                                        color: Colors.grey.shade300,
                                        thickness: 1,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 24),

                                // Info Cards
                                Row(
                                  children: [
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: _buildInfoCard(
                                        icon: Icons.email_outlined,
                                        title: 'RU Mail',
                                        subtitle: '@rumail.ru.ac.th',
                                        onTap: () => _launchURL(
                                            'https://mailcenter.ru.ac.th/'),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 32),

                                // Footer
                                Center(
                                  child: Column(
                                    children: [
                                      Text(
                                        'สถาบันคอมพิวเตอร์',
                                        style: TextStyle(
                                          fontFamily: AppTheme.ruFontKanit,
                                          fontSize: 12,
                                          color: Colors.grey.shade500,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        'มหาวิทยาลัยรามคำแหง',
                                        style: TextStyle(
                                          fontFamily: AppTheme.ruFontKanit,
                                          fontSize: 12,
                                          color: Colors.grey.shade400,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
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

  Widget _buildInfoCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppTheme.ru_dark_blue.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: AppTheme.ru_dark_blue.withValues(alpha: 0.1),
            width: 1,
          ),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              size: 28,
              color: AppTheme.ru_dark_blue,
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(
                fontFamily: AppTheme.ruFontKanit,
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppTheme.ru_dark_blue,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              subtitle,
              style: TextStyle(
                fontFamily: AppTheme.ruFontKanit,
                fontSize: 11,
                color: AppTheme.ru_text_ocean_blue,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'ไม่สามารถเปิด $url ได้',
              style: TextStyle(
                fontFamily: AppTheme.ruFontKanit,
                fontSize: 14,
              ),
            ),
          ),
        );
      }
    }
  }
}
