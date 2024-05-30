import 'package:provider/provider.dart';
import 'package:th.ac.ru.uSmart/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:th.ac.ru.uSmart/model/profile.dart';
import 'package:th.ac.ru.uSmart/pages/ImageLoader.dart';
import 'package:th.ac.ru.uSmart/providers/authenprovider.dart';

class HomeDrawer extends StatefulWidget {
  const HomeDrawer(
      {Key? key,
      this.screenIndex,
      this.iconAnimationController,
      this.callBackIndex})
      : super(key: key);

  final AnimationController? iconAnimationController;
  final DrawerIndex? screenIndex;
  final Function(DrawerIndex)? callBackIndex;

  @override
  _HomeDrawerState createState() => _HomeDrawerState();
}

class _HomeDrawerState extends State<HomeDrawer> {
  List<DrawerList>? drawerList;
  String? profile;
  Profile p = Profile();
  @override
  void initState() {
    setDrawerListArray();
    super.initState();
  }

  Future<bool> getData() async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // profile = prefs.getString('profile');

    // p = Profile.fromJson(json.decode(profile!));
    // print(p.photoUrl);
    await Future<dynamic>.delayed(const Duration(milliseconds: 0));
    return true;
  }

  void setDrawerListArray() {
    drawerList = <DrawerList>[
      DrawerList(
        index: DrawerIndex.HOME,
        labelName: 'หน้าแรก',
        icon: Icon(Icons.home),
      ),
      DrawerList(
        index: DrawerIndex.Help,
        labelName: 'ช่วยเหลือ',
        isAssetsImage: true,
        imageName: 'assets/images/supportIcon.png',
      ),
      DrawerList(
        index: DrawerIndex.Manual,
        labelName: 'แนะนำการใช้งาน',
        icon: Icon(Icons.book),
      ),
      // DrawerList(
      //   index: DrawerIndex.Invite,
      //   labelName: 'Invite Friend',
      //   icon: Icon(Icons.group),
      // ),
      // DrawerList(
      //   index: DrawerIndex.Share,
      //   labelName: 'Rate the app',
      //   icon: Icon(Icons.share),
      // ),
      // DrawerList(
      //   index: DrawerIndex.AboutRam,
      //   labelName: 'เกี่ยวกับ ม.ราม',
      //   icon: Icon(Icons.info),
      // ),
      DrawerList(
        labelName: '1.1.1',
        icon: Icon(Icons.update),
      ),
      // DrawerList(
      //   index: DrawerIndex.Register,
      //   labelName: 'ลงทะเบียนเรียน',
      //   icon: Icon(Icons.app_registration),
      // ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    var authen = context.watch<AuthenProvider>();
    bool isLightMode = brightness == Brightness.light;
    return Scaffold(
      backgroundColor: AppTheme.notWhite,
      body: FutureBuilder<bool>(
        future: getData(),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (!snapshot.hasData) {
            return const SizedBox();
          } else {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(top: 40.0),
                  child: Container(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        AnimatedBuilder(
                          animation: widget.iconAnimationController!,
                          builder: (BuildContext context, Widget? child) {
                            return ScaleTransition(
                              scale: AlwaysStoppedAnimation<double>(1.0 -
                                  (widget.iconAnimationController!.value) *
                                      0.2),
                              child: RotationTransition(
                                turns: AlwaysStoppedAnimation<double>(
                                    Tween<double>(begin: 0.0, end: 48.0)
                                            .animate(CurvedAnimation(
                                                parent: widget
                                                    .iconAnimationController!,
                                                curve: Curves.fastOutSlowIn))
                                            .value /
                                        360),
                                child: authen.profile.accessToken != null
                                    ? LogoLoginSuccess(authen: authen)
                                    : LogoNotLogin(),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                Divider(
                  height: 1,
                  color: Color.fromARGB(255, 227, 211, 107),
                ),
                Expanded(
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.all(0.0),
                    itemCount: drawerList?.length,
                    itemBuilder: (BuildContext context, int index) {
                      return inkwell(drawerList![index]);
                    },
                  ),
                ),
                Divider(
                  height: 1,
                  color: Color.fromARGB(255, 227, 211, 107),
                ),
                authen.profile.accessToken != null
                    ? Column(
                        children: <Widget>[
                          ListTile(
                            title: Text(
                              'Sign Out',
                              style: TextStyle(
                                fontFamily: AppTheme.ruFontKanit,
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                                color: AppTheme.notWhite,
                              ),
                              textAlign: TextAlign.left,
                            ),
                            trailing: Icon(
                              Icons.power_settings_new,
                              color: Colors.red,
                            ),
                            onTap: () {
                              onTapped();
                            },
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).padding.bottom,
                          )
                        ],
                      )
                    : Column(
                        children: <Widget>[
                          ListTile(
                            title: Text(
                              'Sign In',
                              style: TextStyle(
                                fontFamily: AppTheme.ruFontKanit,
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                                color: isLightMode
                                    ? AppTheme.nearlyBlack
                                    : AppTheme.notWhite,
                              ),
                              textAlign: TextAlign.left,
                            ),
                            trailing: Icon(
                              Icons.login,
                              color: Color.fromARGB(255, 54, 244, 162),
                            ),
                            onTap: () {
                              Get.toNamed('/login');
                            },
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).padding.bottom,
                          )
                        ],
                      ),
              ],
            );
          }
        },
      ),
    );
  }

  Future<void> onTapped() async {
    var authen = Provider.of<AuthenProvider>(context, listen: false);
    authen.logout();
  }

  Widget inkwell(DrawerList listData) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        splashColor: Color.fromARGB(255, 255, 255, 255).withOpacity(0.8),
        highlightColor: Color.fromARGB(0, 141, 15, 15),
        onTap: () {
          navigationtoScreen(listData.index!);
        },
        child: Stack(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
              child: Row(
                children: <Widget>[
                  Container(
                    width: 6.0,
                    height: 46.0,
                    // decoration: BoxDecoration(
                    //   color: widget.screenIndex == listData.index
                    //       ? Colors.blue
                    //       : Colors.transparent,
                    //   borderRadius: new BorderRadius.only(
                    //     topLeft: Radius.circular(0),
                    //     topRight: Radius.circular(16),
                    //     bottomLeft: Radius.circular(0),
                    //     bottomRight: Radius.circular(16),
                    //   ),
                    // ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(4.0),
                  ),
                  listData.isAssetsImage
                      ? Container(
                          width: 24,
                          height: 24,
                          child: Image.asset(
                            listData.imageName,
                            color: widget.screenIndex == listData.index
                                ? Color.fromARGB(255, 179, 178, 178)
                                : Color.fromARGB(255, 87, 85, 85),
                          ),
                        )
                      : Icon(
                          listData.icon?.icon,
                          color: widget.screenIndex == listData.index
                              ? Color.fromARGB(255, 179, 178, 178)
                              : Color.fromARGB(255, 87, 85, 85),
                        ),
                  const Padding(
                    padding: EdgeInsets.all(4.0),
                  ),
                  Text(
                    listData.labelName,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      color: widget.screenIndex == listData.index
                          ? Color.fromARGB(255, 179, 178, 178)
                          : Color.fromARGB(255, 87, 85, 85),
                    ),
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
            ),
            widget.screenIndex == listData.index
                ? AnimatedBuilder(
                    animation: widget.iconAnimationController!,
                    builder: (BuildContext context, Widget? child) {
                      return Transform(
                        transform: Matrix4.translationValues(
                            (MediaQuery.of(context).size.width * 0.75 - 64) *
                                (1.0 -
                                    widget.iconAnimationController!.value -
                                    1.0),
                            0.0,
                            0.0),
                        child: Padding(
                          padding: EdgeInsets.only(top: 8, bottom: 8),
                          child: Container(
                            width:
                                MediaQuery.of(context).size.width * 0.75 - 64,
                            height: 46,
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 205, 205, 205)
                                  .withOpacity(0.5),
                              borderRadius: new BorderRadius.only(
                                topLeft: Radius.circular(0),
                                topRight: Radius.circular(28),
                                bottomLeft: Radius.circular(0),
                                bottomRight: Radius.circular(28),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  )
                : const SizedBox()
          ],
        ),
      ),
    );
  }

  Future<void> navigationtoScreen(DrawerIndex indexScreen) async {
    widget.callBackIndex!(indexScreen);
  }
}

class LogoLoginSuccess extends StatelessWidget {
  const LogoLoginSuccess({
    super.key,
    required this.authen,
  });

  final AuthenProvider authen;

  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isLightMode = brightness == Brightness.light;
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Color.fromARGB(255, 227, 211, 107),
            ),
            height: 175,
            width: 175,
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(50.0)),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 170,
                    height: 170,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color.fromARGB(255, 2, 40, 104),
                    ),
                  ),
                  ClipOval(
                    child: ImageLoader(),
                  ),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8, left: 4),
          child: Text(
            authen.profile.displayName!,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: AppTheme.notWhite,
              fontSize: 18,
            ),
          ),
        ),
      ],
    );
  }
}

class LogoNotLogin extends StatelessWidget {
  const LogoNotLogin({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Color.fromARGB(255, 227, 211, 107),
        ),
        height: 175,
        width: 175,
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(50.0)),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 170,
                height: 170,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color.fromARGB(255, 2, 40, 104),
                ),
              ),
              ClipOval(
                child: Icon(
                  Icons.person,
                  size: 150,
                  color: Color.fromARGB(255, 227, 211, 107),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

enum DrawerIndex {
  HOME,
  FeedBack,
  Help,
  Share,
  About,
  Invite,
  Testing,
  Register,
  AboutRam,
  Manual,
}

class DrawerList {
  DrawerList({
    this.isAssetsImage = false,
    this.labelName = '',
    this.icon,
    this.index,
    this.imageName = '',
  });

  String labelName;
  Icon? icon;
  bool isAssetsImage;
  String imageName;
  DrawerIndex? index;
}
