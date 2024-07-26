import 'package:th.ac.ru.uSmart/app_theme.dart';
import 'package:th.ac.ru.uSmart/providers/region_enroll_provider.dart';
import 'package:th.ac.ru.uSmart/providers/ruregion_check_cart.dart';
import 'package:th.ac.ru.uSmart/providers/ruregis_fee_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:th.ac.ru.uSmart/providers/ruregis_provider.dart';
import '../../fitness_app/fitness_app_theme.dart';
import '../../model/checkregis_model.dart';

class ButtonQRView extends StatefulWidget {
  const ButtonQRView(
      {Key? key, this.mainScreenAnimationController, this.mainScreenAnimation})
      : super(key: key);

  final AnimationController? mainScreenAnimationController;
  final Animation<double>? mainScreenAnimation;
  @override
  _ButtonQRViewState createState() => _ButtonQRViewState();
}

class _ButtonQRViewState extends State<ButtonQRView>
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
    var isload = context.watch<RegionEnrollProvider>().isLoadingConfirm;
    var msgbuttonQR = context.watch<RegionEnrollProvider>().msgSaveButtonQR;
    bool? counter = Provider.of<RuregisProvider>(context, listen: false)
        .counterregionApp
        .resultsAppControl![6]
        .aPISTATUS;

    return AnimatedBuilder(
      animation: widget.mainScreenAnimationController!,
      builder: (BuildContext context, Widget? child) {
        // var feeData = context.watch<RuregisFeeProvider>();
        return Container(
          margin: EdgeInsets.all(8.0),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white, // foreground
              backgroundColor: Colors.green,
            ),
            onPressed: isload || !counter!
                ? null
                : () {
                    Provider.of<RegionEnrollProvider>(context, listen: false)
                        .postQRApp();
                  },
            // child: Text('ยืนยันวิชา ซ้ำซ้อน$checkdup ติ้กขอจบ$statusgrad location$checklocation '),
            child: Text('$msgbuttonQR'),
          ),
        );
      },
    );
  }
}
