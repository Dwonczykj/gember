// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'initiative.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Initiative _$InitiativeFromJson(Map<String, dynamic> json) {
  return Initiative(
    uid: json['uid'] as String,
    name: json['initiative_name'] as String,
    image_url: json['image_url'] as String,
    company_name: json['company_name'] as String,
    description: json['description'] as String,
    short_description: json['short_description'] as String,
  );
}

Map<String, dynamic> _$InitiativeToJson(Initiative instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'initiative_name': instance.name,
      'image_url': instance.image_url,
      'company_name': instance.company_name,
      'description': instance.description,
      'short_description': instance.short_description,
    };
