import 'package:emart_seller/const/const.dart';
import 'package:emart_seller/firebase_options.dart';
import 'package:emart_seller/views/Homescreen/home.dart';
import 'package:emart_seller/views/auth_screen/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var isLoggedin = false;

  void initState() {
    super.initState();
    checkUser();
  }

  checkUser() async {
    auth.authStateChanges().listen((User? user) {
      if (user == null && mounted) {
        isLoggedin = false;
      } else {
        isLoggedin = true;
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: appname,
      home: isLoggedin ? Home() : LoginScreen(),
      theme: ThemeData(
          appBarTheme: const AppBarTheme(
        color: purpleColor,
        elevation: 0,
      )),
    );
  }
}
