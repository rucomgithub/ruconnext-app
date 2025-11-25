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
    Provider.of<RuregisProvider>(context, listen: false)
        .getQRButton();
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
     bool? checkButtonQR = Provider.of<RuregisProvider>(context, listen: false).buttonQRregionApp.rEGISSTATUS;
     print('QR in Page ======> $checkButtonQR');
    bool? counter = Provider.of<RuregisProvider>(context, listen: false)
        .counterregionApp
        .resultsAppControl![0]
        .aPISTATUS;
    print('counter in Page ======> $counter');
    return AnimatedBuilder(
      animation: widget.mainScreenAnimationController!,
      builder: (BuildContext context, Widget? child) {
        return Container(
          margin: EdgeInsets.all(8.0),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Color(0xFF1E88E5),
            ),
            onPressed: (isload || checkButtonQR! || counter!)
    ? null
    : () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('ยืนยันการรับ QRCODE'),
              content: RichText(
                text: TextSpan(
                  style: Theme.of(context).textTheme.bodyMedium,
                  children: [
                    TextSpan(
                      text: 'หากทำการยืนยันรับ QRCODE แล้วจะ',
                    ),
                    TextSpan(
                      text: 'ไม่สามารถเปลี่ยนแปลงวิชาและขอจบได้ ',
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: 'โปรดตรวจสอบวิชาให้เรียบร้อยก่อนยืนยัน',
                    ),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: Text('ยกเลิก'),
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.red,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: Text('ยืนยัน'),
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.green,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                    Provider.of<RegionEnrollProvider>(context, listen: false)
                        .postQRApp();
                  },
                ),
              ],
            );
          },
        );
      },

            child: Row(
              mainAxisSize: MainAxisSize.min, // ขนาดตามเนื้อหา
              children: [
                Text('$msgbuttonQR'),
                const SizedBox(width: 8),
                Icon(Icons.qr_code_2_rounded), // หรือใช้ Icons.qr_code
              ],
            ),
          ),
        );
      },
    );
  }
}
