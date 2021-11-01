import 'package:chopper/chopper.dart'; // flutter pub run build_runner build --delete-conflicting-outputs
import 'package:template/ui/models/models.dart';

import 'api_query_model.dart';
import 'model_response.dart';

abstract class ServiceInterface {
  Future<Response<Result<List<GreenProject>>>> queryProjects(String query);
}
