import 'package:th.ac.ru.uSmart/fitness_app/models/grade_list_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:th.ac.ru.uSmart/providers/rotcs_provider.dart';
import 'package:th.ac.ru.uSmart/widget/card/card_book_title.dart';

class RotcsRegisterListView extends StatefulWidget {
  const RotcsRegisterListView(
      {Key? key, this.mainScreenAnimationController, this.mainScreenAnimation})
      : super(key: key);

  final AnimationController? mainScreenAnimationController;
  final Animation<double>? mainScreenAnimation;

  @override
  _RotcsRegisterListViewState createState() => _RotcsRegisterListViewState();
}

class _RotcsRegisterListViewState extends State<RotcsRegisterListView>
    with TickerProviderStateMixin {
  AnimationController? animationController;
  List<GradeListData> gradeListData = GradeListData.tabIconsList;

  @override
  void initState() {
    Provider.of<RotcsProvider>(context, listen: false).getAllRegister();
    animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    super.initState();
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    return true;
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var loading = context.watch<RotcsProvider>().isLoading;
    var register = context.watch<RotcsProvider>().rotcsregister;
    var error = context.watch<RotcsProvider>().rotcserror;
    return loading
        ? Container(child: SizedBox())
        : AnimatedBuilder(
            animation: widget.mainScreenAnimationController!,
            builder: (BuildContext context, Widget? child) {
              return FadeTransition(
                opacity: widget.mainScreenAnimation!,
                child: Transform(
                  transform: Matrix4.translationValues(
                      0.0, 30 * (1.0 - widget.mainScreenAnimation!.value), 0.0),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 250,
                      width: double.infinity,
                      child: ListView.builder(
                        itemCount: register.detail!.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (BuildContext context, int index) {
                          final int count = register.detail!.length > 10
                              ? 10
                              : register.detail!.length;
                          final Animation<double> animation =
                              Tween<double>(begin: 0.0, end: 1.0).animate(
                                  CurvedAnimation(
                                      parent: animationController!,
                                      curve: Interval((1 / count) * index, 1.0,
                                          curve: Curves.fastOutSlowIn)));
                          animationController?.forward();
                          return Padding(
                            padding: const EdgeInsets.only(
                                top: 8.0, left: 16.0, bottom: 8.0),
                            child: CardBookTitle(
                              iconheader: Icons.report,
                              iconfooter: Icons.save,
                              header: 'รายงานตัว นศท.',
                              footer:
                                  'ชั้นปีที่ ${register.detail![index].layerReport}',
                              title:
                                  'ประจำปี ${register.detail![index].yearReport}',
                              content:
                                  'สถานศึกษาวิชาทหาร ${register.detail![index].locationArmy}',
                              animation: animation,
                              animationController: animationController!,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              );
            },
          );
  }
}
