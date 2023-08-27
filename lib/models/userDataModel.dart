// ignore_for_file: file_names

import 'package:healthcare/models/date_model.dart';

class UserDataModel {
  late String uid;
  late String name;
  late String recipientName;
  late int age;
  late String condition;
  late String doctorId;
  late String roomId;
  late Map<String, dynamic> date;

  UserDataModel({
    required this.uid,
    required this.name,
    required this.recipientName,
    required this.age,
    required this.condition,
    required this.doctorId,
    required this.roomId,
    required this.date,
  });

  //from map
  factory UserDataModel.fromMap(Map<String, dynamic> map) {
    final dateTime = DateTime.now();
    return UserDataModel(
      uid: map['uid'] ?? '',
      name: map['name'] ?? 'John Doe',
      recipientName: map['recipientName'] ?? '',
      age: map['age'] ?? 35,
      condition: map['condition'] ?? 'HyperTension',
      doctorId: map['doctorId'] ?? '1',
      roomId: map['roomId'] ?? '1',
      date: map['date'] ??
          UserDateModel(
            year: dateTime.year,
            month: dateTime.month,
            day: dateTime.day,
            hour: dateTime.hour,
            minute: dateTime.minute,
            sec: dateTime.second,
          ).toMap(),
    );
  }

  //to map

  Map<String, dynamic> toMap() {
    return {
      "uid": uid,
      "name": name,
      "recipientName": recipientName,
      "age": age,
      "condition": condition,
      "doctorId": doctorId,
      "roomId": roomId,
      "date": date,
    };
  }
}
