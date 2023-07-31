// ignore_for_file: library_private_types_in_public_api

import 'dart:async';

import 'package:buma/application/services/app_navigation_service.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import '../../../infrastructure/database/shared_prefs.dart';

class SplashScreen extends StatefulWidget {
  dynamic item;

  SplashScreen({Key? key}) : super(key: key);
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final _sharedPrefs = SharedPrefs();
  // dynamic iconbgColor;
  // dynamic iconLogo;
  dynamic delay;
  // dynamic bytes;
  // dynamic imageData;
  // dynamic imageBytes;
  dynamic isAgen;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async{
      
      Timer(Duration(milliseconds: delay ?? 3000),()async{
       AppNavigatorService.pushReplacementNamed('/');
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: HexColor("#FFFFFF"),
      body: Container(
        decoration: const BoxDecoration(
          // image: DecorationImage(
          //   image: AssetImage("assets/images/buma.png"),
          //   fit: BoxFit.cover,
          // ),
        ),
        child: Center(
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/buma.png"),
                  fit: BoxFit.contain,
                ),
              ),
            )),
      ),
    );
  }
}


