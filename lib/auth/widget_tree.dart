// import 'package:flutter/material.dart';
// import 'package:healthcare/AuthPage/auth_page.dart';
// import 'package:healthcare/appRoutes.dart';
// import 'package:healthcare/recipientPage/recipient.dart';

// class widget_Tree extends StatefulWidget {
//   const widget_Tree({super.key});

//   @override
//   State<widget_Tree> createState() => _widget_TreeState();
// }

// class _widget_TreeState extends State<widget_Tree> {
//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder(
//         stream: Auth().authStateChanges,
//         builder: (context, snapshot) {
//           if (snapshot.hasData) {
//             return HomeScreen();
//           } else {
//             return Auth_Page();
//           }
//         });
//   }
// }
