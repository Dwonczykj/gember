import 'package:chopper/chopper.dart'; // flutter pub run build_runner build --delete-conflicting-outputs

import 'api_query_model.dart';
import 'model_response.dart';

abstract class ServiceInterface<TAPIQuery extends AAPIQuery> {
  Future<Response<Result<TAPIQuery>>> querySomething(String query);
}
