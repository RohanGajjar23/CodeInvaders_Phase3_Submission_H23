import 'package:flutter/material.dart';
import 'package:healthcare/Api/apis.dart';
import 'package:healthcare/auth/auth_page.dart';
import 'package:healthcare/models/userDataModel.dart';
import 'package:healthcare/recipientPage/demo.dart';
import 'package:healthcare/recipientPage/recipient_page_creator.dart';
import 'package:page_transition/page_transition.dart';

// void main() {
//   runApp(HomeScreen());
// }

// class Recipient {
//   late String name;
//   late int age;
//   late String condition;
//   late int doctorid;
//   late int roomId;
//   late DateTime myTime;
//   late String recipientName;

//   Recipient(
//       {required this.recipientName,
//       required this.doctorid,
//       required this.roomId,
//       required this.myTime,
//       required this.name,
//       required this.age,
//       required this.condition});
// }

class DoctorHomeScreen extends StatefulWidget {
  @override
  State<DoctorHomeScreen> createState() => _HomeScreenState();
}

// class RecipientsList {
//   static List<Recipient> recipients = [
//     Recipient(
//         doctorid: "1",
//         roomId: "1",
//         myTime: DateTime.now(),
//         name: 'John Doe',
//         age: 35,
//         condition: 'Hypertension',
//         recipientName: "RR"),
//     // Recipient(name: 'Jane Smith', age: 45, condition: 'Diabetes'),
//     // Add more recipients here
//   ];
// }

class _HomeScreenState extends State<DoctorHomeScreen> {
  List<UserDataModel> userDataList = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Api.auth.signOut();
                Navigator.of(context).pushAndRemoveUntil(
                    PageTransition(
                        child: const AuthPage(),
                        type: PageTransitionType.leftToRightWithFade),
                    (route) => false);
              },
              icon: const Icon(Icons.exit_to_app_outlined)),
        ],
        title: const Text('Doctors Page'),
      ),
      body: StreamBuilder(
        stream: Api.firestore.collection('recipients').snapshots(),
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
              if (!snapshot.hasData) {
                return const Scaffold(
                  backgroundColor: Color.fromARGB(255, 238, 238, 166),
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
              final data = snapshot.data!.docs;
              userDataList = data
                  .map((e) => UserDataModel.fromMap(e.data()))
                  // .where((element) =>
                  //     element.doctorId == Api.auth.currentUser!.uid.toString())
                  .toList();
              return ListView.builder(
                itemCount: userDataList.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text(userDataList[index].name),
                    subtitle: Text('Age: ${userDataList[index].age}'),
                    trailing: Container(
                      width: 100,
                      child: const Row(
                        children: [
                          Icon(
                            Icons.done,
                            color: Colors.green,
                          ),
                          SizedBox(
                            width: 40,
                          ),
                          Icon(
                            Icons.cancel,
                            color: Colors.red,
                          ),
                        ],
                      ),
                    ),
                    onTap: () {
                      // Navigate to recipient details page
                      Navigator.of(context).push(PageTransition(
                          child: HomePage(recipient: userDataList[index]),
                          type: PageTransitionType.rightToLeftWithFade,
                          duration: const Duration(milliseconds: 750)));
                    },
                  );
                },
              );
          }
        },
      ),
      drawer: const Drawer(),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            print("Openeing Adder");
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const RecipientAdder()));
            // Api.auth.signOut();
            // Navigator.of(context).pushAndRemoveUntil(
            //     PageTransition(
            //         child: const AuthPage(),
            //         type: PageTransitionType.leftToRightWithFade),
            //     (route) => false);
          },
          child: const Icon(
            Icons.add,
          )),
    );
  }
}
