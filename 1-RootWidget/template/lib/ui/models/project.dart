import 'package:json_annotation/json_annotation.dart';
part "project.g.dart";

@JsonSerializable()
class Project {
  @JsonKey(name: 'uid')
  String uid;

  @JsonKey(name: 'project_name')
  String name;

  String image_url;
  String CompanyName;

  Project({
    required this.uid,
    required this.name,
    this.image_url = "",
    this.CompanyName = "",
  });

  factory Project.fromJson(Map<String, dynamic> json) =>
      _$ProjectFromJson(json);

  Map<String, dynamic> toJson() => _$ProjectToJson(this);
}
