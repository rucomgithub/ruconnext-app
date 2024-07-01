import 'dart:async';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:th.ac.ru.uSmart/providers/home_provider.dart';

import '../app_theme.dart';

class homeImageSlider extends StatefulWidget {
  const homeImageSlider({Key? key}) : super(key: key);

  @override
  _homeImageSliderState createState() => _homeImageSliderState();
}

class profileImage {
  String? title;
  String? imageHome;
  String? description;
  profileImage({this.title, this.imageHome, this.description});
}

class _homeImageSliderState extends State<homeImageSlider> {
  String title = "";
  IconData icon = Icons.brightness_5;
  ColorFilter colorFilter = ColorFilter.mode(Colors.yellow, BlendMode.modulate);

  int currentIndex = 0;
  String imgClock = '';
  List<profileImage> _products = [
    profileImage(
        title: 'สวัสดีตอนเช้า',
        imageHome: 'assets/fitness_app/banner1.png',
        description: 'แดดเช้า'),
    profileImage(
        title: 'สวัสดีตอนบ่าย',
        imageHome: 'assets/fitness_app/banner2.png',
        description: 'แดดบ่าย'),
    profileImage(
        title: 'สวัสดีตอนเย็น',
        imageHome: 'assets/fitness_app/banner3.png',
        description: 'แดดเย็น')
  ];

  @override
  void initState() {
    super.initState();
    // Provider.of<HomeProvider>(context, listen: false).getTimeHomePage();
  }

  @override
  Widget build(BuildContext context) {
    title = context.watch<HomeProvider>().title;
    icon = context.watch<HomeProvider>().icon;
    colorFilter = context.watch<HomeProvider>().colorFilter;
    return Container(
      color: AppTheme.ru_dark_blue.withOpacity(0.9),
      child: CarouselSlider(
        options: CarouselOptions(
          height: 130,
          aspectRatio: 16 / 9,
          viewportFraction: 1.2,
          initialPage: 0,
          enableInfiniteScroll: true,
          reverse: false,
          autoPlay: true,
          autoPlayInterval: Duration(seconds: 10),
          autoPlayAnimationDuration: Duration(milliseconds: 10),
          autoPlayCurve: Curves.fastOutSlowIn,
          enlargeCenterPage: true,
          enlargeFactor: 0.3,
          scrollDirection: Axis.horizontal,
        ),
        items: _products.map((data) {
          return Builder(
            builder: (BuildContext context) {
              return Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.symmetric(horizontal: 5.0),
                decoration: BoxDecoration(color: Colors.transparent),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                          height: 220,
                          margin: const EdgeInsets.only(top: 0),
                          clipBehavior: Clip.hardEdge,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(20.0),
                              bottomRight: Radius.circular(20.0),
                            ),
                          ),
                          child: Stack(
                            children: [
                              AspectRatio(
                                  aspectRatio: 3,
                                  child: ColorFiltered(
                                    colorFilter: colorFilter,
                                    child: Image.asset(
                                      data.imageHome!,
                                      fit: BoxFit.cover,
                                    ),
                                  )),
                              Positioned(
                                left: 5.0,
                                child: Container(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 10.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: <Widget>[
                                        Container(
                                          decoration: BoxDecoration(
                                            color: AppTheme.nearlyWhite,
                                            shape: BoxShape.circle,
                                            boxShadow: <BoxShadow>[
                                              BoxShadow(
                                                  color: AppTheme.nearlyBlack
                                                      .withOpacity(0.4),
                                                  offset: Offset(2.0, 2.0),
                                                  blurRadius: 4.0),
                                            ],
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(2.0),
                                            child: Icon(
                                              icon,
                                              color: AppTheme.ru_yellow,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          child: Padding(
                                            padding: const EdgeInsets.all(6.0),
                                            child: Text(
                                              title,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontFamily:
                                                    AppTheme.ruFontKanit,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 12,
                                                letterSpacing: 0.2,
                                                color: AppTheme.nearlyWhite,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                    // child: Text(
                                    //    title,
                                    //   textAlign: TextAlign.center,
                                    //   style: TextStyle(
                                    //     fontFamily: AppTheme.ruFontKanit,
                                    //     color: Colors.white,
                                    //     fontSize: 16.0,
                                    //     fontWeight: FontWeight.w100,
                                    //   ),
                                    // ),
                                    ),
                              ),
                            ],
                          )),
                    ],
                  ),
                ),
              );
            },
          );
        }).toList(),
      ),
    );
    // return CarouselSlider(
    //   options: CarouselOptions(
    //     height: 120.0,
    //     aspectRatio: 16 / 9,
    //     viewportFraction: 1.02,
    //   ),
    //   // items: [1, 2, 3, 4, 5].map((i) {
    //   items: _products.map((data) {
    //     return Builder(
    //       builder: (BuildContext context) {
    //         return Container(
    //           width: MediaQuery.of(context).size.width,
    //           margin: EdgeInsets.symmetric(horizontal: 5.0),
    //           decoration: BoxDecoration(color: Colors.transparent),
    //           child: SingleChildScrollView(
    //             child: Column(
    //               children: [
    //                 Container(
    //                     height: 220,
    //                     margin: const EdgeInsets.only(top: 10),
    //                     clipBehavior: Clip.hardEdge,
    //                     decoration: BoxDecoration(
    //                       borderRadius: BorderRadius.only(
    //                         bottomLeft: Radius.circular(20.0),
    //                         bottomRight: Radius.circular(20.0),
    //                       ),
    //                     ),
    //                     child: Stack(
    //                       children: [
    //                         AspectRatio(
    //                     aspectRatio: 3,
    //                     child: Image.asset(
    //                       data.imageHome!,
    //                       fit: BoxFit.cover,
    //                     ),
    //                   ),

    //                         Positioned(
    //                           left: 5.0,
    //                           child: Container(
    //                             padding: EdgeInsets.symmetric(vertical: 10.0),
    //                             child: Text(
    //                                profileImages.title!,
    //                               textAlign: TextAlign.center,
    //                               style: TextStyle(
    //                                 fontFamily: AppTheme.ruFontKanit,
    //                                 color: Color.fromARGB(255, 7, 26, 64),
    //                                 fontSize: 16.0,
    //                                 fontWeight: FontWeight.w100,
    //                               ),
    //                             ),
    //                           ),
    //                         ),
    //                       ],
    //                     )),
    //               ],
    //             ),
    //           ),
    //         );
    //       },
    //     );
    //   }).toList(),
    // );
  }
}
// class HomeSky extends StatelessWidget {
//   const HomeSky(
//       {Key? key,
//       this.animationController,
//       this.animation})
//       : super(key: key);

//   final AnimationController? animationController;
//   final Animation<double>? animation;

//   @override
//   Widget build(BuildContext context) {
//     return AnimatedBuilder(
//       animation: animationController!,
//       builder: (BuildContext context, Widget? child) {
//         return FadeTransition(
//           opacity: animation!,
//           child: Transform(
//             transform: Matrix4.translationValues(
//                 0.0, 50 * (1.0 - animation!.value), 0.0),
//             child: AspectRatio(
//               aspectRatio: 1.5,
//               child: ClipRRect(
//                 borderRadius: const BorderRadius.all(Radius.circular(4.0)),
//                 child: Stack(
//                   alignment: AlignmentDirectional.center,
//                   children: <Widget>[
//                     Positioned.fill(
//                       child: Image.network('https://img.freepik.com/free-photo/beautiful-dusk-light-colorful-beauty_1203-5706.jpg?w=2000&t=st=1680158838~exp=1680159438~hmac=1b217772a111ade190d2da34d5437d637381b96bb253e162631c2f5caf054334',  fit: BoxFit.cover,height: 220,  width: 500,),
//                     ),
           
//                     // Positioned.fill(
//                     //   child: Icon(listData!.iconsData,
//                     //               size: 120,
//                     //               color: listData!.color,
//                     //               ),
//                     // ),
//                     Material(
//                       color: Colors.transparent,
//                       child: InkWell(
//                         splashColor: Colors.grey.withOpacity(0.2),
//                         borderRadius:
//                             const BorderRadius.all(Radius.circular(4.0)),
//                         // onTap: callBack,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }

// Stack(
//                   children: [
//                       Image.network(
//                         data['image'],
//                         fit: BoxFit.cover,
//                         height: 280,
//                         width: 500,
                      
//                       ),
//                           Positioned(
//                         bottom: 0.0,
//                         left: 0.0,
//                         right: 0.0,
//                         child: Container(
//                           padding: EdgeInsets.symmetric(vertical: 10.0),
//                           color: Colors.black.withOpacity(0.5),
//                           child: Text(
//                             'My Text on Image',
//                             textAlign: TextAlign.center,
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 20.0,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ),
//                       ),