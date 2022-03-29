import 'package:finalville/screen/Home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'screen/splash.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp( );
  runApp(const GetMaterialApp(
    home: Splash(),
    debugShowCheckedModeBanner: false,
  ));
}

