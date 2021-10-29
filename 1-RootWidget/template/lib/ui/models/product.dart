import 'package:template/ui/models/models.dart';
import 'package:uuid/uuid.dart';

class Product {
  final String uid;
  final String name;
  String? description;

  final Institution institution;

  Product({
    required this.uid,
    required this.name,
    required this.institution,
    this.description,
  });

  static Product create(
      {required String name, required Institution institution}) {
    return Product(uid: Uuid().v4(), name: name, institution: institution);
  }

  factory Product.fromJson(Map<String, dynamic> json) => Product(
      uid: json['uid'],
      name: json['name'],
      institution: Institution.fromJson(json['institution']),
      description: json['description']);

  Map<String, dynamic> toJson() => {
        'uid': uid,
        'name': name,
        'institution': institution.toJson(),
        'description': description
      };
}
