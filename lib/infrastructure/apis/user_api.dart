import 'dart:async';

import 'package:buma/application/helpers/endpoint.dart';
import 'package:buma/application/services/dio_service.dart';
import 'package:dio/dio.dart';

import '../database/shared_prefs.dart';

class UserApi {
  final Dio _dio = DioService.getInstance();
  final _sharedPrefs = SharedPrefs();

  Future<dynamic> getUserDetail(id) async {
    var response = await _dio.get("${Endpoint.userList}/$id");

    return response.data;
  }

  

}
