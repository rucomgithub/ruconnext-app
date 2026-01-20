import 'package:th.ac.ru.uSmart/app_theme.dart';
import 'package:th.ac.ru.uSmart/providers/register_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../fitness_app/fitness_app_theme.dart';

class RegisterListView extends StatefulWidget {
  const RegisterListView(
      {Key? key, this.mainScreenAnimationController, this.mainScreenAnimation})
      : super(key: key);

  final AnimationController? mainScreenAnimationController;
  final Animation<double>? mainScreenAnimation;
  @override
  _RegisterListViewState createState() => _RegisterListViewState();
}

class _RegisterListViewState extends State<RegisterListView>
    with TickerProviderStateMixin {
  AnimationController? animationController;
  List<String> areaListData = <String>[
    'assets/fitness_app/area1.png',
    'assets/fitness_app/area2.png',
    'assets/fitness_app/area3.png',
    'assets/fitness_app/area1.png',
  ];

  @override
  void initState() {
    Provider.of<RegisterProvider>(context, listen: false).getAllRegister();
    animationController = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.mainScreenAnimationController!,
      builder: (BuildContext context, Widget? child) {
        var registerProv = context.watch<RegisterProvider>();
        return registerProv.isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Stack(
                children: <Widget>[
                  SizedBox(
                    height: MediaQuery.of(context).padding.bottom,
                  ),
                  Expanded(
                    child: FadeTransition(
                      opacity: widget.mainScreenAnimation!,
                      child: Transform(
                        transform: Matrix4.translationValues(0.0,
                            30 * (1.0 - widget.mainScreenAnimation!.value), 0.0),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0, right: 8),
                          child: ListView.builder(
                            padding: const EdgeInsets.only(
                                left: 16, right: 16, top: 16, bottom: 16),
                            physics: const BouncingScrollPhysics(),
                            itemCount: registerProv.listGroupYearSemester.length,
                            itemBuilder: (BuildContext context, int index) {
                              final int count =
                                  registerProv.listGroupYearSemester.length;
                              final Animation<double> animation =
                                  Tween<double>(begin: 0.0, end: 1.0).animate(
                                CurvedAnimation(
                                  parent: animationController!,
                                  curve: Interval((1 / count) * index, 1.0,
                                      curve: Curves.fastOutSlowIn),
                                ),
                              );
                              animationController?.forward();
                              String name = registerProv
                                  .listGroupYearSemester.keys
                                  .elementAt(index);
                              List<String> values =
                                  registerProv.listGroupYearSemester[name]!;
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 16),
                                child: AreaView(
                                  index: index,
                                  name: name,
                                  values: values,
                                  animation: animation,
                                  animationController: animationController!,
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
      },
    );
  }
}

Icon IconFavorite(bool favorite) {
  return favorite
      ? Icon(
          Icons.star,
          color: Color.fromARGB(255, 255, 208, 0),
          size: 25,
        )
      : Icon(
          Icons.star_border_outlined,
          color: AppTheme.nearlyWhite,
          size: 25,
        );
}

class AreaView extends StatefulWidget {
  const AreaView({
    Key? key,
    this.index,
    this.name,
    this.values,
    this.animationController,
    this.animation,
  }) : super(key: key);

  final int? index;
  final String? name;
  final List<String>? values;
  final AnimationController? animationController;
  final Animation<double>? animation;

  @override
  State<AreaView> createState() => _AreaViewState();
}

class _AreaViewState extends State<AreaView>
    with SingleTickerProviderStateMixin {
  bool _isExpanded = false;
  late AnimationController _expandController;
  late Animation<double> _expandAnimation;

  @override
  void initState() {
    super.initState();
    _expandController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _expandAnimation = CurvedAnimation(
      parent: _expandController,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _expandController.dispose();
    super.dispose();
  }

  void _toggleExpanded() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _expandController.forward();
      } else {
        _expandController.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.animationController!,
      builder: (BuildContext context, Widget? child) {
        return FadeTransition(
          opacity: widget.animation!,
          child: Transform(
            transform: Matrix4.translationValues(
                0.0, 50 * (1.0 - widget.animation!.value), 0.0),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppTheme.nearlyWhite,
                    AppTheme.nearlyWhite.withValues(alpha: 0.95),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16.0),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: AppTheme.ru_dark_blue.withValues(alpha: 0.12),
                      offset: const Offset(0, 4),
                      blurRadius: 12.0,
                      spreadRadius: 0),
                ],
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  focusColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  borderRadius: BorderRadius.circular(16.0),
                  splashColor: AppTheme.ru_dark_blue.withValues(alpha: 0.1),
                  onTap: _toggleExpanded,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 16),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              AppTheme.ru_dark_blue,
                              AppTheme.ru_dark_blue.withValues(alpha: 0.9),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(16.0),
                            topRight: Radius.circular(16.0),
                          ),
                        ),
                        child: Stack(
                          children: [
                            Column(
                              children: [
                                Icon(
                                  Icons.calendar_today_rounded,
                                  color: AppTheme.ru_yellow,
                                  size: 32,
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'ปีการศึกษา',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: AppTheme.ruFontKanit,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                    color: AppTheme.nearlyWhite.withValues(alpha: 0.8),
                                  ),
                                ),
                                Text(
                                  widget.name!,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: AppTheme.ruFontKanit,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 28,
                                    color: AppTheme.ru_yellow,
                                  ),
                                ),
                              ],
                            ),
                            Positioned(
                              right: 0,
                              top: 0,
                              child: AnimatedRotation(
                                turns: _isExpanded ? 0.5 : 0,
                                duration: const Duration(milliseconds: 300),
                                child: Icon(
                                  Icons.keyboard_arrow_down_rounded,
                                  color: AppTheme.ru_yellow,
                                  size: 32,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 12),
                          decoration: BoxDecoration(
                            color:
                                AppTheme.ru_dark_blue.withValues(alpha: 0.08),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.class_rounded,
                                color: AppTheme.ru_dark_blue,
                                size: 20,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'จำนวนวิชาที่ลงทะเบียน',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: AppTheme.ruFontKanit,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 13,
                                  color: AppTheme.ru_dark_blue,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 4),
                                decoration: BoxDecoration(
                                  color: AppTheme.ru_yellow,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  '${widget.values == null ? "0" : widget.values!.length}',
                                  style: TextStyle(
                                    fontFamily: AppTheme.ruFontKanit,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    color: AppTheme.ru_dark_blue,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizeTransition(
                        sizeFactor: _expandAnimation,
                        axisAlignment: -1.0,
                        child: Container(
                          constraints: BoxConstraints(
                            maxHeight: MediaQuery.of(context).size.height * 0.4,
                          ),
                          margin: const EdgeInsets.symmetric(horizontal: 16),
                          child: ListView.separated(
                            shrinkWrap: true,
                            padding: const EdgeInsets.only(bottom: 16, top: 8),
                            separatorBuilder:
                                (BuildContext context, int index) =>
                                    const SizedBox(height: 8),
                            itemCount: widget.values!.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 10),
                                decoration: BoxDecoration(
                                  color: AppTheme.nearlyWhite,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: AppTheme.ru_dark_blue
                                        .withValues(alpha: 0.1),
                                    width: 1,
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 28,
                                      height: 28,
                                      decoration: BoxDecoration(
                                        color: AppTheme.ru_yellow
                                            .withValues(alpha: 0.2),
                                        shape: BoxShape.circle,
                                      ),
                                      child: Center(
                                        child: Text(
                                          '${index + 1}',
                                          style: TextStyle(
                                            fontFamily:
                                                AppTheme.ruFontKanit,
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color: AppTheme.ru_dark_blue,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Text(
                                        widget.values![index],
                                        style: TextStyle(
                                          fontFamily: AppTheme.ruFontKanit,
                                          fontSize: 13,
                                          color: AppTheme.ru_dark_blue,
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
