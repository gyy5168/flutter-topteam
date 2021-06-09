import 'package:dio/dio.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:topteam/main.dart';

class Request {
  // Request _instance;
  static Dio _dio;
  final String type;
  var domains = {
    'default': 'https://api-ding.yunxuetang.com.cn/v1/',
    'component': 'https://api-component.yunxuetang.com.cn/v1/'
  };

  Request({
    this.type = 'default'
  });
  Dio getInstance(){
    if (_dio == null) {
      _init();
    }
    _dio.options.baseUrl = domains[type];
    return _dio;
  }
  _init(){
    BaseOptions options = BaseOptions(
      baseUrl: domains[this.type],
      // validateStatus: (status) => true,
      headers: {
        'source': 1605,
      }
    );
    _dio = new Dio(options);
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (RequestOptions options) {
        },
        onResponse: (Response response) {
          if (response.statusCode == 201) {
            if (response.data.runtimeType.toString() == '_InternalLinkedHashMap<String, dynamic>') {
              response.data['Location'] = response.headers['location'];
            } else {
              response.data = {
                'Location' : response.headers['location']
              };
            }
          }
          return response;
        },
        onError: (DioError err) {
          if (err.response != null) {
            if (err.response.statusCode == 401) {
              Fluttertoast.showToast(msg: '身份失效，请重新登录');
              AppRouter.navigatorKey.currentState.pushReplacementNamed('/login');
            }
          }
        },
      )
    );
  }
  setToken(token){
    Dio dio = getInstance();
    dio.options.headers['token'] = token;
  }
  Future get(url, {query, options}) {
    Dio dio = getInstance();
    return dio.get(url, queryParameters: query, options: options);
  }
  Future post(url, {data, query, options}) {
    Dio dio = getInstance();
    return dio.post(url, data: data??{}, queryParameters: query, options: options);
  }
}
