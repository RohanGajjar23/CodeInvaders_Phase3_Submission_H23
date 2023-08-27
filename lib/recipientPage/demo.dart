import 'package:flutter/material.dart';
import 'package:healthcare/api/apis.dart';
import 'package:healthcare/auth/auth_page.dart';
import 'package:healthcare/models/date_model.dart';
import 'package:healthcare/models/userDataModel.dart';
import 'package:healthcare/recipientPage/recipient.dart';
import 'package:page_transition/page_transition.dart';

class HealthData {
  final String title;
  final String value;

  HealthData({required this.title, required this.value});
}

class HomePage extends StatelessWidget {
  const HomePage({super.key, required this.recipient});
  final UserDataModel recipient;

  @override
  Widget build(BuildContext context) {
    print(recipient.age);
    return MaterialApp(
      title: 'Healthcare User Page',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HealthUserPage(
        recipient: recipient,
      ),
    );
  }
}

class HealthUserPage extends StatefulWidget {
  const HealthUserPage({super.key, required this.recipient});
  final UserDataModel recipient;

  @override
  State<HealthUserPage> createState() => _HealthUserPageState();
}

class _HealthUserPageState extends State<HealthUserPage> {
  final List<HealthData> healthDataList = [
    // Add more health data here
  ];

  @override
  void initState() {
    super.initState();
    healthDataList.clear();
    healthDataList
        .add(HealthData(title: 'Patient Name', value: widget.recipient.name));
    healthDataList.add(HealthData(
        title: 'Recipient Name', value: widget.recipient.recipientName));
    healthDataList
        .add(HealthData(title: 'Age ', value: widget.recipient.age.toString()));
    healthDataList.add(HealthData(title: 'Weight', value: '65 kg'));
    healthDataList
        .add(HealthData(title: 'Condition', value: widget.recipient.condition));
    healthDataList.add(HealthData(
        title: 'Doctor ID', value: widget.recipient.doctorId.toString()));
    healthDataList.add(HealthData(
        title: 'Room ID', value: widget.recipient.roomId.toString()));
    healthDataList.add(HealthData(
        title: 'Appointement Date Time',
        value:
            "Date : ${UserDateModel.fromMap(widget.recipient.date).day.toString().padLeft(2, '0')} - ${UserDateModel.fromMap(widget.recipient.date).month.toString().padLeft(2, '0')} - ${UserDateModel.fromMap(widget.recipient.date).year.toString().padLeft(2, '0')} \nTime : ${UserDateModel.fromMap(widget.recipient.date).hour.toString().toString().padLeft(2, '0')} : ${UserDateModel.fromMap(widget.recipient.date).minute.toString().padLeft(2, '0')} : ${UserDateModel.fromMap(widget.recipient.date).sec.toString().padLeft(2, '0')}"));
  }
  // Recipient recipient;
  // init() {

  //   // print()

  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Healthcare User Page'),
        actions: [
          IconButton(
              onPressed: () {
                Api.auth.signOut();
                Navigator.of(context).pushAndRemoveUntil(
                    PageTransition(
                        child: AuthPage(),
                        type: PageTransitionType.leftToRightWithFade),
                    (route) => false);
              },
              icon: Icon(Icons.exit_to_app_outlined)),
        ],
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
                trailing: const Icon(Icons.arrow_back_rounded),
                onTap: () {
                  // Navigate to recipient details page
                  Navigator.of(context).pop();
                }),
            const Padding(
              padding: EdgeInsets.all(20.0),
              child: Text(
                'User Health Data',
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: healthDataList.length,
                itemBuilder: (context, index) {
                  final healthData = healthDataList[index];
                  return HealthDataCard(healthData: healthData);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: ElevatedButton(
                onPressed: () {
                  // Add functionality to navigate to health tracking page
                },
                child: const Text('Track Health Data'),
              ),
            ),
          ],
        ),
      ),
      drawer: const Drawer(),
      floatingActionButton:
          FloatingActionButton(onPressed: () {}, child: const Icon(Icons.add)),
    );
  }
}

class HealthDataCard extends StatelessWidget {
  final HealthData healthData;

  const HealthDataCard({required this.healthData});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              healthData.title,
              style:
                  const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5.0),
            Text(
              healthData.value,
              style: const TextStyle(fontSize: 16.0),
            ),
          ],
        ),
      ),
    );
  }
}
