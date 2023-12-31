
import 'package:buma/infrastructure/database/shared_prefs_key.dart';
import 'package:buma/ui/navbar_master/master_navbar.dart';
import 'package:buma/ui/view/onboarding/onboardings.dart';
import 'package:buma/ui/view/startup/splash_screen.dart';
import 'package:buma/ui/view/user/user_detail.dart';
import 'package:buma/ui/view/user/user_post.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../infrastructure/database/shared_prefs.dart';

class AppRouter extends InterceptorsWrapper {
  // final Dio _dio = locator<Dio>();

  dynamic userID, buildLogin;
  // final events = StreamEventEmitter();

  // EventListener? listener;

  /// Set page route here
  /// - support dynamic path, ex: "/motor/:id" to handle "/motor/1", "/motor/2", ...
  /// - parameter _ in parameters always have parameters: _:{ params:{}, query:{} }
  /// - query string is parsed into "query" parameter
  /// - use '*' for fallback
  Map<String, dynamic> routes = {
    '/': (_) =>  MasterNavbar(),
    '/startup': (_) => SplashScreen(),
    // '/onboardings': (_) => OnBoardings(),
    '/user/:id': (_) {
      return UserDetail(
        id: (_['params']['id']) ?? -1,
      );
    },
    '/userpost/:id': (_) {
      return UserPost(
        id: (_['params']['id']) ?? -1,
        name: _['query']['name'],
        
      );
    },
    
  };

  Route<dynamic>? onGenerateRoute(RouteSettings settings, [String? lbasePath]) {
    Map? match;
    Function? fn;
    bool protected = false;

    // for (var path in protectedRoutes.keys) {
    //   Map? curMatch = isMatch(settings.name!, path);
    //   if (curMatch != null) {
    //     match = curMatch;
    //     fn = protectedRoutes[path];
    //     protected = true;
    //   }
    // }
    if (match == null) {
      for (var path in routes.keys) {
        Map? curMatch = isMatch(settings.name!, path);
        if (curMatch != null) {
          match = curMatch;
          fn = routes[path];
        }
      }
    }

    userID = SharedPrefs().get(SharedPreferencesKeys.customerId);
    
    if (match != null) {
      print("match");
      userID = SharedPrefs().get(SharedPreferencesKeys.customerId);
       return MaterialPageRoute(
            builder: (_) => fn!(match), settings: settings);
    } 

    return null;
  }

  Map? isMatch(String url, pattern) {
    bool matched = false;
    var uri = Uri.parse(url);
    var urlSegments = pattern.substring(1).split('/');
    Map params = {};
    if (uri.pathSegments.isNotEmpty &&
        urlSegments.length == uri.pathSegments.length) {
      bool segmentMatch = true;
      for (var i = 0; i < urlSegments.length; i++) {
        String segment = urlSegments[i];
        if (segment.indexOf(':') == 0) {
          String key = segment.substring(1);
          params[key] = uri.pathSegments[i];
        } else {
          if (uri.pathSegments[i] != urlSegments[i]) {
            segmentMatch = false;
            break;
          }
        }
      }

      matched = segmentMatch;
    } else if (url == pattern) {
      matched = true;
    }

    if (matched) {
      String routeName =
          url.contains('?') ? url.substring(0, url.indexOf('?')) : url;

      return {
        'params': params,
        'query': uri.queryParameters,
        'name': routeName
      };
    }
    return null;
  }
}
