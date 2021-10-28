import 'package:chopper/chopper.dart';
import 'package:template/network/api_query_model.dart';
import 'package:template/network/service_interface.dart';
import 'model_response.dart';

part 'template_service.chopper.dart';

const String apiKey = '<Your Key Here>';
const String apiId = '<Your Id here>';
const String apiUrl = 'https://api.edamam.com';

@ChopperApi()
abstract class TemplateService extends ChopperService
    implements ServiceInterface {
  @override
  @Get(path: 'search')
  Future<Response<Result<AAPIQuery>>> querySomething(@Query('q') String query);

  static TemplateService create() {
    final client = ChopperClient(
        // baseUrl: apiUrl,
        // interceptors: [_addQuery, HttpLoggingInterceptor()],
        // converter: ModelConverter(),
        // errorConverter: const JsonConverter(),
        // services: [
        //   _$TemplateService(),
        // ],
        );
    return _$TemplateService(client);
  }
}

Request _addQuery(Request req) {
  final params = Map<String, dynamic>.from(req.parameters);
  params['app_id'] = apiId;
  params['app_key'] = apiKey;

  return req.copyWith(parameters: params);
}
