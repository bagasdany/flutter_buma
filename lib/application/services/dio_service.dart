import 'dart:io' show Platform;
import 'package:buma/flavors.dart';
import 'package:device_info_plus/device_info_plus.dart';

import 'package:dio/dio.dart';

class DioService {
  static Dio getInstance() {
    String version = '1.1.3';
    String os = Platform.isAndroid ? 'Android' : (Platform.isIOS ? 'iOS' : 'Unknown');
    String osVersion = Platform.operatingSystemVersion;

    final dio = Dio(
      BaseOptions(
          baseUrl: F.variables['baseURL'] as String,
          connectTimeout: const Duration(seconds: 60),
          receiveTimeout: const Duration(seconds: 60),
          headers: {'app-id': '64c7ab3417a371b12e4ecc1c'}),
    );

    DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      deviceInfoPlugin.androidInfo.then((deviceData) {
        dio.options.headers['User-Agent'] =
            'KlikNSS/$version $os $osVersion ${deviceData.model}';
      });
    } else if (Platform.isIOS) {
      deviceInfoPlugin.iosInfo.then((deviceData) {
        dio.options.headers['User-Agent'] =
            'KlikNSS/$version $os $osVersion ${deviceData.utsname.machine}';
      });
    }

    // dio.interceptors.add(ApiInterceptor());

    return dio;
  }
}
