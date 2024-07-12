import 'package:th.ac.ru.uSmart/app_theme.dart';
import 'package:th.ac.ru.uSmart/providers/ruregion_check_cart.dart';
import 'package:th.ac.ru.uSmart/providers/ruregis_fee_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../fitness_app/fitness_app_theme.dart';
import '../../model/checkregis_model.dart';

class LocationExamView extends StatefulWidget {
  const LocationExamView(
      {Key? key, this.mainScreenAnimationController, this.mainScreenAnimation})
      : super(key: key);

  final AnimationController? mainScreenAnimationController;
  final Animation<double>? mainScreenAnimation;
  @override
  _LocationExamViewState createState() => _LocationExamViewState();
}

class _LocationExamViewState extends State<LocationExamView>
    with TickerProviderStateMixin {
  AnimationController? animationController;
  var dropdownvalue;
  @override
  void initState() {
    Provider.of<RuregionCheckCartProvider>(context, listen: false)
        .fetchLocationExam();
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
        var locationexam =
            context.watch<RuregionCheckCartProvider>().locationexam;
        var isLoading = context.watch<RuregionCheckCartProvider>().isLoadingLocation;
        return isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white, // Background color of the container
                    borderRadius:
                        BorderRadius.circular(12.0), // Rounded corners
                    border: Border.all(
                     color: dropdownvalue == null ? Colors.red : Colors.blue, // Conditional border color
                      width: dropdownvalue == null ? 2.0 : 1.0, // Border width
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: DropdownButtonFormField(
                    decoration: InputDecoration(
                      hintText: 'เลือกศูนย์สอบ',
                      filled: true,
                      fillColor: Color.fromARGB(255, 255, 255, 255)
                          .withOpacity(0.2), // Background color of the field
                      border: InputBorder.none, // Remove the underline border
                      enabledBorder: InputBorder
                          .none, // Remove the underline border when enabled
                      focusedBorder: InputBorder
                          .none, // Remove the underline border when focused
                    ),
                    dropdownColor: Color.fromARGB(255, 255, 255,
                        255), // Background color of the dropdown menu
                    items: locationexam.results!.map((item) {
                      var nameLocation = item.eXAMLOCATIONNAMETHAI.toString();
                      return DropdownMenuItem(
                        value: item.rEGIONALEXAMNO.toString(),
                        child: Text(
                          item.eXAMLOCATIONNAMETHAI.toString(),
                          style: TextStyle(
                            fontFamily: AppTheme.ruFontKanit,
                            fontWeight: FontWeight.normal,
                            fontSize: 15,
                            letterSpacing: 0.0,
                            color: FitnessAppTheme.nearlyBlack,
                          ), // Text color
                        ),
                      );
                    }).toList(),
                    onChanged: (newVal) {
                      setState(() {
                      dropdownvalue = newVal;
                      Provider.of<RuregionCheckCartProvider>(context, listen: false).getLocationExam(dropdownvalue);
                   Provider.of<RuregionCheckCartProvider>(context, listen: false).checkButtonComfirm();

                      });
                    },
                    value: dropdownvalue,
                  ),
                ),
              );
      },
    );
  }
}
