import 'product.dart';
import 'user.dart';

class GreenKing extends GemberUser {
  final List<Product> promotions;

  GreenKing(String uid, String? name, String email, {required this.promotions})
      : super(uid: uid, name: name, email: email);

  static GreenKing create({String? name, required String email}) {
    var user = GemberUser.create(name: name, email: email);
    return GreenKing(user.uid, user.name, user.email, promotions: <Product>[]);
  }

  factory GreenKing.fromJson(Map<String, dynamic> json) =>
      GreenKing(json['uid'], json['name'], json['email'],
          promotions: json['promotions']);

  Map<String, dynamic> toJson() =>
      {'uid': uid, 'name': name, 'promotions': promotions};
}
