import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healthcare/AuthPage/auth_Page.dart';
import 'package:healthcare/AuthPage/widget_tree.dart';
import 'package:healthcare/appRoutes.dart';
import 'package:healthcare/recipientPage/recipient_HomePage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const FlutterApp());
}

class FlutterApp extends StatelessWidget {
  const FlutterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          "/": (context) => Auth_Page(),
          appRoutes.homeRoute: (context) => recipient_HomePage(),
          appRoutes.loginRoute: (context) => Auth_Page(),
        },
        // home: const widget_Tree(),
        theme: ThemeData(
          fontFamily: GoogleFonts.lato().fontFamily,
        ));
  }
}
