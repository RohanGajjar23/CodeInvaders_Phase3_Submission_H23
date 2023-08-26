class UserModel {
  late String uid;
  late String name;
  late int age;
  late int roomNo;
  late String assignedDoctor;

  UserModel({
    required this.uid,
    required this.name,
    required this.age,
    required this.roomNo,
    required this.assignedDoctor,
  });

  //from map
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] ?? '',
      name: map['name'] ?? '',
      age: map['age'] ?? 0,
      roomNo: map['roomNo'] ?? 0,
      assignedDoctor: map['assignedDoctor'] ?? '',
    );
  }

  //to map

  Map<String, dynamic> toMap() {
    return {
      "uid": uid,
      "name": name,
      'age': age,
      'roomNo': roomNo,
      'assignedDoctor': assignedDoctor
    };
  }
}
