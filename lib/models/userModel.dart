class UserModel {
  late String uid;
  late String name;
  late String email;
  late String profession;

  UserModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.profession,
  });

  //from map
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      profession: map['profession'] ?? '',
    );
  }

  //to map

  Map<String, dynamic> toMap() {
    return {
      "uid": uid,
      "name": name,
      'email': email,
      'profession': profession,
    };
  }
}
