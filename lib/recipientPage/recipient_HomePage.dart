// import 'package:flutter/material.dart';
// import 'package:healthcare/AuthPage/auth_page.dart';

// class recipient_HomePage extends StatefulWidget {
//   const recipient_HomePage({super.key});

//   @override
//   State<recipient_HomePage> createState() => _recipient_HomePageState();
// }

// Future<void> signOut(BuildContext context) async {
//   await Auth().signOut(context);
// }

// class _recipient_HomePageState extends State<recipient_HomePage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       body: Container(
//         child: Column(
//           children: [
//             InkWell(
//               onTap: () {
//                 DatabaseClass().databaseReference.child("Rohan").set({
//                   "Rohan": 1,
//                 });
//                 signOut(context);
//               },
//               child: Container(
//                 width: 200,
//                 height: 50,
//                 color: Colors.cyanAccent,
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
