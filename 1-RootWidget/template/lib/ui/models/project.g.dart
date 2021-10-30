// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Project _$ProjectFromJson(Map<String, dynamic> json) {
  return Project(
    uid: json['uid'] as String,
    name: json['project_name'] as String,
    image_url: json['image_url'] as String,
    CompanyName: json['CompanyName'] as String,
  );
}

Map<String, dynamic> _$ProjectToJson(Project instance) => <String, dynamic>{
      'uid': instance.uid,
      'project_name': instance.name,
      'image_url': instance.image_url,
      'CompanyName': instance.CompanyName,
    };
