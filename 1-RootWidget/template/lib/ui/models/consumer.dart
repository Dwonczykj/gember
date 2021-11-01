import 'green_project.dart';
import 'user.dart';

class Consumer extends User {
  final Set<GreenProject> priorities;

  Consumer(String uid, String? name, {required this.priorities})
      : super(uid: uid, name: name);

  static Consumer create({String? name}) {
    var user = User.create(name: name);
    return Consumer(user.uid, user.name, priorities: const <GreenProject>{});
  }

  factory Consumer.fromJson(Map<String, dynamic> json) =>
      Consumer(json['uid'], json['name'], priorities: json['priorities']);

  Map<String, dynamic> toJson() =>
      {'uid': uid, 'name': name, 'priorities': priorities};
}
