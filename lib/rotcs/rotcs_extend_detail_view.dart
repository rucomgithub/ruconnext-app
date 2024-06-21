import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:th.ac.ru.uSmart/app_theme.dart';
import 'package:th.ac.ru.uSmart/fitness_app/models/grade_list_data.dart';
import 'package:th.ac.ru.uSmart/main.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:th.ac.ru.uSmart/model/rotcs_extend.dart';
import 'package:th.ac.ru.uSmart/providers/rotcs_provider.dart';
import 'package:th.ac.ru.uSmart/ruconnext_app_theme.dart';

class RotcsExtendDetailView extends StatefulWidget {
  const RotcsExtendDetailView(
      {Key? key, this.mainScreenAnimationController, this.mainScreenAnimation})
      : super(key: key);

  final AnimationController? mainScreenAnimationController;
  final Animation<double>? mainScreenAnimation;

  @override
  _RotcsExtendDetailViewState createState() => _RotcsExtendDetailViewState();
}

class _RotcsExtendDetailViewState extends State<RotcsExtendDetailView>
    with TickerProviderStateMixin {
  AnimationController? animationController;
  List<GradeListData> gradeListData = GradeListData.tabIconsList;

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    super.initState();
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 600));
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
    var extend = context.watch<RotcsProvider>().rotcsextend;
    var extenderror = context.watch<RotcsProvider>().rotcsextenderror;
    return loading
        ? Container(
            child: Column(
                children: [CircularProgressIndicator(), Text(extenderror)]))
        : Container(
            decoration: BoxDecoration(
              color: RuConnextAppTheme.buildLightTheme().backgroundColor,
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    offset: const Offset(0, 2),
                    blurRadius: 8.0),
              ],
            ),
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('ปีที่ผ่อนผัน : ${extend.extendYear}'),
                  Text('${extend.code9}'),
                  Text('${extend.option1}'),
                  Text('${extend.option2}'),
                  Text('${extend.option3}'),
                  Text('${extend.option4}'),
                  Text('${extend.option5}'),
                  Text('${extend.option6}'),
                  Text('${extend.option7}'),
                  Text('${extend.option8}'),
                  Text('${extend.option9}'),
                  Text('${extend.optionOther}'),
                ],
              ),
            ),
          );
  }
}
