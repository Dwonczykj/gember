import 'package:firebase_auth/firebase_auth.dart';

import 'product.dart';
import 'user.dart';

class GreenKing extends GemberUser {
  final List<Product> promotions;

  GreenKing(User user, {required this.promotions})
      : super(uid: user.uid, name: user.displayName, email: user.email);

  static GreenKing create(User fireUser) {
    return GreenKing(fireUser, promotions: <Product>[]);
  }

  factory GreenKing.fromJson(User fireUser, Map<String, dynamic> json) =>
      GreenKing(fireUser,
          promotions: json['promotions']);

  Map<String, dynamic> toJson() =>
      {'uid': uid, 'promotions': promotions};
}
