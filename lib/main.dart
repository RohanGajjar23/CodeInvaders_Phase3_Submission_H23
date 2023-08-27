import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healthcare/Api/apis.dart';
import 'package:healthcare/auth/auth_page.dart';
// import 'package:healthcare/AuthPage/auth_page.dart';

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
        home: StreamBuilder(
          stream: Api.auth.authStateChanges(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
                return const Scaffold(
                  backgroundColor: Color.fromARGB(255, 238, 238, 166),
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              case ConnectionState.active:
              case ConnectionState.done:
                return const AuthPage();
            }
          },
        ),
        theme: ThemeData(
          textTheme: GoogleFonts.comfortaaTextTheme(),
        ));
  }
}
