import 'package:th.ac.ru.uSmart/app_theme.dart';
import 'package:th.ac.ru.uSmart/model/mr30_model.dart';
import 'package:th.ac.ru.uSmart/providers/mr30_provider.dart';
import 'package:flutter/material.dart';
import 'package:th.ac.ru.uSmart/screens/today/today_item.dart';
import 'package:th.ac.ru.uSmart/screens/today/today_page.dart';
import 'package:th.ac.ru.uSmart/utils/constants.dart';
import 'package:th.ac.ru.uSmart/utils/widget_functions.dart';
import 'package:provider/provider.dart';

const CATEGORIES = [
  {"image": "calendar.png", "name": "ปฏิทิน"},
  {"image": "news3.png", "name": "ข่าวสาร"},
  {"image": "mr30.png", "name": "มร.30"},
  {"image": "aboutus4.png", "name": "ลงทะเบียน"},
  {"image": "calendar.png", "name": "เกรด"},
];

class TodayScreen extends StatefulWidget {
  const TodayScreen({Key? key}) : super(key: key);

  @override
  _TodayScreenState createState() => _TodayScreenState();
}

class _TodayScreenState extends State<TodayScreen> {
  final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    super.dispose();
    _focusNode.unfocus();
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          backgroundColor: Colors.grey,
          child: Icon(
            Icons.school_outlined,
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomAppBar(
          color: Colors.blueGrey,
          child: MenuBottom(),
        ),
        body: LayoutBuilder(
          builder: (context, constraints) {
            context.read<MR30Provider>().getHaveToday();
            var havetoday = context.watch<MR30Provider>().havetoday;
            return Container(
              child: Column(
                children: [
                  SearchCourse(textTheme),
                  Container(
                    width: constraints.maxWidth,
                    color: Colors.grey.shade200,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0, bottom: 10.0),
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Column(
                            children: [
                              addVerticalSpace(constraints.maxWidth * 0.35),
                              Row(
                                children: [
                                  Text(
                                    "วันนี้เรียนอะไร?",
                                    style: textTheme.headlineSmall,
                                  ),
                                  Expanded(
                                    child: Center(),
                                  ),
                                  Text(
                                    "รายการทั้งหมด > ",
                                    style: textTheme.titleSmall!
                                        .apply(color: COLOR_ORANGE),
                                  ),
                                  addHorizontalSpace(5),
                                ],
                              ),
                              addVerticalSpace(5),
                              HaveToday(havetoday, context, constraints),
                            ],
                          ),
                          Positioned(
                            top: -30,
                            left: 0,
                            child: Container(
                              width: constraints.maxWidth,
                              height: constraints.maxWidth * 0.35,
                              child: MainMenuList(constraints),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Padding MenuBottom() {
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.home,
                size: 28,
              )),
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.person,
                size: 28,
              )),
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.calendar_month,
                size: 28,
              )),
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.menu,
                size: 28,
              ))
        ],
      ),
    );
  }

  Expanded SearchCourse(TextTheme textTheme) {
    return Expanded(
        flex: 4,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Container(
              color: COLOR_GREY,
            ),
            Image.asset(
              "assets/images/vs.png",
              fit: BoxFit.contain,
              color: Colors.white.withValues(alpha: 0.2),
              colorBlendMode: BlendMode.modulate,
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                          width: 70,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                            color: Colors.white,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset("assets/images/avatar.png"),
                          )),
                      addHorizontalSpace(20),
                      Expanded(
                        flex: 7,
                        child: Text(
                          "วันนี้เรียนอะไร ?",
                          style:
                              textTheme.headlineSmall!.apply(color: Colors.white),
                        ),
                      )
                    ],
                  ),
                  TextField(
                    focusNode: _focusNode,
                    cursorColor: Colors.white,
                    cursorRadius: Radius.circular(10.0),
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                        hintText: "ค้นหาวิชาที่สนใจ",
                        hintStyle: TextStyle(color: Colors.white),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            borderSide: BorderSide.none),
                        prefixIcon: Icon(
                          Icons.search,
                          color: Colors.white,
                        ),
                        suffixIcon: Container(
                          height: 70,
                          width: 70,
                          decoration: BoxDecoration(
                              color: Colors.white24,
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(20.0),
                                  bottomRight: Radius.circular(20.0))),
                          child: Icon(
                            Icons.menu,
                            color: Colors.white,
                          ),
                        ),
                        filled: true,
                        fillColor: Colors.white24),
                  ),
                  addVerticalSpace(10),
                ],
              ),
            )
          ],
        ));
  }

  ListView MainMenuList(BoxConstraints constraints) {
    return ListView(
      scrollDirection: Axis.horizontal,
      physics: BouncingScrollPhysics(),
      children: CATEGORIES
          .map((category) => Container(
                margin: const EdgeInsets.only(right: 10.0),
                width: constraints.maxWidth * 0.25,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20.0)),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      Image.asset("assets/images/${category['image']}"),
                      addVerticalSpace(10),
                      Text("${category['name']}",
                          style: TextStyle(
                              fontFamily: AppTheme.ruFontKanit,
                              fontWeight: FontWeight.bold,
                              fontSize: 16))
                    ],
                  ),
                ),
              ))
          .toList(),
    );
  }

  SingleChildScrollView HaveToday(List<RECORD> havetoday, BuildContext context,
      BoxConstraints constraints) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: BouncingScrollPhysics(),
      child: Row(
        children: havetoday
            .map((data) => InkWell(
                  onTap: () {
                    _focusNode.unfocus();
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => TodayPage(todayData: data)));
                  },
                  child: TodayItem(
                    width: constraints.maxWidth * 0.50,
                    todayData: data,
                  ),
                ))
            .toList(),
      ),
    );
  }
}
