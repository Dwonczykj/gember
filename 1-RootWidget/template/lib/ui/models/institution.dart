import 'package:json_annotation/json_annotation.dart';
import 'project.dart';
part 'institution.g.dart';

@JsonSerializable()
class Institution {
  factory Institution.fromJson(Map<String, dynamic> json) =>
      _$InstitutionFromJson(json);

  Map<String, dynamic> toJson() => _$InstitutionToJson(this);
  @JsonKey(name: 'uid')
  String uid;
  String name;
  var projects = <Project>[];
  String? website;
  String? address;

  Institution(
      {required this.uid,
      required this.name,
      this.website,
      this.address,
      List<Project> projects = const <Project>[]});
}
