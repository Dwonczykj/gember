import 'product.dart';
import 'user.dart';

class GreenKing extends User {
  final List<Product> promotions;

  GreenKing(String uid, String? name, {required this.promotions})
      : super(uid: uid, name: name);

  static GreenKing create({String? name}) {
    var user = User.create(name: name);
    return GreenKing(user.uid, user.name, promotions: <Product>[]);
  }

  factory GreenKing.fromJson(Map<String, dynamic> json) =>
      GreenKing(json['uid'], json['name'], promotions: json['promotions']);

  Map<String, dynamic> toJson() =>
      {'uid': uid, 'name': name, 'promotions': promotions};
}
