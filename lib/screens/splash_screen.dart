import 'package:flutter/material.dart';
import 'package:th.ac.ru.uSmart/app_theme.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: AppTheme.myColor.shade500,
          image: DecorationImage(
            alignment: Alignment.center,
            image: AssetImage("assets/home/insurance.png"),
            fit: BoxFit.cover,
            opacity: 0.5,
          )),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 24.0),
                child: Text(
                  "RU ConNext",
                  style: AppTheme.display1,
                ),
              ),
            ],
          ),
          Column(
            children: [
              Container(
                margin: EdgeInsets.all(8),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: RichText(
                    text: TextSpan(style: AppTheme.display1, children: [
                      TextSpan(text: "สำหรับนักศึกษา", style: AppTheme.title),
                      TextSpan(text: " "),
                      TextSpan(
                          text: "ลงทะเบียน, มร.30 และผลการเรียน",
                          style: AppTheme.display1)
                    ]),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
