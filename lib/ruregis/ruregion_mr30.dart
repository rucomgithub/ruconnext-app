// ignore_for_file: non_constant_identifier_names

import 'package:carousel_slider/carousel_slider.dart';
import 'package:th.ac.ru.uSmart/app_theme.dart';
import 'package:th.ac.ru.uSmart/hotel_booking/model/hotel_list_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:th.ac.ru.uSmart/model/ruregis_list_data.dart';
import 'package:th.ac.ru.uSmart/providers/ruregion_mr30_provider.dart';
import 'package:th.ac.ru.uSmart/widget/Rubar.dart';
import '../hotel_booking/hotel_app_theme.dart';
import '../providers/ruregis_provider.dart';
import '../providers/ruregis_fee_provider.dart';
import 'package:get/get.dart';
import '../providers/mr30_provider.dart';
import 'package:badges/badges.dart' as badges;

class RuregionMR30Screen extends StatefulWidget {
  @override
  _RuregionMR30ScreenState createState() => _RuregionMR30ScreenState();
}

class _RuregionMR30ScreenState extends State<RuregionMR30Screen>
    with TickerProviderStateMixin {
  AnimationController? animationController;
  int _current = 0;
  dynamic _selectedIndex = {};

  CarouselController _carouselController = new CarouselController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    super.initState();
    var stdcode = Provider.of<RuregisProvider>(context, listen: false).stdcode;
    var sem = Provider.of<RuregisProvider>(context, listen: false).semester;
    var year = Provider.of<RuregisProvider>(context, listen: false).year;
    Provider.of<RuregionProvider>(context, listen: false)
        .fetchMR30RUREGION(stdcode, sem, year);
    Provider.of<RuregisProvider>(context, listen: false).fetchLocationExam();
    Provider.of<RuregionProvider>(context, listen: false).mr30ruregionrec;
    Provider.of<RuregionProvider>(context, listen: false);
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
    var mr30rec = context.watch<RuregionProvider>().mr30ruregionrec;
    return Theme(
      data: HotelAppTheme.buildLightTheme(),
      child: Provider.of<RuregionProvider>(context).isLoading == false
          ? Container(
              child: Scaffold(
                body:
                    //cart30(),
                    Stack(
                  children: <Widget>[
                    InkWell(
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      onTap: () {
                        FocusScope.of(context).requestFocus(FocusNode());
                      },
                      child: Column(
                        children: <Widget>[
                          getAppBarUI(),
                          mr30Cart(),
                          Expanded(child: mr30()),
                        ],
                      ),
                    ),
                    if (mr30rec.length != 0)
                      Padding(
                        padding: EdgeInsets.only(
                            bottom: 15,
                            right:
                                55), // Add margin of 15 pixels to bottom and 55 pixels to right

                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: badges.Badge(
                            badgeContent: Text('${mr30rec.length}'),
                            position:
                                badges.BadgePosition.topEnd(top: -5, end: 0),
                            child: ClipOval(
                              child: ElevatedButton(
                                onPressed: () {
                                  Get.toNamed('/ruregiscart');
                                },
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      Color.fromARGB(255, 119, 223, 128)),
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          30.0), // Set the border radius to half the button's width to make it circular
                                    ),
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(
                                      8.0), // Optional padding for the button's content
                                  child: FittedBox(
                                    fit: BoxFit.fitWidth,
                                    child: Icon(Icons.shopping_cart, size: 18),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    if (mr30rec.length == 0)
                      Padding(
                        padding: EdgeInsets.only(
                            bottom: 15,
                            right:
                                55), // Add margin of 15 pixels to bottom and 55 pixels to right

                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: badges.Badge(
                            badgeContent: Text('${mr30rec.length}'),
                            position:
                                badges.BadgePosition.topEnd(top: -5, end: 0),
                            child: ClipOval(
                              child: ElevatedButton(
                                onPressed: () {},
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      Color.fromARGB(255, 125, 125, 125)),
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          30.0), // Set the border radius to half the button's width to make it circular
                                    ),
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(
                                      8.0), // Optional padding for the button's content
                                  child: FittedBox(
                                    fit: BoxFit.fitWidth,
                                    child: Icon(Icons.shopping_cart, size: 18),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            )
          : Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            ),
    );
  }

  Widget mr30Cart1() {
    var mr30rec = context.watch<RuregionProvider>().mr30ruregionrec;
    var ruregionprov = context.watch<RuregionProvider>();

    void removeToCart(int index) {
      ruregionprov.removeRuregionPref(mr30rec[index].cOURSENO);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        ListView.builder(
          shrinkWrap: true,
          itemCount: mr30rec.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(
                  '${index + 1}.  ${mr30rec[index].cOURSENO} (${mr30rec[index].eXAMDATE} ${mr30rec[index].eXAMPERIOD})'),
              trailing: IconButton(
                icon: Icon(Icons.delete), // Icon for deletion
                onPressed: () {
                  removeToCart(
                      index); // Add functionality to delete the item here
                },
              ),
            );
          },
        ),
      ],
    );
  }

  Widget mr30Cart() {
    var mr30rec = context.watch<RuregionProvider>().mr30ruregionrec;
    var ruregionprov = context.watch<RuregionProvider>();

    void removeToCart(int index) {
      ruregionprov.removeRuregionPref(mr30rec[index].cOURSENO);
    }

    return mr30rec.length != 0
        ? Container(
            child: Expanded(
              child: ListView.builder(
                itemCount: mr30rec.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        gradient: LinearGradient(
                          colors: [
                            Color.fromARGB(255, 176, 205, 239), // สีเริ่มต้น
                            Color.fromARGB(255, 79, 150, 250), // สีสุดท้าย
                          ],
                          begin: Alignment.topCenter, // เริ่มสีจากด้านบน
                          end: Alignment.bottomCenter, // สิ้นสุดสีที่ด้านล่าง
                        ),
                      ),
                      child: Row(
                        children: [
                          Text(
                            ' ${mr30rec[index].cOURSENO} (${mr30rec[index].cREDIT}) \n ${mr30rec[index].eXAMDATE} (${mr30rec[index].eXAMPERIOD})',
                          ),
                          SizedBox(
                              width:
                                  10), // กำหนดระยะห่างระหว่าง Text และ IconButton
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              IconButton(
                                icon: Icon(Icons.close,
                                    color: Colors.black), // Icon for deletion
                                onPressed: () {
                                  removeToCart(
                                      index); // Add functionality to delete the item here
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          )
        : Center(
            child: Text('กรุณาเลือกวิชา ', style: TextStyle(fontSize: 18)),
          );
  }

  Widget cart301() {
    var mr30rec = context.watch<RuregionProvider>().mr30ruregionrec;
    var ruregionprov = context.watch<RuregionProvider>();

    return Container(
      width: double.infinity,
      height: double.infinity,
      child: CarouselSlider(
          carouselController: _carouselController,
          options: CarouselOptions(
              height: 500.0,
              aspectRatio: 16 / 9,
              viewportFraction: 0.90,
              enlargeCenterPage: true,
              pageSnapping: true,
              onPageChanged: (index, reason) {
                setState(() {
                  _current = index;
                });
              }),
          items: mr30rec.map((data) {
            return Builder(
              builder: (BuildContext context) {
                return GestureDetector(
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: _selectedIndex == data
                            ? Border.all(color: Colors.blue.shade500, width: 3)
                            : null,
                        boxShadow: _selectedIndex == data
                            ? [
                                BoxShadow(
                                    color: Colors.blue.shade100,
                                    blurRadius: 30,
                                    offset: const Offset(0, 10))
                              ]
                            : [
                                BoxShadow(
                                    color: Colors.grey.withOpacity(0.2),
                                    blurRadius: 20,
                                    offset: const Offset(0, 5))
                              ]),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                            height: 320,
                            margin: const EdgeInsets.only(top: 10),
                            clipBehavior: Clip.hardEdge,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            '${data.cOURSENO}',
                            style: const TextStyle(
                                fontSize: 24,
                                fontFamily: AppTheme.ruFontKanit,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: EdgeInsets.all(8),
                            child: Text(
                              '${data.cOURSENO}',
                              style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: AppTheme.ruFontKanit,
                                  color: Colors.grey.shade600),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }).toList()),
    );
  }

  Widget mr30() {
    var ruregionprov = context.watch<RuregionProvider>();
    var filter30 = context.watch<RuregionProvider>().filterMr30;
    var mr30fil = context.watch<RuregionProvider>().mr30filter;
    // print('mr30 filter ${mr30fil.results}');

    void addToCart(int index) {
      ruregionprov.addRuregionMR30(context,mr30fil.results![index]);
    }

    return ruregionprov.mr30ruregion.rEGISSTATUS == false
        ? Text('${ruregionprov.mr30ruregion.message}')
        : Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'ค้นหาวิชา',
                    prefixIcon: Icon(Icons.search),
                  ),
                  onChanged: (value) {
                    filter30(value);
                    // Implement your search logic here
                  },
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: mr30fil.results!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      elevation: 3,
                      margin: EdgeInsets.all(8),
                      child: ListTile(
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: '${mr30fil.results![index].cOURSENO}',
                                    style: TextStyle(
                                      fontWeight:
                                          FontWeight.bold, // Apply bold style
                                    ),
                                  ),
                                  TextSpan(
                                    text:
                                        ' (${mr30fil.results![index].cREDIT})',
                                    style: TextStyle(
                                      fontWeight:
                                          FontWeight.bold, // Apply italic style
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              '${mr30fil.results![index].cOURSENAME}',
                              style: TextStyle(
                                fontStyle: FontStyle.normal,
                                color: Colors
                                    .grey, // Apply grey color to course number
                                fontSize: 14, // Apply italic style
                              ),
                            ),
                            Text(
                              '${mr30fil.results![index].eXAMDATE} (${mr30fil.results![index].eXAMPERIOD})',
                              // Apply your desired style here for the whole text
                            ),
                          ],
                        ),
                        // Add button to add subject to cart
                        trailing: IconButton(
                          icon: Icon(Icons.add_shopping_cart),
                          onPressed: () {
                            addToCart(index);
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
  }

  Widget getAppBarUI() {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.background,
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              offset: const Offset(0, 2),
              blurRadius: 8.0),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top, left: 8, right: 8),
        child: Row(
          children: <Widget>[
            Container(
              alignment: Alignment.centerLeft,
              width: AppBar().preferredSize.height + 0,
              height: AppBar().preferredSize.height,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(32.0),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(Icons.arrow_back),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Rubar(textTitle: 'ค้นหาวิชา'),
            ),
            Container(
              width: AppBar().preferredSize.height + 40,
              height: AppBar().preferredSize.height,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
              ),
            )
          ],
        ),
      ),
    );
  }
}
