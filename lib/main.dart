// ignore_for_file: prefer_interpolation_to_compose_strings

import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:gogreen_lite/Allproviders/api_provider.dart';
import 'package:gogreen_lite/Allproviders/main_provider.dart';
import 'package:gogreen_lite/Allproviders/v2_provider.dart';
import 'package:gogreen_lite/V2/home_screen_v2.dart';
import 'package:gogreen_lite/extraFunctions.dart';
import 'package:gogreen_lite/main_check.dart';
import 'package:gogreen_lite/main_home.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

import 'firebase_options.dart';

bool islogin = false;
bool isuser = false;
const AndroidNotificationChannel channel =
    AndroidNotificationChannel('test', 'test notification', playSound: true);
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

late VideoPlayerController _controller;

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  void checkLogin(ApiProvider apiProvider) async {
    String? value1 = await storage.read(key: 'user_details');
    storage.read(key: 'access_token').then((value) {
      if (value != null) {
        apiProvider.islogin = true;
        apiProvider.intialPreload = true;
        apiProvider.setContext(context);
        apiProvider.notify();
        apiProvider.getUserAddress(0);
        apiProvider.getUser(0);
        apiProvider.loadMilk();
        apiProvider.loadSubscription(0);
        apiProvider.getorders(more: false, count: 0);
        apiProvider.getorders(more: false, status: 'cancelled', count: 0);
        apiProvider.getorders(more: false, status: 'delivered', count: 0);
        islogin = true;
        if (value1 != null && value1 == 'true') {
          isuser = true;
        }
      }
    });
  }

  @override
  void initState() {
    final apiProvider = Provider.of<ApiProvider>(context, listen: false);
    checkLogin(apiProvider);
    _controller = VideoPlayerController.asset('assets/intro1.mp4')
      ..initialize().then((_) => setState(() {
            _controller.play();
            _controller.setVolume(0.0);
            _controller.setPlaybackSpeed(1.2);
          }));
    Timer(
        const Duration(milliseconds: 2800),
        () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    CheckPage(islogin: islogin, isuser: isuser))));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: double.maxFinite,
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment(0.65, -0.76),
              end: Alignment(-0.65, 0.76),
              colors: [Color(0xFFF9EEDB), Color(0xFFFEFEFC)])),
      child: _controller.value.isInitialized
          ? VideoPlayer(_controller)
          : const SizedBox(),
    );
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? androidNotification = message.notification?.android;
      if (notification != null && androidNotification != null) {
        flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(channel.id, channel.name,
                priority: Priority.max, icon: 'launch_background'),
          ),
        );
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? androidNotification = message.notification?.android;
      if (notification != null && androidNotification != null) {
        showDialog(
            context: context,
            builder: (_) => AlertDialog(
                title: Text(notification.title!),
                content: SingleChildScrollView(
                    child: Column(children: [Text(notification.body!)]))));
      }
    });
  }

  // void showNotificaton() {
  //   flutterLocalNotificationsPlugin.show(0, 'testing', 'test', NotificationDetails(android: AndroidNotificationDetails(channel.id, channel.name)));
  // }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => MainProvider()),
          ChangeNotifierProvider(create: (context) => ApiProvider()),
          ChangeNotifierProvider(create: (context) => Functions_v2()),
        ],
        child: GetMaterialApp(
            navigatorKey: navigatorKey,
            scaffoldMessengerKey: scaffoldMessengerKey,
            routes: {MainHome.route: ((context) => const MainHome())},
            debugShowCheckedModeBanner: false,
            title: 'Go Green',
            theme: ThemeData(
                textSelectionTheme: const TextSelectionThemeData(
                    selectionHandleColor: Colors.transparent),
                primaryColorLight: const Color.fromRGBO(255, 255, 255, 1),
                highlightColor: const Color.fromRGBO(111, 207, 151, 1),
                visualDensity: VisualDensity.adaptivePlatformDensity,
                hintColor: const Color.fromRGBO(232, 250, 240, 1),
                cardColor: const Color.fromRGBO(191, 187, 187, 1),
                fontFamily: 'Poppins',
                unselectedWidgetColor: Colors.transparent,
                scaffoldBackgroundColor:
                    const Color.fromARGB(255, 255, 255, 255),
                colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue)
                    .copyWith(
                        secondary: const Color.fromRGBO(109, 107, 110, 1))),
            home: const HomeScreenV2()));
    // SplashScreen()
    // home: const Beta()));
  }
}
