import 'package:th.ac.ru.uSmart/app_theme.dart';
import 'package:th.ac.ru.uSmart/providers/ruregion_check_cart.dart';
import 'package:th.ac.ru.uSmart/providers/ruregis_fee_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../fitness_app/fitness_app_theme.dart';
import '../../model/checkregis_model.dart';

class ButtonSuccessView extends StatefulWidget {
  const ButtonSuccessView(
      {Key? key, this.mainScreenAnimationController, this.mainScreenAnimation})
      : super(key: key);

  final AnimationController? mainScreenAnimationController;
  final Animation<double>? mainScreenAnimation;
  @override
  _ButtonSuccessViewState createState() => _ButtonSuccessViewState();
}

class _ButtonSuccessViewState extends State<ButtonSuccessView>
    with TickerProviderStateMixin {
  AnimationController? animationController;

  @override
  void initState() {
    Provider.of<RuregisFeeProvider>(context, listen: false)
        .getCalPayRegionApp();
    Provider.of<RuregionCheckCartProvider>(context, listen: false)
        .getStatusGraduate(false);
    Provider.of<RuregionCheckCartProvider>(context, listen: false)
        .getLocationExam('');
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
    var checkdup = context.watch<RuregionCheckCartProvider>().isCourseDup;
    var creditmaxmin = context.watch<RuregionCheckCartProvider>().isSuccessCalpay;
    var statusgrad = context.watch<RuregionCheckCartProvider>().statusGrad;
    var statusButton = context.watch<RuregionCheckCartProvider>().statusButton;
    var checklocation =
        context.watch<RuregionCheckCartProvider>().isCheckLocation;

    return AnimatedBuilder(
      animation: widget.mainScreenAnimationController!,
      builder: (BuildContext context, Widget? child) {
        var feeData = context.watch<RuregisFeeProvider>();
        return feeData.isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Container(
                margin: EdgeInsets.all(8.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white, // foreground
                    backgroundColor: Colors.green,
                  ),
                  onPressed: checklocation && checkdup && creditmaxmin
                      ? () { }
                      : null,
                  // child: Text('ยืนยันวิชา ซ้ำซ้อน$checkdup ติ้กขอจบ$statusgrad location$checklocation '),
                  child: Text(
                      'ลงทะเบียนสำเร็จ'),
                ),
              );
      },
    );
  }
}
