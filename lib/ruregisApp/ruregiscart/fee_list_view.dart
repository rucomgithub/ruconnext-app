import 'package:th.ac.ru.uSmart/app_theme.dart';

import 'package:th.ac.ru.uSmart/providers/register_provider.dart';
import 'package:th.ac.ru.uSmart/providers/ruregis_mr30_provider.dart';
import 'package:th.ac.ru.uSmart/providers/ruregis_provider.dart';
import 'package:th.ac.ru.uSmart/registers/register_nodata_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../fitness_app/fitness_app_theme.dart';
import '../../model/register_model.dart';
import '../../model/ruregion_mr30_model.dart';

class RuregisFeeListView extends StatefulWidget {
  const RuregisFeeListView(
      {Key? key, this.mainScreenAnimationController, this.mainScreenAnimation})
      : super(key: key);

  final AnimationController? mainScreenAnimationController;
  final Animation<double>? mainScreenAnimation;
  @override
  _RuregisFeeListViewState createState() => _RuregisFeeListViewState();
}

class _RuregisFeeListViewState extends State<RuregisFeeListView>
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
        var ruregisProv = context.watch<RUREGISMR30Provider>();
        return registerProv.isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Stack(
                children: <Widget>[
                  SizedBox(
                    height: MediaQuery.of(context).padding.bottom,
                  ),
                  FadeTransition(
                    opacity: widget.mainScreenAnimation!,
                    child: Transform(
                      transform: Matrix4.translationValues(0.0,
                          30 * (1.0 - widget.mainScreenAnimation!.value), 0.0),
                      child: AspectRatio(
                        aspectRatio: 1.0,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0, right: 8),
                          child: GridView(
                            padding: const EdgeInsets.only(
                                left: 16, right: 16, top: 0, bottom: 0),
                            physics: const BouncingScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            children: List<Widget>.generate(
                              1,
                              (int index) {
                                final int count = 1;
                                final Animation<double> animation =
                                    Tween<double>(begin: 0.0, end: 1.0).animate(
                                  CurvedAnimation(
                                    parent: animationController!,
                                    curve: Interval((1 / count) * index, 1.0,
                                        curve: Curves.fastOutSlowIn),
                                  ),
                                );
                                animationController?.forward();
                                String name = ruregisProv
                                    .mr30ruregionrec[index].cOURSENAME!;
                                List<Results> values =
                                    ruregisProv.mr30ruregionrec;
                                return AreaView(
                                  index: index,
                                  name: name,
                                  values: values,
                                  animation: animation,
                                  animationController: animationController!,
                                );
                              },
                            ),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 1,
                              mainAxisSpacing: 24.0,
                              crossAxisSpacing: 24.0,
                              childAspectRatio: 1.0,
                            ),
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

class AreaView extends StatelessWidget {
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
  final List<Results>? values;
  final AnimationController? animationController;
  final Animation<double>? animation;

  @override
  Widget build(BuildContext context) {
   var sumcredit = context.watch<RUREGISMR30Provider>().sumIntCredit;
    return AnimatedBuilder(
      animation: animationController!,
      builder: (BuildContext context, Widget? child) {
        return FadeTransition(
          opacity: animation!,
          child: Transform(
            transform: Matrix4.translationValues(
                0.0, 50 * (1.0 - animation!.value), 0.0),
            child: Container(
              decoration: BoxDecoration(
                color: FitnessAppTheme.white,
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(8.0),
                    bottomLeft: Radius.circular(8.0),
                    bottomRight: Radius.circular(8.0),
                    topRight: Radius.circular(8.0)),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: FitnessAppTheme.grey.withOpacity(0.4),
                      offset: const Offset(1.1, 1.1),
                      blurRadius: 10.0),
                ],
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  focusColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                  splashColor: FitnessAppTheme.nearlyDarkBlue.withOpacity(0.2),
                  onTap: () {},
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding:
                            const EdgeInsets.only(left: 10, bottom: 1, top: 10,right: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'รายการค่าธรรมเนียม',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontFamily: AppTheme.ruFontKanit,
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                                color: FitnessAppTheme.nearlyBlack,
                              ),
                            ),
                            Text(
                              'ราคา', // Replace with your right-aligned text
                              textAlign: TextAlign.end,
                              style: TextStyle(
                                fontFamily: AppTheme.ruFontKanit,
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                                color: FitnessAppTheme.nearlyBlack,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 275,
                        child: ListView.builder(
                          padding: const EdgeInsets.only(
                              left: 8, top: 0, right: 1, bottom: 0),
                          itemCount: values!.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              height: 25,
                              child: ListTile(
                                title: Text(
                                  '${index + 1}. ${values![index].cOURSENO} (${values![index].cREDIT}) ',
                                  style: TextStyle(
                                    fontFamily: AppTheme.ruFontKanit,
                                    fontSize: 14,
                                    color: FitnessAppTheme.nearlyBlack,
                                  ),
                                ),
                                trailing: Text(
                                  ' ${values![index].eXAMDATE} (${values![index].eXAMPERIOD})',
                                  style: TextStyle(
                                    fontFamily: AppTheme.ruFontKanit,
                                    fontSize: 14,
                                    color: FitnessAppTheme.nearlyBlack,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      )
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
