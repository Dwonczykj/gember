// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'template_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations
class _$TemplateService extends TemplateService {
  _$TemplateService([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = TemplateService;

  @override
  Future<Response<Result<List<GreenProject>>>> queryProjects(String query) {
    final $url = 'search';
    final $params = <String, dynamic>{'q': query};
    final $request = Request('GET', $url, client.baseUrl, parameters: $params);
    return client.send<Result<List<GreenProject>>, GreenProject>($request);
  }
}
