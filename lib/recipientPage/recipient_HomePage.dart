import 'package:flutter/material.dart';
import 'package:healthcare/AuthPage/auth_Page.dart';

class recipient_HomePage extends StatefulWidget {
  const recipient_HomePage({super.key});

  @override
  State<recipient_HomePage> createState() => _recipient_HomePageState();
}

Future<void> signOut() async {
  await Auth().signOut();
}

class _recipient_HomePageState extends State<recipient_HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Column(
          children: [
            InkWell(
              onTap: () {
                signOut();
              },
              child: Container(
                width: 200,
                height: 50,
                color: Colors.cyanAccent,
              ),
            )
          ],
        ),
      ),
    );
  }
}
