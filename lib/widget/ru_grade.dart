import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:th.ac.ru.uSmart/app_theme.dart';
import 'package:th.ac.ru.uSmart/fitness_app/fitness_app_theme.dart';
import 'package:th.ac.ru.uSmart/main.dart';

class RuGradeView extends StatelessWidget {
  RuGradeView(
      {super.key,
      this.caption,
      this.description,
      this.iconname,
      this.caption2,
      this.description2,
      this.iconname2,
      this.duration = 1000});
  final String? caption;
  final String? description;
  final String? caption2;
  final String? description2;
  final IconData? iconname;
  final IconData? iconname2;
  int duration;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double baseFontSize =
        screenWidth < 600 ? screenWidth * 0.05 : screenWidth * 0.03;
    return Card(
      color: Colors.transparent,
      elevation: 0.0,
      //color: Colors.transparent,
      child: FlipCard(
        direction: FlipDirection.HORIZONTAL,
        speed: 1000,
        onFlipDone: (status) {
          print(status);
        },
        front: Container(
          //color: Colors.red,
          width: screenWidth * 0.5,
          height: screenWidth * 0.3,
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            // image: DecorationImage(
            //   image: AssetImage('assets/images/ID.png'),
            //   fit: BoxFit.cover,
            //   opacity: 0.08,
            // ),
            gradient: LinearGradient(
              colors: <HexColor>[
                HexColor("#FF19196B"),
                HexColor("#FF1919FB"),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: const BorderRadius.only(
              bottomRight: Radius.circular(16.0),
              bottomLeft: Radius.circular(16.0),
              topLeft: Radius.circular(16.0),
              topRight: Radius.circular(16.0),
            ),
            boxShadow: [
              BoxShadow(
                color: AppTheme.ru_dark_blue.withOpacity(0.4),
                spreadRadius: 2,
                blurRadius: 4,
                offset: Offset(4, 4),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TweenAnimationBuilder(
                    tween: Tween<double>(begin: 0.0, end: 1.0),
                    duration: Duration(milliseconds: this.duration - 100),
                    builder: (context, double value, child) {
                      return Opacity(
                        opacity: value,
                        child: Transform.scale(
                          scale: value,
                          child: Text(
                            '$caption',
                            style: TextStyle(
                              color: AppTheme.ru_yellow,
                              fontSize: baseFontSize - 8,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  CircleAvatar(
                    backgroundColor: AppTheme.ru_yellow,
                    radius: 14,
                    child: Icon(
                      iconname,
                      color: AppTheme.nearlyWhite,
                      size: 24,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0, top: 8.0),
                    child: TweenAnimationBuilder(
                      tween: Tween<double>(begin: 0.0, end: 1.0),
                      duration: Duration(milliseconds: this.duration),
                      builder: (context, double value, child) {
                        return Opacity(
                          opacity: value,
                          child: Transform.scale(
                            scale: value,
                            child: Text(
                              '$description',
                              style: TextStyle(
                                color: AppTheme.ru_yellow,
                                fontFamily: AppTheme.ruFontKanit,
                                fontSize: baseFontSize + 4,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        back: Container(
          width: screenWidth * 0.5,
          height: screenWidth * 0.3,
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/ID.png'),
              fit: BoxFit.cover,
              opacity: 0.08,
            ),
            gradient: LinearGradient(
              colors: <HexColor>[
                HexColor("#FF19196B"),
                HexColor("#FF1919FB"),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: const BorderRadius.only(
              bottomRight: Radius.circular(16.0),
              bottomLeft: Radius.circular(16.0),
              topLeft: Radius.circular(16.0),
              topRight: Radius.circular(16.0),
            ),
            boxShadow: [
              BoxShadow(
                color: AppTheme.ru_dark_blue.withOpacity(0.4),
                spreadRadius: 2,
                blurRadius: 4,
                offset: Offset(4, 4),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TweenAnimationBuilder(
                    tween: Tween<double>(begin: 0.0, end: 1.0),
                    duration: Duration(milliseconds: this.duration - 100),
                    builder: (context, double value, child) {
                      return Opacity(
                        opacity: value,
                        child: Transform.scale(
                          scale: value,
                          child: Text(
                            '$caption2',
                            style: TextStyle(
                              color: AppTheme.ru_yellow,
                              fontSize: baseFontSize - 8,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  CircleAvatar(
                    backgroundColor: AppTheme.ru_yellow,
                    radius: 14,
                    child: Icon(
                      iconname2,
                      color: AppTheme.nearlyWhite,
                      size: 24,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0, top: 8.0),
                    child: TweenAnimationBuilder(
                      tween: Tween<double>(begin: 0.0, end: 1.0),
                      duration: Duration(milliseconds: this.duration),
                      builder: (context, double value, child) {
                        return Opacity(
                          opacity: value,
                          child: Transform.scale(
                            scale: value,
                            child: Text(
                              '$description2',
                              style: TextStyle(
                                color: AppTheme.ru_yellow,
                                fontFamily: AppTheme.ruFontKanit,
                                fontSize: baseFontSize + 4,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
