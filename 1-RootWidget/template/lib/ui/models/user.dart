import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:template/ui/models/models.dart';
import 'package:uuid/uuid.dart';

class GemberUser extends Equatable {
  final String uid;

  final String? name;

  final String? email;

  String? profile_picture;

  String? cover_picture;

  List<String> priorities = [];

  GemberUser({required this.uid, this.name, this.email});

  static GemberUser create(User user) {
    return GemberUser(uid: user.uid, name: user.displayName, email: user.email)
        .withProfilePicture(user.photoURL);
  }

  GemberUser withProfilePicture(String? prof_pic_url) {
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

  factory GemberUser.fromJson(User cUser, Map<String, dynamic> json) =>
      GemberUser(uid: json['uid'], name: json['name'], email: json['email'])
          .withProfilePicture(json['profile_picture'])
          .withCoverPicture(json['cover_picture'])
          .withPriorities(json['priorities']);

  Map<String, dynamic> toJson() => {
        'uid': uid,
        'cover_picture': cover_picture,
        'priorities': priorities
      };

  @override
  List<Object?> get props => [uid];
}
