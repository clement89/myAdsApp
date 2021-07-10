import 'package:dio/dio.dart';
import 'package:myads_app/utils/shared_pref_manager.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class ApiManager {
  static final ApiManager _apiService = ApiManager._internal();
  ApiManager._internal();
  static ApiManager get instance => _apiService;

  Dio _dio;
  String token;
  bool isContentTypeJson = true;
  bool _isHttpRequest = false;
  bool _urlEncode = false;
  static const String BASE_URL =
      "https://myads-web.vitruvian-test.com.au/test/api/v1/";
  factory ApiManager() {
    return _apiService;
  }

  Dio getDio({isJsonType = true, isHttpRequest = false, isUrlEncoded = false}) {
    isContentTypeJson = isJsonType;
    _urlEncode = isUrlEncoded;
    _isHttpRequest = isHttpRequest;
    _init();
    return _dio;
  }

  initToken() async {
    token = await SharedPrefManager.instance.getToken();
  }

  _init() async {
    if (_dio == null) {
      _dio = Dio();
      _dio.options.baseUrl = BASE_URL;
      _dio.options.contentType = Headers.jsonContentType;
      _dio.interceptors..add(LogInterceptor());
      _dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        compact: false,
      ));
    }
    if (token != null && token.isNotEmpty) {
      _dio.interceptors.clear();
      _dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        compact: false,
      ));
      _dio.interceptors.add(InterceptorsWrapper(onRequest: (Options options) {
        options.headers["x-auth-token"] = token;

        if (isContentTypeJson)
          options.headers["Content-Type"] = "application/json";

        if (_urlEncode)
          options.headers["Content-Type"] = "application/x-www-form-urlencoded";

        if (_isHttpRequest)
          options.headers["X-Requested-With"] = "XMLHttpRequest";
        return options;
      }));
    }
    _dio.options.receiveTimeout = 10000;
  }

  void updateAuthToken(String data) {
    token = data;
    if (_dio != null) {
      _dio.interceptors.add(InterceptorsWrapper(onRequest: (Options options) {
        options.headers["x-auth-token"] = token;
        return options;
      }));
    }
  }
}
