
import 'package:th.ac.ru.uSmart/app_theme.dart';
import 'package:th.ac.ru.uSmart/providers/ruregion_check_cart.dart';
import 'package:th.ac.ru.uSmart/providers/ruregis_fee_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../fitness_app/fitness_app_theme.dart';
import '../../model/checkregis_model.dart';

class ButtonConfirmView extends StatefulWidget {
  const ButtonConfirmView(
      {Key? key, this.mainScreenAnimationController, this.mainScreenAnimation})
      : super(key: key);

  final AnimationController? mainScreenAnimationController;
  final Animation<double>? mainScreenAnimation;
  @override
  _ButtonConfirmViewState createState() => _ButtonConfirmViewState();
}

class _ButtonConfirmViewState extends State<ButtonConfirmView>
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
    var creditmaxmin =
        context.watch<RuregionCheckCartProvider>().isSuccessCalpay;
    var checklocation =
        context.watch<RuregionCheckCartProvider>().isCheckLocation;
        var msgbutton =
        context.watch<RuregionCheckCartProvider>().msgSaveButtonRegis;

    return AnimatedBuilder(
      animation: widget.mainScreenAnimationController!,
      builder: (BuildContext context, Widget? child) {
        var feeData = context.watch<RuregisFeeProvider>();
        var loading =
            context.watch<RuregionCheckCartProvider>();
        print(loading.isLoadingConfirm);
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
                  onPressed: checklocation && checkdup && creditmaxmin && !loading.isLoadingConfirm
                      ? () {
                          Provider.of<RuregionCheckCartProvider>(context,
                                  listen: false)
                              .postEnrollApp();
                        }
                      : null,
                  child: Text('$msgbutton'),
                ),
              );
      },
    );
  }


}
