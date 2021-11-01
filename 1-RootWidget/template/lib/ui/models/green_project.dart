import 'package:json_annotation/json_annotation.dart';
part 'green_project.g.dart';

@JsonSerializable()
class GreenProject {
  @JsonKey(name: 'uid')
  final String uid;

  @JsonKey(name: 'project_name')
  final String name;

  final String image_url;
  final String company_name;

  final String description;
  final String short_description;

  GreenProject({
    required this.uid,
    required this.name,
    this.image_url = "",
    this.company_name = "",
    this.description = "",
    this.short_description = "",
  });

  factory GreenProject.fromJson(Map<String, dynamic> json) => GreenProject(
        uid: json['uid'] as String,
        name: json['project_name'] as String,
        image_url: json['image_url'] as String,
        company_name: json['company_name'] as String,
        short_description: json['short_description'] as String,
        description: json['description'] as String,
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'uid': uid,
        'project_name': name,
        'image_url': image_url,
        'company_name': company_name,
        'description': description,
        'short_description': short_description,
      };
}

class Project extends GreenProject {
  Project({
    required uid,
    required name,
    image_url = "",
    company_name = "",
    description = "",
    short_description = "",
  }) : super(
            uid: uid,
            name: name,
            image_url: image_url,
            company_name: company_name,
            description: description,
            short_description: short_description);
}
