import 'package:equatable/equatable.dart';
import 'package:template/ui/models/models.dart';
import 'package:uuid/uuid.dart';

class GemberUser extends Equatable {
  final String uid;

  final String? name;

  final String email;

  late String? profile_picture;

  late String? cover_picture;

  late List<String> priorities;

  GemberUser({required this.uid, this.name, required this.email});

  static GemberUser create({String? name, required email}) {
    return GemberUser(uid: Uuid().v4(), name: name, email: email);
  }

  GemberUser withProfilePicture(String prof_pic_url) {
    profile_picture = prof_pic_url;
    return this;
  }

  GemberUser withCoverPicture(String cover_pic_url) {
    cover_picture = cover_pic_url;
    return this;
  }

  GemberUser withPriorities(List<String> _priorities) {
    priorities = _priorities;
    return this;
  }

  factory GemberUser.fromJson(Map<String, dynamic> json) =>
      GemberUser(uid: json['uid'], name: json['name'], email: json['email'])
          .withProfilePicture(json['profile_picture'])
          .withCoverPicture(json['cover_picture'])
          .withPriorities(json['priorities']);

  Map<String, dynamic> toJson() => {
        'uid': uid,
        'name': name,
        'profile_picture': profile_picture,
        'cover_picture': cover_picture,
        'priorities': priorities
      };

  @override
  List<Object?> get props => [uid];
}
