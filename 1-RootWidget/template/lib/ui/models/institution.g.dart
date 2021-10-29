// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'institution.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Institution _$InstitutionFromJson(Map<String, dynamic> json) {
  return Institution(
    uid: json['uid'] as String,
    name: json['name'] as String,
    website: json['website'] as String?,
    address: json['address'] as String?,
    projects: (json['projects'] as List<dynamic>)
        .map((e) => Project.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$InstitutionToJson(Institution instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'name': instance.name,
      'projects': instance.projects,
      'website': instance.website,
      'address': instance.address,
    };
