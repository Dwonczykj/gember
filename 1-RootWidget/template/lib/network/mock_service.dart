import 'dart:convert';
import 'dart:math';

import 'package:chopper/chopper.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart' show rootBundle;
import 'package:template/network/model_response.dart';
import 'package:template/network/service_interface.dart';
import 'package:template/network/template_service.dart';
import 'package:template/ui/models/green_project.dart';

// part 'mock_service.chopper.dart';

class MockService implements ServiceInterface {
  static MockService create() {
    // final client = ChopperClient(
    //     // baseUrl: apiUrl,
    //     // interceptors: [_addQuery, HttpLoggingInterceptor()],
    //     // converter: ModelConverter(),
    //     // errorConverter: const JsonConverter(),
    //     // services: [
    //     //   _$TemplateService(),
    //     // ],
    //     );
    var ms = MockService();
    ms.init();
    return ms;
  }

  @override
  Future<Response<Result<List<GreenProject>>>> queryProjects(String query) {
    return Future.value(Response(http.Response('Dummy', 200, request: null),
        Success<List<GreenProject>>(_projects_list.toList())));
  }

  late Iterable<GreenProject> _projects_list;
  Random nextRecipe = Random();

  void init() {
    loadRecipes();
  }

  void loadRecipes() async {
    var jsonString =
        await rootBundle.loadString('assets/mock_data/projects.json');
    _projects_list = (jsonDecode(jsonString)['projects'] as List)
        .map((element) => GreenProject.fromJson(element));
  }
}
