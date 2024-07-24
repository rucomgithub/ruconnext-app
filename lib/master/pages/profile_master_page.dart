import 'package:provider/provider.dart';
import 'package:th.ac.ru.uSmart/app_theme.dart';
import 'package:th.ac.ru.uSmart/master/pages/master_image_loader.dart';
import 'package:th.ac.ru.uSmart/master/providers/master_provider.dart';
import 'package:th.ac.ru.uSmart/utils/faculty_color.dart';
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
        duration: const Duration(milliseconds: 600), vsync: this);
    super.initState();
    Provider.of<AuthenProvider>(context, listen: false).getProfile();
    Provider.of<MasterProvider>(context, listen: false).context = context;
    Provider.of<MasterProvider>(context, listen: false).refreshData();
  }

  Future<bool> getData() async {
    //await Provider.of<AuthenProvider>(context, listen: false).getProfile();
    await Future<dynamic>.delayed(const Duration(milliseconds: 600));
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
    return Scaffold(
      // appBar: AppBar(
      //   elevation: 0,
      //   backgroundColor: Colors.grey,
      //   title: const Text('บัตรนักศึกษาอิเล็กทรอนิกส์', style: TextStyle(
      //     color: Colors.black,
      //   ),),
      // ),
      backgroundColor:
          isLightMode == true ? AppTheme.white : AppTheme.nearlyBlack,
      body: FutureBuilder<bool>(
        future: getData(),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (!snapshot.hasData) {
            return const SizedBox();
          } else {
            var authen = context.read<AuthenProvider>();
            return Padding(
              padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  appBar(),
                  Expanded(
                    child: FutureBuilder<bool>(
                      future: getData(),
                      builder:
                          (BuildContext context, AsyncSnapshot<bool> snapshot) {
                        if (!snapshot.hasData) {
                          return const SizedBox();
                        } else {
                          return authen.profile.studentCode != null
                              ? Stack(
                                  fit: StackFit.expand,
                                  children: <Widget>[
                                    _renderBg(),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: <Widget>[
                                        _renderAppBar(context),
                                        Expanded(
                                          flex: 8,
                                          child: _renderContent(context),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Container(),
                                        ),
                                      ],
                                    )
                                  ],
                                )
                              : LoginPage();
                        }
                      },
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }

  _renderContent(BuildContext context) {
    var authen = context.read<AuthenProvider>();
    var studentProv = context.read<MasterProvider>();
    var region = studentProv.student.regionalnamethai!;
    region = region.replaceAll("จังหวัด", "");
    //region = region.replaceAll("สาขาวิทยบริการ", "");
    return Card(
      elevation: 0.0,
      margin:
          const EdgeInsets.only(left: 30.0, right: 30.0, top: 0.0, bottom: 0.0),
      color: const Color(0x00000000),
      child: FlipCard(
        direction: FlipDirection.HORIZONTAL,
        speed: 1000,
        onFlipDone: (status) {
          // print(status);
        },
        front: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/ID.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                        width: 65,
                        height: 65,
                        child: Padding(
                          padding: EdgeInsets.all(7.0),
                          child: ClipRRect(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10.0)),
                            child: Image.asset(
                                'assets/images/Logo_VecRu_Thai.png'),
                          ),
                        )),
                    Container(
                      height: 100,
                      width: 250,
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('มหาวิทยาลัยรามคำแหง',
                                style: TextStyle(
                                  fontFamily: AppTheme.ruFontKanit,
                                  fontSize: 20,
                                  color: AppTheme.ru_dark_blue,
                                )),
                            Text('Ramkhamheang University',
                                style: TextStyle(
                                  fontFamily: AppTheme.ruFontKanit,
                                  fontSize: 16,
                                  color: AppTheme.ru_yellow,
                                )),
                            Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(
                                    Icons.credit_card_sharp,
                                    size: 14,
                                    color: Colors.blue[900],
                                  ),
                                  SizedBox(width: 2),
                                  Text(
                                      'บัตรนักศึกษาอิเล็กทรอนิกส์ (' +
                                          authen.role +
                                          ')',
                                      style: TextStyle(
                                        fontFamily: AppTheme.ruFontKanit,
                                        fontSize: 10,
                                        color: AppTheme.ru_text_ocean_blue,
                                      )),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                  shape: BoxShape.rectangle,
                ),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(8.0, 16.0, 8.0, 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          Container(
                            width: 40,
                            height: 80,
                            decoration: BoxDecoration(
                              color: Colors.amber,
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
                                1, // Rotate 90 degrees (you can adjust the angle)
                            child: Container(
                              width: 150.0, // Set the desired height
                              child: Text(
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                region,
                                style: TextStyle(
                                  fontFamily: AppTheme.ruFontKanit,
                                  fontSize: 12,
                                  color: AppTheme.ru_yellow,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      MasterImageLoader(),
                      QrImage(
                        data: authen.profile.studentCode!,
                        version: QrVersions.auto,
                        size: 60,
                        gapless: false,
                      )
                    ],
                  ),
                ),
              ),
              Container(
                width: 350, // Set the desired width of the flag
                height: 160, // Set the desired height of the flag
                child: Column(
                  children: [
                    Expanded(
                      flex: 6,
                      child: Container(
                        child: Container(
                          width: 320,
                          child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(studentProv.student.namethai!,
                                      style: TextStyle(
                                        fontFamily: AppTheme.ruFontKanit,
                                        fontSize: 16,
                                        color: AppTheme.white,
                                      )),
                                  Text(studentProv.student.nameeng!,
                                      style: TextStyle(
                                        fontFamily: AppTheme.ruFontKanit,
                                        fontSize: 16,
                                        color: AppTheme.ru_yellow,
                                      ))
                                ],
                              )),
                        ),
                        color: Color.fromRGBO(
                            4, 3, 77, 0.8), // Set the color for the red stripes
                      ),
                    ),
                    Expanded(
                      flex: 6,
                      child: Container(
                        child: Container(
                          width: 320,
                          child: Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  // Text(studentProv.student.facultynamethai!,
                                  //     style: TextStyle(
                                  //       fontFamily: AppTheme.ruFontKanit,
                                  //       fontSize: 14,
                                  //       color: AppTheme.ru_dark_blue,
                                  //     )),
                                  Container(
                                    width: 250.0,
                                    child:
                                        Text(studentProv.student.majornamethai!,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontFamily: AppTheme.ruFontKanit,
                                              fontSize: 14,
                                              color: AppTheme.white,
                                            )),
                                  )
                                ],
                              )),
                        ),
                        color: Color.fromRGBO(255, 195, 0,
                            0.7), // Set the color for the blue stripes
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
                      height: 70,
                      width: 280,
                      child: Padding(
                        padding: EdgeInsets.all(5.0),
                        child: Image.network(
                            'http://beta-e-service.ru.ac.th:8001/misservice/generate/barcode.php?barcode=${authen.profile.studentCode!}&width=240&height=60'),
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
                size: 320,
                gapless: false,
                embeddedImage: AssetImage('assets/images/logo.png'),
                embeddedImageStyle: QrEmbeddedImageStyle(
                  size: Size(80, 80),
                ),
              ),
              Text('Back', style: Theme.of(context).textTheme.headline1),
              Text('Click here to flip front',
                  style: Theme.of(context).textTheme.bodyText1),
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
