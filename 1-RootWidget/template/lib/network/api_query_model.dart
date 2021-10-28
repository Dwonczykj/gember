import 'package:json_annotation/json_annotation.dart';

part 'api_query_model.g.dart';

@JsonSerializable()
class AAPIQuery {
  factory AAPIQuery.fromJson(Map<String, dynamic> json) =>
      _$AAPIQueryFromJson(json);

  Map<String, dynamic> toJson() => _$AAPIQueryToJson(this);

  @JsonKey(name: 'q')
  String query;

  AAPIQuery({required this.query});
}
