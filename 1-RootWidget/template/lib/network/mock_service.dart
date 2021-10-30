import 'dart:convert';
import 'dart:math';

import 'package:chopper/chopper.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart' show rootBundle;
import 'package:template/network/model_response.dart';
import 'package:template/network/template_service.dart';
import 'package:template/ui/models/project.dart';

part 'mock_service.chopper.dart';

@ChopperApi()
abstract class MockService extends TemplateService {
  static MockService create() {
    final client = ChopperClient(
        // baseUrl: apiUrl,
        // interceptors: [_addQuery, HttpLoggingInterceptor()],
        // converter: ModelConverter(),
        // errorConverter: const JsonConverter(),
        // services: [
        //   _$TemplateService(),
        // ],
        );
    return _$MockService(client);
  }

  @override
  Future<Response<Result<List<Project>>>> queryProjects(
      @Query('q') String query) {
    return Future.value(Response(http.Response('Dummy', 200, request: null),
        Success<List<Project>>(_projects_list.toList())));
  }

  late Iterable<Project> _projects_list;
  Random nextRecipe = Random();

  void init() {
    loadRecipes();
  }

  void loadRecipes() async {
    var jsonString =
        await rootBundle.loadString('assets/mock_data/projects.json');
    _projects_list =
        (jsonDecode(jsonString)['projects'] as List<Map<String, dynamic>>)
            .map((element) {
      return Project.fromJson(element);
    });
  }
}
