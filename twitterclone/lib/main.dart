import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:twitterclone/bindings/mybindings.dart';
import 'package:twitterclone/pages/authpage.dart';
import 'package:twitterclone/pages/parrent.dart';

import 'package:twitterclone/services/firebaseservice.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  bool result = await isSignedIn();
  runApp(MyApp(isloggedin: result));
}

class MyApp extends StatelessWidget {
  final bool isloggedin;
  const MyApp({Key key, this.isloggedin = false}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      builder: (context, widget) => ResponsiveWrapper.builder(
        widget,
        maxWidth: 1200,
        minWidth: 480,
        defaultScale: true,
        breakpoints: [
          const ResponsiveBreakpoint.autoScale(480, name: MOBILE),
          const ResponsiveBreakpoint.autoScale(800, name: TABLET),
          const ResponsiveBreakpoint.autoScale(1000, name: DESKTOP),
          const ResponsiveBreakpoint.autoScale(2460, name: '4K'),
        ],
        background: Container(
          color: Colors.transparent,
        ),
      ),
      getPages: [
        GetPage(
          name: '/',
          page: () => const Home(),
        ),
        GetPage(
          name: "/auth",
          page: () => const AuthPage(),
        )
      ],
      initialBinding: MyBindings(),
      initialRoute: isloggedin ? '/' : '/auth',
    );
  }
}
