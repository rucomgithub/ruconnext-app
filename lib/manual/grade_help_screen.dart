import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:th.ac.ru.uSmart/fitness_app/fitness_app_theme.dart';
import 'package:th.ac.ru.uSmart/ruconnext_app_theme.dart';

class CardHelpScreen extends StatefulWidget {
  const CardHelpScreen({super.key});

  @override
  State<CardHelpScreen> createState() => _CardHelpScreenState();
}

class _CardHelpScreenState extends State<CardHelpScreen> {
  int _currentIndex = 0;
  final List<String> imageUrls = [
    'https://sevkn.ru.ac.th/rusmart/manual/6.png',
    'https://sevkn.ru.ac.th/rusmart/manual/7.png',
    'https://sevkn.ru.ac.th/rusmart/manual/8.png',
    'https://sevkn.ru.ac.th/rusmart/manual/9.png',
    'https://sevkn.ru.ac.th/rusmart/manual/10.png',
    'https://sevkn.ru.ac.th/rusmart/manual/11.png',
    // Add more image URLs here
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: FitnessAppTheme.background,
      child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Column(
            children: [
              getAppBarUI(context),
              CarouselSlider(
                options: CarouselOptions(
                  height: MediaQuery.of(context).size.height -
                      190, // Full screen height
                  autoPlay: true,
                  enlargeCenterPage: true,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                ),
                items: imageUrls.map((url) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        width: MediaQuery.of(context)
                            .size
                            .width, // Full screen width
                        child: Image.network(
                          url,
                          //fit: BoxFit.cover, // Fit the image to the screen
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
            ],
          ),
          bottomNavigationBar: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: imageUrls.map((url) {
              int index = imageUrls.indexOf(url);
              return Container(
                width: 8.0,
                height: 8.0,
                margin: EdgeInsets.symmetric(vertical: 30.0, horizontal: 1.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _currentIndex == index
                      ? Color.fromARGB(255, 100, 102, 104)
                      : Colors.grey,
                ),
              );
            }).toList(),
          )),
    );
  }
}

Widget getAppBarUI(BuildContext context) {
  return Container(
    decoration: BoxDecoration(
      color: RuConnextAppTheme.buildLightTheme().backgroundColor,
      boxShadow: <BoxShadow>[
        BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            offset: const Offset(0, 2),
            blurRadius: 8.0),
      ],
    ),
    child: Padding(
      padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top, left: 8, right: 8),
      child: Row(
        children: <Widget>[
          Container(
            alignment: Alignment.centerLeft,
            width: AppBar().preferredSize.height + 40,
            height: AppBar().preferredSize.height,
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: const BorderRadius.all(
                  Radius.circular(32.0),
                ),
                onTap: () {
                  Navigator.pop(context);
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(Icons.arrow_back),
                ),
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: Text(
                'หน้าบัตรนักศึกษา',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          Container(
            width: AppBar().preferredSize.height + 20,
            height: AppBar().preferredSize.height,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                // Material(
                //   color: Colors.transparent,
                //   child: InkWell(
                //     borderRadius: const BorderRadius.all(
                //       Radius.circular(32.0),
                //     ),
                //     onTap: () {},
                //     child: Padding(
                //       padding: const EdgeInsets.all(8.0),
                //       child: Icon(Icons.favorite_border),
                //     ),
                //   ),
                // ),
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(32.0),
                    ),
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(FontAwesomeIcons.bookOpenReader),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    ),
  );
}
