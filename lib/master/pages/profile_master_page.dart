import 'package:provider/provider.dart';
import 'package:th.ac.ru.uSmart/app_theme.dart';
import 'package:th.ac.ru.uSmart/master/pages/master_image_loader.dart';
import 'package:th.ac.ru.uSmart/master/providers/master_provider.dart';
import 'package:th.ac.ru.uSmart/utils/faculty_color.dart';
import 'package:th.ac.ru.uSmart/widget/ru_wallpaper.dart';
import '../../login_page.dart';
import 'package:flutter/material.dart';
import '../../model/homelist.dart';
import 'package:flip_card/flip_card.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../../providers/authenprovider.dart';

class ProfileMasterPage extends StatefulWidget {
  const ProfileMasterPage({Key? key}) : super(key: key);

  @override
  _ProfileMasterPageState createState() => _ProfileMasterPageState();
}

class _ProfileMasterPageState extends State<ProfileMasterPage>
    with TickerProviderStateMixin {
  List<HomeList> homeList = HomeList.homeList;
  AnimationController? animationController;
  bool multiple = true;

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 300), vsync: this);
    super.initState();
    Provider.of<AuthenProvider>(context, listen: false).getProfile();
    Provider.of<MasterProvider>(context, listen: false).context = context;
    Provider.of<MasterProvider>(context, listen: false).refreshData();
  }

  Future<bool> getData() async {
    //await Provider.of<AuthenProvider>(context, listen: false).getProfile();
    await Future<dynamic>.delayed(const Duration(milliseconds: 300));
    return true;
  }

  _renderBg() {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/bg.png'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  _renderAppBar(context) {
    return Text('');
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isLightMode = brightness == Brightness.light;
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double baseFontSize = screenWidth * 0.05 > 18 ? 18 : screenWidth * 0.05;
    var roletext = context.watch<AuthenProvider>().roletext;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: AppTheme.nearlyWhite, // Change back arrow color to white
        ),
        title: Text(
          'บัตรนักศึกษา ${roletext}',
          style: TextStyle(
            fontSize: baseFontSize,
            fontFamily: AppTheme.ruFontKanit,
            color: AppTheme.nearlyWhite,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true, // Centers the title
        backgroundColor:
            AppTheme.ru_dark_blue, // Background color of the AppBar
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.help,
              color: AppTheme.nearlyWhite,
            ),
            onPressed: () {
              //Get.toNamed("/cardhelp");
            },
          ),
        ],
      ),
      backgroundColor: isLightMode
          ? AppTheme.nearlyWhite
          : AppTheme.nearlyBlack.withOpacity(0.2),
      body: FutureBuilder<bool>(
        future: getData(),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (!snapshot.hasData) {
            return const SizedBox();
          } else {
            var authen = context.read<AuthenProvider>();
            return Container(
              decoration: BoxDecoration(
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: Colors.white.withOpacity(0.2),
                      offset: const Offset(0, -2),
                      blurRadius: 8.0),
                ],
              ),
              child: Padding(
                padding:
                    EdgeInsets.only(top: MediaQuery.of(context).padding.top),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    //appBar(),
                    Expanded(
                      child: FutureBuilder<bool>(
                        future: getData(),
                        builder: (BuildContext context,
                            AsyncSnapshot<bool> snapshot) {
                          if (!snapshot.hasData) {
                            return const SizedBox();
                          } else {
                            return authen.profile.studentCode != null
                                ? Stack(
                                    fit: StackFit.expand,
                                    children: <Widget>[
                                      RuWallpaper(),
                                      _renderContent(context)
                                    ],
                                  )
                                : LoginPage();
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }

  _renderContent(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double baseFontSize =
        screenWidth < 600 ? screenWidth * 0.05 : screenWidth * 0.03;

    bool isLightMode = brightness == Brightness.light;

    var authen = context.read<AuthenProvider>();
    var studentProv = context.read<MasterProvider>();
    var region = studentProv.student.regionalnamethai!;
    region = region.replaceAll("จังหวัด", "");
    //region = region.replaceAll("สาขาวิทยบริการ", "");
    return Card(
      elevation: 0.0,
      margin: const EdgeInsets.only(
          left: 10.0, right: 10.0, top: 10.0, bottom: 10.0),
      color: const Color(0x00000000),
      child: FlipCard(
        direction: FlipDirection.HORIZONTAL,
        speed: 1000,
        onFlipDone: (status) {
          // print(status);
        },
        front: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/ID.png'),
              fit: BoxFit.cover,
              opacity: isLightMode ? 1.0 : 0.4,
            ),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: AppTheme.ru_yellow,
                  offset: Offset(1.1, 1.1),
                  blurRadius: 5.0),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                      width: screenWidth * 0.15,
                      height: screenHeight * 0.1,
                      child: Padding(
                        padding: EdgeInsets.all(7.0),
                        child: ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10.0)),
                          child:
                              Image.asset('assets/images/Logo_VecRu_Thai.png'),
                        ),
                      )),
                  Container(
                    width: screenWidth * 0.65,
                    height: screenHeight * 0.08,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('มหาวิทยาลัยรามคำแหง',
                            style: TextStyle(
                              fontFamily: AppTheme.ruFontKanit,
                              fontSize: baseFontSize - 6,
                              color: AppTheme.ru_dark_blue,
                            )),
                        Text('Ramkhamhaeng University',
                            style: TextStyle(
                              fontFamily: AppTheme.ruFontKanit,
                              fontSize: baseFontSize - 6,
                              color: AppTheme.ru_yellow,
                            )),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.credit_card_sharp,
                              size: baseFontSize - 8,
                              color: Colors.blue[900],
                            ),
                            SizedBox(width: 2),
                            Text(
                                'บัตรนักศึกษาอิเล็กทรอนิกส์ ${authen.roletext}',
                                style: TextStyle(
                                  fontFamily: AppTheme.ruFontKanit,
                                  fontSize: baseFontSize - 8,
                                  color: AppTheme.ru_text_ocean_blue,
                                )),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                  shape: BoxShape.rectangle,
                ),
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          Container(
                            height: screenHeight * 0.15,
                            width: screenWidth * 0.1,
                            decoration: BoxDecoration(
                              color: getFacultyMasterColor(
                                  studentProv.student.facultynamethai!),
                              shape: BoxShape.rectangle,
                              border: Border.all(
                                color: Colors.black26,
                                width: 1,
                              ),
                            ),
                          ),
                          SizedBox(height: 8),
                          RotatedBox(
                            quarterTurns:
                                1, // Rotate 270 degrees (or 3 quarter-turns) counterclockwise
                            child: Text(
                              region,
                              style: TextStyle(
                                fontFamily: AppTheme.ruFontKanit,
                                fontSize: baseFontSize - 8,
                                color: AppTheme.ru_yellow,
                              ),
                            ),
                          )
                        ],
                      ),
                      MasterImageLoader(),
                      QrImage(
                        data: authen.profile.studentCode!,
                        version: QrVersions.auto,
                        size: screenWidth * 0.15,
                        gapless: false,
                      )
                    ],
                  ),
                ),
              ),
              Container(
                height: screenHeight * 0.2,
                width: screenWidth * 0.6,
                child: Column(
                  children: [
                    Expanded(
                      flex: 4,
                      child: Container(
                        child: Container(
                          height: screenHeight * 0.1,
                          width: screenWidth * 0.6,
                          child: Container(
                            height: screenHeight * 0.05,
                            width: screenWidth * 0.6,
                            child: Padding(
                                padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('${studentProv.student.namethai!}',
                                        style: TextStyle(
                                          fontFamily: AppTheme.ruFontKanit,
                                          fontSize: baseFontSize - 8,
                                          color: AppTheme.white,
                                        )),
                                    Text(studentProv.student.nameeng!,
                                        style: TextStyle(
                                          fontFamily: AppTheme.ruFontKanit,
                                          fontSize: baseFontSize - 8,
                                          color: AppTheme.ru_yellow,
                                        ))
                                  ],
                                )),
                          ),
                        ),
                        color: AppTheme
                            .ru_dark_blue, // Set the color for the red stripes
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: Container(
                        height: screenHeight * 0.1,
                        width: screenWidth * 0.6,
                        child: Container(
                          height: screenHeight * 0.05,
                          width: screenWidth * 0.6,
                          child: Padding(
                              padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(studentProv.student.majornamethai!,
                                      style: TextStyle(
                                        fontFamily: AppTheme.ruFontKanit,
                                        fontSize: baseFontSize - 8,
                                        color: AppTheme.ru_dark_blue,
                                      )),
                                  // Text(studentProv.student.facultynamethai!,
                                  //     style: TextStyle(
                                  //       fontFamily: AppTheme.ruFontKanit,
                                  //       fontSize: baseFontSize - 8,
                                  //       color: AppTheme.white,
                                  //     ))
                                ],
                              )),
                        ),
                        color: AppTheme
                            .ru_yellow, // Set the color for the blue stripes
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0.0, 4.0, 0.0, 16.0),
                child: Column(
                  children: [
                    Container(
                      height: screenHeight * 0.1,
                      width: screenWidth * 0.6,
                      child: Padding(
                        padding: EdgeInsets.all(5.0),
                        child: Image.network(
                            'http://beta-e-service.ru.ac.th:8001/misservice/generate/barcode.php?barcode=${authen.profile.email!.substring(0, 10)}&width=${screenWidth * 0.6}&height=${screenHeight * 0.1}'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        back: Container(
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 113, 156, 156),
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              QrImage(
                data: authen.profile.studentCode!,
                version: QrVersions.auto,
                size: screenWidth * 0.75,
                gapless: false,
                embeddedImage: AssetImage('assets/images/Logo_VecRu_Thai.png'),
                embeddedImageStyle: QrEmbeddedImageStyle(
                  size: Size(50, 50),
                ),
              ),
              Text('Back', style: Theme.of(context).textTheme.displayMedium),
            ],
          ),
        ),
      ),
    );
  }

  Widget appBar() {
    var authen = context.read<AuthenProvider>();
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isLightMode = brightness == Brightness.light;
    return SizedBox(
      height: AppBar().preferredSize.height,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 8, left: 8),
            child: Container(
              width: AppBar().preferredSize.height - 8,
              height: AppBar().preferredSize.height - 8,
            ),
          ),
          Expanded(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(
                  '${'RU ConneXt for '}' + authen.role,
                  style: TextStyle(
                    fontSize: 22,
                    color: isLightMode ? AppTheme.darkText : AppTheme.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8, right: 8),
            child: Container(
              width: AppBar().preferredSize.height - 8,
              height: AppBar().preferredSize.height - 8,
              color: isLightMode ? Colors.white : AppTheme.nearlyBlack,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius:
                      BorderRadius.circular(AppBar().preferredSize.height),
                  onTap: () {
                    setState(() {
                      multiple = !multiple;
                    });
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class HomeListView extends StatelessWidget {
  const HomeListView(
      {Key? key,
      this.listData,
      this.callBack,
      this.animationController,
      this.animation})
      : super(key: key);

  final HomeList? listData;
  final VoidCallback? callBack;
  final AnimationController? animationController;
  final Animation<double>? animation;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController!,
      builder: (BuildContext context, Widget? child) {
        return FadeTransition(
          opacity: animation!,
          child: Transform(
            transform: Matrix4.translationValues(
                0.0, 50 * (1.0 - animation!.value), 0.0),
            child: AspectRatio(
              aspectRatio: 1.5,
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(4.0)),
                child: Stack(
                  alignment: AlignmentDirectional.center,
                  children: <Widget>[
                    Positioned.fill(
                      child: Image.asset(
                        listData!.imagePath,
                        fit: BoxFit.contain,
                      ),
                    ),
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        splashColor: Colors.grey.withOpacity(0.2),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(4.0)),
                        onTap: callBack,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
