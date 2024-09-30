import 'package:th.ac.ru.uSmart/master/providers/master_grade_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:th.ac.ru.uSmart/widget/ru_grade.dart';

class MasterSummaryCreditView extends StatefulWidget {
  const MasterSummaryCreditView(
      {Key? key, this.mainScreenAnimationController, this.mainScreenAnimation})
      : super(key: key);

  final AnimationController? mainScreenAnimationController;
  final Animation<double>? mainScreenAnimation;

  @override
  _MasterSummaryCreditViewState createState() =>
      _MasterSummaryCreditViewState();
}

class _MasterSummaryCreditViewState extends State<MasterSummaryCreditView>
    with TickerProviderStateMixin {
  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 1200));
    return true;
  }

  @override
  Widget build(BuildContext context) {
    var prov = Provider.of<MasterGradeProvider>(context, listen: false);
    return AnimatedBuilder(
      animation: widget.mainScreenAnimationController!,
      builder: (BuildContext context, Widget? child) {
        return FadeTransition(
          opacity: widget.mainScreenAnimation!,
          child: Transform(
            transform: Matrix4.translationValues(
                0.0, 30 * (1.0 - widget.mainScreenAnimation!.value), 0.0),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: prov.summaryCreditPass.isEmpty
                  ? SizedBox()
                  : Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          RuGradeView(
                            caption: 'เกรดเฉลี่ย',
                            description: '${prov.grade.gpa}',
                            iconname: Icons.grade,
                            caption2: 'หน่วยกิตสะสม',
                            description2: '${prov.grade.summaryCredit}',
                            iconname2: Icons.abc,
                            duration: 1200,
                          ),
                        ],
                      ),
                    ),
            ),
          ),
        );
      },
    );
  }
}
