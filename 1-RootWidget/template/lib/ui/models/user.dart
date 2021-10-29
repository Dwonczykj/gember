import 'package:uuid/uuid.dart';

class User {
  final String uid;

  final String? name;

  User({required this.uid, this.name});

  static User create({String? name}) {
    return User(uid: Uuid().v4(), name: name);
  }

  factory User.fromJson(Map<String, dynamic> json) =>
      User(uid: json['uid'], name: json['name']);

  Map<String, dynamic> toJson() => {'uid': uid, 'name': name};
}
