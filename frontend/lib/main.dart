import 'dart:io';

import 'package:flutter/material.dart';
import 'package:frontend/Pages/UI/home_page.dart';
import 'package:frontend/Pages/navbar.dart';
// import 'package:frontend/Pages/home_page.dart';
import 'package:frontend/Pages/splash_page.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async{

  WidgetsFlutterBinding.ensureInitialized();
  // await GetStorage.init();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool hasValue = prefs.containsKey('user_email');

  HttpOverrides.global = new PostHttpOverrides();
  runApp(const MyApp());
}


class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {


  bool hasValue = false;

  @override
  void initState() {
    super.initState();
    _checkSharedPreferences();
  }

  Future<void> _checkSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      hasValue = prefs.containsKey('user_email');
    });
  }


  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      // home: HomePage(),
      home:hasValue?navbar(): splash(),
    );
  }
}
class PostHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}