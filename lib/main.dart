import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ikss/gmap.dart';
import 'package:ikss/login.dart';
import 'package:ikss/register.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'constant.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Constants.prefs = await SharedPreferences.getInstance();

  runApp(MaterialApp(
    title: "Bookspot",
    home: Constants.prefs.getBool("loggedIn") == true ? Gmapp() : FirstPage(),
    debugShowCheckedModeBanner: false,
    routes: {
      "/logout": (context) => LoginPage(),
      "/home": (context) => Gmapp(),
    },
  ));
}
