import 'package:flutter/material.dart';
import 'package:healthcare/Api/apis.dart';
import 'package:healthcare/models/date_model.dart';
import 'package:healthcare/models/userDataModel.dart';
import 'package:healthcare/recipientPage/recipient.dart';
import 'package:page_transition/page_transition.dart';

class DoctorAdder extends StatefulWidget {
  const DoctorAdder({super.key});

  @override
  State<DoctorAdder> createState() => _RecipientAdderState();
}

class _RecipientAdderState extends State<DoctorAdder> {
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  DateTime dateTime = DateTime.now();
  DateTime entryDatetime = DateTime.now();
  bool showDate = false;
  bool showTime = false;
  bool showDateTime = false;
  String doctorID = "";
  String roomId = "";
  String patientName = '';
  int age = 0;
  String condition = '';
  String recipientName = '';
  final _formkey = GlobalKey<FormState>();
  get items => null;

  get selectedValueSingleDialog => null;

  set selectedValueSingleDialog(selectedValueSingleDialog) {}

  Future<DateTime> _selectDate() async {
    final selected = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (selected != null && selected != selectedDate) {
      setState(() {
        selectedDate = selected;
      });
    }
    return selectedDate;
  }

  Future<TimeOfDay> _selectTime() async {
    final selected = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (selected != null && selected != selectedTime) {
      setState(() {
        selectedTime = selected;
      });
    }
    return selectedTime;
  }

  Future _selectDateTime() async {
    final date = await _selectDate();
    // if (date == null) return;

    final time = await _selectTime();

    // if (time == null) return;
    setState(() {
      dateTime = DateTime(
        date.year,
        date.month,
        date.day,
        time.hour,
        time.minute,
      );
    });
  }

  submitButton() async {
    if (_formkey.currentState!.validate()) {
      final UserDateModel userDate = UserDateModel(
          year: dateTime.year,
          month: dateTime.month,
          day: dateTime.day,
          hour: dateTime.hour,
          minute: dateTime.minute,
          sec: dateTime.second);
      final UserDataModel userData = UserDataModel(
          uid: Api.auth.currentUser!.uid,
          name: patientName,
          recipientName: recipientName,
          age: age,
          condition: condition,
          doctorId: doctorID,
          roomId: roomId,
          date: userDate.toMap());

      final data =
          await Api.firestore.collection('doctors').doc(patientName).get();
      if (data.exists) {
        print("data exists");
        await Api.firestore
            .collection('doctors')
            .doc(patientName)
            .update(userData.toMap());
      } else {
        Api.firestore
            .collection('doctors')
            .doc(patientName)
            .set(userData.toMap());
      }

      Navigator.of(context).pushAndRemoveUntil(
          PageTransition(
              child: HomeScreen(),
              type: PageTransitionType.leftToRightWithFade),
          (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Form(
          key: _formkey,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 40),
            child: Column(children: [
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                  onChanged: (value) {
                    patientName = value;
                  },
                  decoration: InputDecoration(
                    hintText: "Enter the Patient Name",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Patient Name is needed';
                    }
                    return null;
                  }),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                  onChanged: (value) {
                    age = int.parse(value);
                  },
                  decoration: InputDecoration(
                    hintText: "Enter the Patient Age",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Patient Age is needed';
                    }
                    return null;
                  }),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                  onChanged: (value) {
                    recipientName = value;
                  },
                  // initialValue: Api.firestore.collection('users').doc(value)
                  decoration: InputDecoration(
                    hintText: "Enter the Recipient Name",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Recipient Name is needed';
                    }
                    return null;
                  }),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: _selectDateTime,
                child: const Text("Select Date and Time"),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "Allocated Date : ${dateTime.day.toString().padLeft(2, '0')}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.year}",
                style: const TextStyle(
                    fontSize: 17,
                    color: Colors.deepPurple,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "Allocated Time : ${dateTime.hour.toString().padLeft(2, '0')} : ${dateTime.minute.toString().padLeft(2, '0')} : 00",
                style: const TextStyle(
                    fontSize: 17,
                    color: Colors.deepPurple,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                  onChanged: (value) {
                    doctorID = value;
                  },
                  // initialValue: Api.firestore.collection('users').doc(value)
                  decoration: InputDecoration(
                    hintText: "Enter the Doctor ID",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Doctor ID is needed';
                    }
                    return null;
                  }),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                  onChanged: (value) {
                    roomId = value;
                  },
                  // initialValue: Api.firestore.collection('users').doc(value)
                  decoration: InputDecoration(
                    hintText: "Enter the Room ID",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Room ID is needed';
                    }
                    return null;
                  }),
              const SizedBox(
                height: 20,
              ),
              Text(
                  style: const TextStyle(
                      fontSize: 17,
                      color: Colors.deepPurple,
                      fontWeight: FontWeight.bold),
                  "Entry Date : ${entryDatetime.day.toString().padLeft(2, '0')} - ${entryDatetime.month.toString().padLeft(2, '0')} - ${entryDatetime.year}"),
              const SizedBox(
                height: 20,
              ),
              Text(
                  style: const TextStyle(
                      fontSize: 17,
                      color: Colors.deepPurple,
                      fontWeight: FontWeight.bold),
                  "Entry Time for Patient : ${entryDatetime.hour.toString().padLeft(2, '0')} : ${entryDatetime.minute.toString().padLeft(2, '0')} : ${entryDatetime.second.toString().padLeft(2, '0')}"),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                onChanged: (value) {
                  doctorID = value;
                },
                // initialValue: Api.firestore.collection('users').doc(value)
                decoration: InputDecoration(
                  hintText: "Diseases (Optional)",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.deepPurple),
                  ),
                  onPressed: submitButton,
                  child: const Text(
                    "Submit!",
                    style: TextStyle(
                        fontSize: 17,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ))
            ]),
          ),
        ),
      ),
    );
  }
}
