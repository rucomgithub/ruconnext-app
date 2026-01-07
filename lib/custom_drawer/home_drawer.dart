import 'package:provider/provider.dart';
import 'package:th.ac.ru.uSmart/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:th.ac.ru.uSmart/master/pages/master_Image_graduate.dart';
import 'package:th.ac.ru.uSmart/pages/ImageLoader.dart';
import 'package:th.ac.ru.uSmart/providers/authenprovider.dart';
import 'package:th.ac.ru.uSmart/store/authen.dart';

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
  String? accessToken;
  @override
  void initState() {
    setDrawerListArray();
    super.initState();
  }

  Future<bool> getData() async {
    final token = await AuthenStorage.getAccessToken();
    setState(() {
      accessToken = token;
    });
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
        labelName: '2.1.0',
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
      backgroundColor: AppTheme.nearlyWhite,
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
                // Header with gradient background
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(top: 40.0, bottom: 20.0),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        AppTheme.ru_dark_blue,
                        AppTheme.ru_dark_blue.withValues(alpha: 0.8),
                      ],
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      AnimatedBuilder(
                        animation: widget.iconAnimationController!,
                        builder: (BuildContext context, Widget? child) {
                          return ScaleTransition(
                            scale: AlwaysStoppedAnimation<double>(1.0 -
                                (widget.iconAnimationController!.value) * 0.2),
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
                                    ? LogoLoginSuccess(
                                        displayName:
                                            authen.profile.displayName!,
                                        role: authen.role,
                                      )
                                    : LogoNotLogin()),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    color: AppTheme.nearlyWhite,
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      itemCount: drawerList?.length,
                      itemBuilder: (BuildContext context, int index) {
                        return inkwell(drawerList![index]);
                      },
                    ),
                  ),
                ),
                Divider(
                  height: 1,
                  color: AppTheme.nearlyWhite,
                ),
                authen.profile.accessToken != null
                    ? Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              const Color(0xFFFF6B6B),
                              const Color(0xFFFF8E53),
                            ],
                          ),
                        ),
                        child: Column(
                          children: <Widget>[
                            Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () {
                                  onTapped();
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0,
                                    vertical: 14.0,
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          color: Colors.white
                                              .withValues(alpha: 0.2),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Icon(
                                          Icons.power_settings_new,
                                          color: Colors.white,
                                          size: 20,
                                        ),
                                      ),
                                      const SizedBox(width: 16),
                                      Expanded(
                                        child: Text(
                                          'Sign Out',
                                          style: TextStyle(
                                            fontFamily: AppTheme.ruFontKanit,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16,
                                            color: Colors.white,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      Icon(
                                        Icons.arrow_forward_ios,
                                        color: Colors.white,
                                        size: 16,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).padding.bottom,
                            )
                          ],
                        ),
                      )
                    : Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              AppTheme.ru_yellow,
                              AppTheme.ru_yellow.withValues(alpha: 0.8),
                            ],
                          ),
                        ),
                        child: Column(
                          children: <Widget>[
                            Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () {
                                  Get.toNamed('/login');
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0,
                                    vertical: 14.0,
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          color: AppTheme.ru_dark_blue,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Icon(
                                          Icons.login,
                                          color: Colors.white,
                                          size: 20,
                                        ),
                                      ),
                                      const SizedBox(width: 16),
                                      Expanded(
                                        child: Text(
                                          'Sign In',
                                          style: TextStyle(
                                            fontFamily: AppTheme.ruFontKanit,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16,
                                            color: AppTheme.ru_dark_blue,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      Icon(
                                        Icons.arrow_forward_ios,
                                        color: AppTheme.ru_dark_blue,
                                        size: 16,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).padding.bottom,
                            )
                          ],
                        ),
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
    final bool isSelected = widget.screenIndex == listData.index;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16.0),
          splashColor: AppTheme.ru_dark_blue.withValues(alpha: 0.1),
          highlightColor: AppTheme.ru_dark_blue.withValues(alpha: 0.05),
          onTap: () {
            navigationtoScreen(listData.index!);
          },
          child: Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
            decoration: BoxDecoration(
              color: isSelected
                  ? AppTheme.ru_dark_blue.withValues(alpha: 0.1)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(16.0),
              border: isSelected
                  ? Border.all(
                      color: AppTheme.ru_dark_blue.withValues(alpha: 0.2),
                      width: 1,
                    )
                  : null,
            ),
            child: Row(
              children: <Widget>[
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppTheme.ru_dark_blue
                        : AppTheme.ru_dark_blue.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: listData.isAssetsImage
                      ? Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset(
                            listData.imageName,
                            color: isSelected
                                ? Colors.white
                                : AppTheme.ru_dark_blue,
                          ),
                        )
                      : Icon(
                          listData.icon?.icon,
                          color:
                              isSelected ? Colors.white : AppTheme.ru_dark_blue,
                          size: 20,
                        ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    listData.labelName,
                    style: TextStyle(
                      fontFamily: AppTheme.ruFontKanit,
                      fontWeight:
                          isSelected ? FontWeight.w600 : FontWeight.w500,
                      fontSize: 15,
                      color: isSelected
                          ? AppTheme.ru_dark_blue
                          : AppTheme.ru_dark_blue.withValues(alpha: 0.7),
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                if (isSelected)
                  Container(
                    width: 4,
                    height: 24,
                    decoration: BoxDecoration(
                      color: AppTheme.ru_dark_blue,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> navigationtoScreen(DrawerIndex indexScreen) async {
    widget.callBackIndex!(indexScreen);
  }
}

class LogoLoginSuccess extends StatelessWidget {
  const LogoLoginSuccess(
      {super.key, required this.role, required this.displayName});

  final String role;
  final String displayName;

  @override
  Widget build(BuildContext context) {
    //var authen = context.watch<AuthenProvider>();
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(10.0)),
          child: Container(
            child: Stack(
              children: [
                ClipOval(
                  child: role == "Bachelor"
                      ? ImageLoader()
                      : MasterImageGraduate(),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8, left: 4),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Text(
              displayName,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.white,
                fontSize: 18,
                shadows: [
                  Shadow(
                    color: Colors.black.withValues(alpha: 0.3),
                    offset: const Offset(0, 2),
                    blurRadius: 4,
                  ),
                ],
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
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
