import 'dart:io';
// Notification
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:th.ac.ru.uSmart/affairs/affairs_home_screen.dart';
import 'package:th.ac.ru.uSmart/affairs/insurance/insurance_home_screen.dart';
import 'package:th.ac.ru.uSmart/affairs/rotcs/rotcs_home_screen.dart';
//
import 'package:th.ac.ru.uSmart/app_theme.dart';
import 'package:th.ac.ru.uSmart/help_screen.dart';
import 'package:th.ac.ru.uSmart/manual/card_help_screen.dart';
import 'package:th.ac.ru.uSmart/manual/home_help_screen.dart';
import 'package:th.ac.ru.uSmart/manual/mr30_help_screen.dart';
import 'package:th.ac.ru.uSmart/manual/regis_help_screen.dart';
import 'package:th.ac.ru.uSmart/pages/ru_map.dart';
import 'package:th.ac.ru.uSmart/pages/runewsdetail_page.dart';
import 'package:th.ac.ru.uSmart/providers/authenprovider.dart';
import 'package:th.ac.ru.uSmart/providers/insurance_provider.dart';
import 'package:th.ac.ru.uSmart/providers/mr30_provider.dart';
import 'package:th.ac.ru.uSmart/providers/region_enroll_provider.dart';
import 'package:th.ac.ru.uSmart/providers/register_provider.dart';
import 'package:th.ac.ru.uSmart/providers/rotcs_provider.dart';
import 'package:th.ac.ru.uSmart/providers/runewsprovider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:th.ac.ru.uSmart/providers/ruregion_mr30_provider.dart';
import 'package:th.ac.ru.uSmart/providers/ruregis_fee_provider.dart';
import 'package:th.ac.ru.uSmart/providers/ruregis_mr30_provider.dart';
import 'package:th.ac.ru.uSmart/providers/ruregis_provider.dart';
import 'package:th.ac.ru.uSmart/providers/sch_provider.dart';
import 'package:th.ac.ru.uSmart/providers/student_provider.dart';
import 'package:th.ac.ru.uSmart/rotcs/rotcs_extend_screen.dart';
import 'package:th.ac.ru.uSmart/rotcs/rotcs_register_screen.dart';
import 'package:th.ac.ru.uSmart/ruregis/mr30_home_screen.dart';
import 'package:th.ac.ru.uSmart/ruregis/ruregion_login.dart';
import 'package:th.ac.ru.uSmart/ruregis/ruregion_mr30.dart';
import 'package:th.ac.ru.uSmart/ruregis/ruregion_qr.dart';
import 'package:th.ac.ru.uSmart/ruregis/ruregion_receipt.dart';
import 'package:th.ac.ru.uSmart/ruregis/ruregis_cart.dart';
import 'package:th.ac.ru.uSmart/ruregis/ruregis_confirm.dart';
import 'package:th.ac.ru.uSmart/ruregis/ruregis_home_screen.dart';
import 'package:th.ac.ru.uSmart/ruregis/ruregis_search_mr30.dart';
import 'package:th.ac.ru.uSmart/scholarship/sch_home_screen.dart';
import 'package:th.ac.ru.uSmart/services/insuranceservice.dart';
import 'package:th.ac.ru.uSmart/services/rotcsservice.dart';
import 'package:th.ac.ru.uSmart/services/schservice.dart';
import 'package:th.ac.ru.uSmart/services/registerservice.dart';
import 'fitness_app/fitness_app_home_screen.dart';
import 'login_page.dart';
import 'manual/grade_help_screen.dart';
import 'manual/news_help_screen.dart';
import 'manual/schedule_help_screen.dart';
import 'navigation_home_screen.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'providers/grade_provider.dart';
import 'providers/schedule_provider.dart';

import 'package:th.ac.ru.uSmart/ondemand/ondemand_home_screen.dart';
import 'providers/ondemand_provider.dart';

String? token;

// Future<void>  main() async{
//   WidgetsFlutterBinding.ensureInitialized();

//   //check token มีจริงม้ย หรือหมดอายุหรือไม่
//   SharedPreferences prefs = await  SharedPreferences.getInstance();
//   token = prefs.getString('token');

//   await Firebase.initializeApp();
//   // Set the background messaging handler early on, as a named top-level function
//   FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

//   if (!kIsWeb) {
//     await setupFlutterNotifications();
//   }

//  HttpOverrides.global = new MyHttpOverrides();
//   runApp(const MyApp());
// }
class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // Set the background messaging handler early on, as a named top-level function
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await dotenv.load(fileName: ".env");
  if (!kIsWeb) {
    await setupFlutterNotifications();
  }
  //check token มีจริงม้ย หรือหมดอายุหรือไม่
  SharedPreferences prefs = await SharedPreferences.getInstance();
  token = prefs.getString('token');
  await SystemChrome.setPreferredOrientations(<DeviceOrientation>[
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]).then((_) => {HttpOverrides.global = MyHttpOverrides(), runApp(MyApp())});
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness:
          !kIsWeb && Platform.isAndroid ? Brightness.dark : Brightness.light,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarDividerColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));

    return MultiProvider(
        providers: [
          ChangeNotifierProvider<AuthenProvider>(
              create: (_) => AuthenProvider()),
          ChangeNotifierProvider<StudentProvider>(
              create: (_) => StudentProvider()),
          ChangeNotifierProvider<RunewsProvider>(
              create: (_) => RunewsProvider()),
          ChangeNotifierProvider<RotcsProvider>(
              create: (_) => RotcsProvider(service: RotcsService())),
          ChangeNotifierProvider<MR30Provider>(create: (_) => MR30Provider()),
          ChangeNotifierProvider<GradeProvider>(create: (_) => GradeProvider()),
          ChangeNotifierProvider<RegisterProvider>(
              create: (_) => RegisterProvider(service: RegisterService())),
          ChangeNotifierProvider<ScheduleProvider>(
              create: (_) => ScheduleProvider()),
          ChangeNotifierProvider<OndemandProvider>(
              create: (_) => OndemandProvider()),
          ChangeNotifierProvider<RuregisProvider>(
              create: (_) => RuregisProvider()),
          ChangeNotifierProvider<RUREGISMR30Provider>(
              create: (_) => RUREGISMR30Provider()),
          ChangeNotifierProvider<RuregisFeeProvider>(
              create: (_) => RuregisFeeProvider()),
          ChangeNotifierProvider<RuregionProvider>(
              create: (_) => RuregionProvider()),
          ChangeNotifierProvider<RegionEnrollProvider>(
              create: (_) => RegionEnrollProvider()),
          ChangeNotifierProvider<InsuranceProvider>(
              create: (_) => InsuranceProvider(service: InsuranceService())),
          ChangeNotifierProvider<SchProvider>(
              create: (_) => SchProvider(service: SchService()))
        ],
//       child: MaterialApp(
//         title: 'RU ConneXt',
//         debugShowCheckedModeBanner: false,
//         theme: ThemeData(
//           primarySwatch: Colors.blue,
//           textTheme: AppTheme.textTheme,
//           platform: TargetPlatform.iOS,
//         ),
//  //       home: NavigationHomeScreen(),
//          routes: {
//           '/': (context) => NavigationHomeScreen(),
//           '/home': (context) =>  HelpScreen(),
//           //'/login': (context) => Login(),
//           //'/home': (context) => MyHomePage(title: 'Login Demo'),
//         },
//       ),
        child: GetMaterialApp(
          title: 'RU CONNEXT',
          theme: ThemeData(
              primarySwatch: AppTheme.myColor,
              canvasColor: AppTheme.dark_grey,
              textTheme: const TextTheme(
                  bodyText1: TextStyle(
                      fontSize: 40,
                      color: Color.fromRGBO(84, 88, 89, 1.0),
                      fontFamily: AppTheme.ruFontKanit))),
          // home: const MyHomePage(),
          initialRoute: '/',
          getPages: [
            GetPage(name: '/', page: () => NavigationHomeScreen()),
            GetPage(name: '/home', page: () => HelpScreen()),
            GetPage(name: '/login', page: () => LoginPage()),
            GetPage(name: '/rumap', page: () => RuMap()),
            GetPage(name: '/runewsdetail', page: () => RunewsdetailPage()),
            GetPage(name: '/insurance', page: () => InsuranceHomeScreen()),
            GetPage(name: '/rotcs', page: () => RotcsHomeScreen()),
            GetPage(name: '/rotcsregister', page: () => RotcsRegisterScreen()),
            GetPage(name: '/rotcsextend', page: () => RotcsExtendScreen()),
            GetPage(
                name: '/fitness',
                page: () =>
                    token == null ? const LoginPage() : FitnessAppHomeScreen()),
            GetPage(name: '/ondemand', page: () => OndemandHomeScreen()),
            GetPage(name: '/homehelp', page: () => HomeHelpScreen()),
            GetPage(name: '/cardhelp', page: () => CardHelpScreen()),
            GetPage(name: '/gradehelp', page: () => GradeHelpScreen()),
            GetPage(name: '/newshelp', page: () => NewsHelpScreen()),
            GetPage(name: '/schedulehelp', page: () => ScheduleHelpScreen()),
            GetPage(name: '/mr30help', page: () => MR30HelpScreen()),
            GetPage(name: '/regishelp', page: () => RegisHelpScreen()),
            GetPage(name: '/rurgissearch', page: () => RuregisSearchScreen()),
            GetPage(name: '/rurgissearch2', page: () => Mr30Home2Screen()),
            GetPage(
                name: '/ruregisconfirm', page: () => RuRegisConfirmScreen()),
            GetPage(
                name: '/ruregionreceipt', page: () => RuregionReceiptScreen()),
            GetPage(name: '/ruregiscart', page: () => RuregisCartScreen()),
            GetPage(name: '/ruregionmr30', page: () => RuregionMR30Screen()),
            GetPage(name: '/ruregionqrcode', page: () => RuregionQRScreen()),
            GetPage(name: '/ruregionlogin', page: () => RuregionLoginPage()),
            GetPage(name: '/ruregionhome', page: () => RuRegisHomeScreen()),
            GetPage(name: '/affairs', page: () => AffairsHomeScreen()),
            GetPage(name: '/scholarship', page: () => SchHomeScreen()),
          ],
          debugShowCheckedModeBanner: false,
        ));
  }
}

class HexColor extends Color {
  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));

  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF' + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }
}

// Notification
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  //await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await setupFlutterNotifications();
  showFlutterNotification(message);
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  print('Handling a background message ${message.messageId}');
}

/// Create a [AndroidNotificationChannel] for heads up notifications
late AndroidNotificationChannel channel;

bool isFlutterLocalNotificationsInitialized = false;

Future<void> setupFlutterNotifications() async {
  if (isFlutterLocalNotificationsInitialized) {
    return;
  }
  channel = const AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description:
        'This channel is used for important notifications.', // description
    importance: Importance.high,
  );

  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  /// Create an Android Notification Channel.
  ///
  /// We use this channel in the `AndroidManifest.xml` file to override the
  /// default FCM channel to enable heads up notifications.
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  /// Update the iOS foreground notification presentation options to allow
  /// heads up notifications.
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  isFlutterLocalNotificationsInitialized = true;
}

void showFlutterNotification(RemoteMessage message) {
  RemoteNotification? notification = message.notification;
  AndroidNotification? android = message.notification?.android;
  if (notification != null && android != null && !kIsWeb) {
    flutterLocalNotificationsPlugin.show(
      notification.hashCode,
      notification.title,
      notification.body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          channel.id,
          channel.name,
          channelDescription: channel.description,
          // TODO add a proper drawable resource to android, for now using
          //      one that already exists in example app.
          icon: 'launch_background',
        ),
      ),
    );
  }
}

/// Initialize the [FlutterLocalNotificationsPlugin] package.
late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
