import 'package:buma/application/app/scroll_behavior.dart';
import 'package:buma/application/router/router.dart';
import 'package:buma/application/services/app_navigation_service.dart';
import 'package:buma/application/services/connectivity_service.dart';
import 'package:buma/application/statusApp/connectivity_status.dart';
import 'package:buma/infrastructure/database/shared_prefs.dart';
import 'package:buma/ui/app_dialog.dart';
import 'package:buma/ui/style/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';


class BumaApp extends StatefulWidget {
  const BumaApp({Key? key}) : super(key: key);

  @override
  State<BumaApp> createState() => _BumaAppState();
}

class _BumaAppState extends State<BumaApp> with WidgetsBindingObserver {
  // final _authApi = locator<AuthApi>();
  final _sharedPrefs = SharedPrefs();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  // void cekNotif() async {
  //   FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  //       FlutterLocalNotificationsPlugin();

  //   var details =
  //       await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
  //   if (details?.didNotificationLaunchApp ?? false) {
  //     if (details != null) {
  //       Future.delayed(const Duration(seconds: 4), () {
  //         details = null;
  //       });

  //       if ((details?.notificationResponse?.payload ?? "")
  //           .contains("kliknss")) {
  //         final opened = await _sharedPrefs.get('notif');
  //         opened != details?.notificationResponse?.payload
  //             ? AppDialog.openUrl(details?.notificationResponse?.payload)
  //             : null;

  //         _sharedPrefs.set('notif', details?.notificationResponse?.payload);

  //         flutterLocalNotificationsPlugin.cancelAll();
  //       }
  //       details = null;
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Listener(
      child: StreamProvider<ConnectivityStatus>(
        initialData: ConnectivityStatus.cellular,
        create: (context) =>
            ConnectivityService().connectionStatusController.stream,
        child: OverlaySupport(
            child: MaterialApp(
          title: "KlikNSS",
          navigatorKey: AppNavigatorService.navigatorKey,
          scaffoldMessengerKey: scaffoldKey,
          initialRoute: '/startup',
          onGenerateRoute: AppRouter().onGenerateRoute,
          debugShowCheckedModeBanner: false,
          scrollBehavior: AppScrollBehavior(),
          theme: ThemeData(
              splashFactory: NoSplash.splashFactory,
              primarySwatch: Constants.primaryColor,
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              canvasColor: Constants.base,
              fontFamily: Constants.primaryFont,
              appBarTheme: AppBarTheme(
                titleTextStyle: TextStyle(color: Constants.gray.shade800)
                    .merge(Constants.heading4),
              ),
              textTheme: const TextTheme(bodyMedium: Constants.textMd)),
        )),
      ),
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    switch (state) {
      case AppLifecycleState.resumed:
        break;

      case AppLifecycleState.inactive:
        break;

      case AppLifecycleState.paused:
        // TODO: Handle this case.
        break;
      case AppLifecycleState.detached:
        // validateNotif();
        // detached tidak selalu works,rawan

        break;
    }
  }
}
