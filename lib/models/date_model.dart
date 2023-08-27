class UserDateModel {
  late int year;
  late int month;
  late int day;
  late int hour;
  late int minute;
  late int sec;

  UserDateModel({
    required this.year,
    required this.month,
    required this.day,
    required this.hour,
    required this.minute,
    required this.sec,
  });

  //from map
  factory UserDateModel.fromMap(Map<String, dynamic> map) {
    final dateTime = DateTime.now();
    return UserDateModel(
        year: map['year'] ?? dateTime.year,
        month: map['month'] ?? dateTime.month,
        day: map['day'] ?? dateTime.day,
        hour: map['hour'] ?? dateTime.hour,
        minute: map['minute'] ?? dateTime.minute,
        sec: map['sec'] ?? dateTime.second);
  }

  //to map

  Map<String, dynamic> toMap() {
    return {
      "year": year,
      "month": month,
      "day": day,
      "hour": hour,
      "minute": minute,
      "sec": sec
    };
  }
}
