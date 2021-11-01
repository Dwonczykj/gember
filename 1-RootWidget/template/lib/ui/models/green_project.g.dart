// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'green_project.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GreenProject _$GreenProjectFromJson(Map<String, dynamic> json) {
  return GreenProject(
    uid: json['uid'] as String,
    name: json['project_name'] as String,
    image_url: json['image_url'] as String,
    company_name: json['company_name'] as String,
    description: json['description'] as String,
    short_description: json['short_description'] as String,
  );
}

Map<String, dynamic> _$GreenProjectToJson(GreenProject instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'project_name': instance.name,
      'image_url': instance.image_url,
      'company_name': instance.company_name,
      'description': instance.description,
      'short_description': instance.short_description,
    };
