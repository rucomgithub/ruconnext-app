import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:th.ac.ru.uSmart/app_theme.dart';
import 'package:th.ac.ru.uSmart/fitness_app/fitness_app_theme.dart';
import 'package:th.ac.ru.uSmart/ruconnext_app_theme.dart';

class BaseHelpScreen extends StatefulWidget {
  final String title;
  final List<String> imageUrls;
  final bool showBookIcon;

  const BaseHelpScreen({
    Key? key,
    required this.title,
    required this.imageUrls,
    this.showBookIcon = true,
  }) : super(key: key);

  @override
  State<BaseHelpScreen> createState() => _BaseHelpScreenState();
}

class _BaseHelpScreenState extends State<BaseHelpScreen> {
  int _currentIndex = 0;
  final CarouselSliderController _carouselController =
      CarouselSliderController();

  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isLightMode = brightness == Brightness.light;

    return Container(
      color: FitnessAppTheme.background,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          children: [
            _buildModernAppBar(context, isLightMode),
            Expanded(
              child: CarouselSlider(
                carouselController: _carouselController,
                options: CarouselOptions(
                  height: double.infinity,
                  viewportFraction: 0.92,
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 5),
                  autoPlayAnimationDuration: const Duration(milliseconds: 800),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enlargeCenterPage: true,
                  enlargeFactor: 0.12,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                ),
                items: widget.imageUrls.map((url) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24),
                          boxShadow: [
                            BoxShadow(
                              color: isLightMode
                                  ? Colors.black.withValues(alpha: 0.1)
                                  : Colors.black.withValues(alpha: 0.3),
                              offset: const Offset(0, 10),
                              blurRadius: 25,
                              spreadRadius: -5,
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(24),
                          child: Image.network(
                            url,
                            fit: BoxFit.contain,
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;
                              return Center(
                                child: CircularProgressIndicator(
                                  value: loadingProgress.expectedTotalBytes !=
                                          null
                                      ? loadingProgress.cumulativeBytesLoaded /
                                          loadingProgress.expectedTotalBytes!
                                      : null,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    AppTheme.ru_dark_blue,
                                  ),
                                ),
                              );
                            },
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                color: Colors.grey[200],
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.broken_image_outlined,
                                        size: 48,
                                        color: Colors.grey[400],
                                      ),
                                      const SizedBox(height: 12),
                                      Text(
                                        'ไม่สามารถโหลดรูปภาพได้',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontFamily: AppTheme.ruFontKanit,
                                          color: Colors.grey[600],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
            ),
            _buildModernIndicators(isLightMode),
          ],
        ),
      ),
    );
  }

  Widget _buildModernAppBar(BuildContext context, bool isLightMode) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            RuConnextAppTheme.buildLightTheme().scaffoldBackgroundColor,
            RuConnextAppTheme.buildLightTheme()
                .scaffoldBackgroundColor
                .withValues(alpha: 0.95),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.15),
            offset: const Offset(0, 3),
            blurRadius: 12.0,
          ),
        ],
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Row(
            children: <Widget>[
              Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: const BorderRadius.all(Radius.circular(16.0)),
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    child: Icon(
                      Icons.arrow_back_ios_new_rounded,
                      size: 20,
                      color: isLightMode
                          ? AppTheme.nearlyBlack
                          : AppTheme.nearlyWhite,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Center(
                  child: Text(
                    widget.title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      fontFamily: AppTheme.ruFontKanit,
                      color: isLightMode
                          ? AppTheme.nearlyBlack
                          : AppTheme.nearlyWhite,
                      letterSpacing: -0.3,
                    ),
                  ),
                ),
              ),
              if (widget.showBookIcon)
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppTheme.ru_dark_blue.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Icon(
                    FontAwesomeIcons.bookOpenReader,
                    size: 18,
                    color: AppTheme.ru_dark_blue,
                  ),
                )
              else
                const SizedBox(width: 44),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildModernIndicators(bool isLightMode) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (widget.imageUrls.length > 1) ...[
            Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(12),
                onTap: () {
                  if (_currentIndex > 0) {
                    _carouselController.previousPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  }
                },
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: _currentIndex > 0
                        ? AppTheme.ru_dark_blue.withValues(alpha: 0.1)
                        : Colors.grey.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    Icons.chevron_left_rounded,
                    size: 20,
                    color: _currentIndex > 0
                        ? AppTheme.ru_dark_blue
                        : Colors.grey[400],
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
          ],
          ...widget.imageUrls.asMap().entries.map((entry) {
            int index = entry.key;
            bool isActive = _currentIndex == index;

            return GestureDetector(
              onTap: () {
                _carouselController.animateToPage(
                  index,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                width: isActive ? 32 : 8,
                height: 8,
                margin: const EdgeInsets.symmetric(horizontal: 3),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: isActive
                      ? AppTheme.ru_dark_blue
                      : isLightMode
                          ? Colors.grey[300]
                          : Colors.grey[600],
                  boxShadow: isActive
                      ? [
                          BoxShadow(
                            color:
                                AppTheme.ru_dark_blue.withValues(alpha: 0.4),
                            offset: const Offset(0, 2),
                            blurRadius: 6,
                          ),
                        ]
                      : null,
                ),
              ),
            );
          }),
          if (widget.imageUrls.length > 1) ...[
            const SizedBox(width: 16),
            Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(12),
                onTap: () {
                  if (_currentIndex < widget.imageUrls.length - 1) {
                    _carouselController.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  }
                },
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: _currentIndex < widget.imageUrls.length - 1
                        ? AppTheme.ru_dark_blue.withValues(alpha: 0.1)
                        : Colors.grey.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    Icons.chevron_right_rounded,
                    size: 20,
                    color: _currentIndex < widget.imageUrls.length - 1
                        ? AppTheme.ru_dark_blue
                        : Colors.grey[400],
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
