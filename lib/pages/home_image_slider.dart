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

    // Filter images based on current time/title
    List<profileImage> displayImages = _products.where((data) {
      return data.title == title;
    }).toList();

    // If no match found, show all images
    if (displayImages.isEmpty) {
      displayImages = _products;
    }

    // Get current time colors for styling
    Color accentColor = _getAccentColor();
    Color gradientStart = _getGradientStartColor();
    Color gradientEnd = _getGradientEndColor();

    return CarouselSlider(
      options: CarouselOptions(
        height: double.infinity,
        aspectRatio: 16 / 9,
        viewportFraction: displayImages.length == 1 ? 1.0 : 0.92,
        initialPage: 0,
        enableInfiniteScroll: displayImages.length > 1,
        reverse: false,
        autoPlay: displayImages.length > 1,
        autoPlayInterval: const Duration(seconds: 6),
        autoPlayAnimationDuration: const Duration(milliseconds: 1200),
        autoPlayCurve: Curves.easeInOutCubicEmphasized,
        enlargeCenterPage: displayImages.length > 1,
        enlargeFactor: 0.15,
        scrollDirection: Axis.horizontal,
      ),
      items: displayImages.map((data) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              margin: EdgeInsets.symmetric(
                horizontal: displayImages.length == 1 ? 0.0 : 4.0,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                boxShadow: [
                  BoxShadow(
                    color: accentColor.withValues(alpha: 0.3),
                    offset: const Offset(0, 8),
                    blurRadius: 20,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    // Background Image
                    Image.asset(
                      data.imageHome!,
                      fit: BoxFit.cover,
                    ),

                    // Gradient Overlay with time-based colors
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            gradientStart.withValues(alpha: 0.4),
                            gradientEnd.withValues(alpha: 0.2),
                            Colors.transparent,
                          ],
                          stops: const [0.0, 0.4, 1.0],
                        ),
                      ),
                    ),

                    // Decorative Corner Element
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          gradient: RadialGradient(
                            colors: [
                              accentColor.withValues(alpha: 0.2),
                              Colors.transparent,
                            ],
                          ),
                        ),
                      ),
                    ),

                    // Greeting Badge
                    Positioned(
                      top: 12.0,
                      left: 12.0,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12.0,
                          vertical: 6.0,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.9),
                          borderRadius: BorderRadius.circular(20.0),
                          border: Border.all(
                            color: accentColor.withValues(alpha: 0.2),
                            width: 1.5,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.1),
                              offset: const Offset(0, 3),
                              blurRadius: 10,
                              spreadRadius: 0,
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    accentColor,
                                    accentColor.withValues(alpha: 0.7),
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: accentColor.withValues(alpha: 0.25),
                                    offset: const Offset(0, 1),
                                    blurRadius: 4,
                                  ),
                                ],
                              ),
                              child: Icon(
                                icon,
                                color: Colors.white,
                                size: 14,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              title,
                              style: TextStyle(
                                fontFamily: AppTheme.ruFontKanit,
                                fontWeight: FontWeight.w600,
                                fontSize: 12,
                                color: AppTheme.ru_dark_blue,
                                letterSpacing: 0.3,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // Time Period Label
                    // Positioned(
                    //   bottom: 16.0,
                    //   right: 16.0,
                    //   child: Container(
                    //     padding: const EdgeInsets.symmetric(
                    //       horizontal: 16.0,
                    //       vertical: 8.0,
                    //     ),
                    //     decoration: BoxDecoration(
                    //       color: accentColor,
                    //       borderRadius: BorderRadius.circular(20.0),
                    //       boxShadow: [
                    //         BoxShadow(
                    //           color: Colors.black.withValues(alpha: 0.2),
                    //           offset: const Offset(0, 4),
                    //           blurRadius: 12,
                    //         ),
                    //       ],
                    //     ),
                    //     child: Text(
                    //       data.description ?? '',
                    //       style: TextStyle(
                    //         fontFamily: AppTheme.ruFontKanit,
                    //         fontWeight: FontWeight.w600,
                    //         fontSize: 12,
                    //         color: Colors.white,
                    //       ),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
            );
          },
        );
      }).toList(),
    );
  }

  // Helper method to get accent color based on time
  Color _getAccentColor() {
    if (title.contains('เช้า')) {
      return const Color(0xFFFFA726); // Orange for morning
    } else if (title.contains('บ่าย')) {
      return const Color(0xFF42A5F5); // Blue for afternoon
    } else if (title.contains('เย็น')) {
      return const Color(0xFFAB47BC); // Purple for evening
    }
    return AppTheme.ru_yellow;
  }

  // Helper method to get gradient start color
  Color _getGradientStartColor() {
    if (title.contains('เช้า')) {
      return const Color(0xFFFF6B6B); // Red-orange for morning
    } else if (title.contains('บ่าย')) {
      return const Color(0xFF4FC3F7); // Light blue for afternoon
    } else if (title.contains('เย็น')) {
      return const Color(0xFF7E57C2); // Deep purple for evening
    }
    return Colors.black;
  }

  // Helper method to get gradient end color
  Color _getGradientEndColor() {
    if (title.contains('เช้า')) {
      return const Color(0xFFFFA726); // Orange for morning
    } else if (title.contains('บ่าย')) {
      return const Color(0xFF1976D2); // Dark blue for afternoon
    } else if (title.contains('เย็น')) {
      return const Color(0xFF512DA8); // Purple for evening
    }
    return Colors.black;
  }
}
