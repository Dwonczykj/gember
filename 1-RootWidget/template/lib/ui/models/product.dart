import 'package:template/ui/models/models.dart';
import 'package:uuid/uuid.dart';

abstract class Product {
  final Uuid uid;
  final String name;
  String? description;

  final Institution institution;

  Product({
    required this.uid,
    required this.name,
    required this.institution,
    this.description,
  });
}
