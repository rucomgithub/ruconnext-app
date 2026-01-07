import 'package:th.ac.ru.uSmart/fitness_app/models/grade_list_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:th.ac.ru.uSmart/providers/insurance_provider.dart';
import 'package:th.ac.ru.uSmart/widget/card/card_book_title.dart';

class InsuraceListView extends StatefulWidget {
  const InsuraceListView(
      {Key? key, this.mainScreenAnimationController, this.mainScreenAnimation})
      : super(key: key);

  final AnimationController? mainScreenAnimationController;
  final Animation<double>? mainScreenAnimation;

  @override
  _InsuraceListViewState createState() => _InsuraceListViewState();
}

class _InsuraceListViewState extends State<InsuraceListView>
    with TickerProviderStateMixin {
  AnimationController? animationController;
  List<GradeListData> gradeListData = GradeListData.tabIconsList;

  @override
  void initState() {
    //Provider.of<InsuranceProvider>(context, listen: false).getInsuracneAll();
    animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    super.initState();
  }

  Future<bool> getData() async {
    //Provider.of<InsuranceProvider>(context, listen: false).getInsuracneAll();
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
    var loading = context.watch<InsuranceProvider>().isLoading;
    var insurance = context.watch<InsuranceProvider>().insurance;
    var insuranceerror = context.watch<InsuranceProvider>().insuranceerror;
    return loading
        ? Container(child: SizedBox())
        : Column(
            children: [
              AnimatedBuilder(
                animation: widget.mainScreenAnimationController!,
                builder: (BuildContext context, Widget? child) {
                  return FadeTransition(
                    opacity: widget.mainScreenAnimation!,
                    child: Transform(
                      transform: Matrix4.translationValues(0.0,
                          30 * (1.0 - widget.mainScreenAnimation!.value), 0.0),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 250,
                          width: double.infinity,
                          child: ListView.builder(
                            itemCount: insurance.detail!.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (BuildContext context, int index) {
                              final int count = insurance.detail!.length > 10
                                  ? 10
                                  : insurance.detail!.length;
                              final Animation<double> animation =
                                  Tween<double>(begin: 0.0, end: 1.0).animate(
                                      CurvedAnimation(
                                          parent: animationController!,
                                          curve: Interval(
                                              (1 / count) * index, 1.0,
                                              curve: Curves.fastOutSlowIn)));
                              animationController?.forward();
                              //return Text('data');
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CardBookTitle(
                                  iconheader: Icons.security,
                                  iconfooter: Icons.local_hospital,
                                  header:
                                      insurance.detail![index].nameInsurance,
                                  footer:
                                      insurance.detail![index].typeInsurance,
                                  title: '',
                                  content: insurance.detail![index].expire,
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
              ),
            ],
          );
  }
}
