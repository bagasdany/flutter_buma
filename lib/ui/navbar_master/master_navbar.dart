// ignore_for_file: deprecated_member_use

import 'package:buma/infrastructure/database/page_data.dart';
import 'package:buma/infrastructure/database/shared_prefs_key.dart';
import 'package:buma/ui/app_dialog.dart';
import 'package:buma/ui/style/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../infrastructure/database/shared_prefs.dart';

// ignore: camel_case_types
class MasterNavbar extends StatefulWidget {
  final int? currentindeks;
  const MasterNavbar({
    Key? key,
    this.currentindeks,
  }) : super(key: key);

  @override
  _MasterNavbarState createState() => _MasterNavbarState();
}

final GlobalKey bottomBarNavigationKey = GlobalKey();

class _MasterNavbarState extends State<MasterNavbar>
    with AutomaticKeepAliveClientMixin<MasterNavbar> {
      
  @override
  
  bool get wantKeepAlive => true;
  
  int tabIndex = 0;
  int lastIndex = 0;
  int pageId = 0;
  // var pageLogin = InitialProfile();
  Widget a = const AlertDialog();
  PageController? _pageController = PageController();
  List<Widget>? pages;
  // final ScrollController _scrollControllerHome = ScrollController();
  // ScrollController scrollControllerArticle = ScrollController();
  // final ScrollController _scrollControllerPesanan = ScrollController();
  // final ScrollController _scrollControllerProfile = ScrollController();

  var userID = SharedPrefs().get(SharedPreferencesKeys.customerId);

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void dispose() {
    _pageController?.dispose();
    super.dispose();
  }

  @override
  void initState() {
    widget.currentindeks != null ? tabIndex = widget.currentindeks ?? 0 : 0;
    pages = [

      AppPage.withName('userList') as Widget,
      AppPage.withName('userLiked') as Widget,
      // OrderListView() as Widget,
      // OrderListView(),
      AppPage.withName('userAllNews') as Widget,
    ];
    // TODO: implement initState
    _pageController = PageController(initialPage: tabIndex);
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
    );
  }

  DateTime? currentBackPressTime;
  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > const Duration(seconds: 2)) {
      currentBackPressTime = now;
      AppDialog.snackBar(text: "Tekan sekali lagi untuk keluar");
      return Future.value(false);
    }
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
    );

    DateTime pre_backpress = DateTime.now();
    return WillPopScope(
        onWillPop: onWillPop,
        child: Scaffold(
          body: PageView(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              children: pages as List<Widget>),
          bottomNavigationBar: Theme(
            data: Theme.of(context).copyWith(
                canvasColor: Colors.white,
                textTheme: Theme.of(context)
                    .textTheme
                    .copyWith(caption: const TextStyle(color: Colors.black12))),
            child: BottomAppBar(
              color: Colors.transparent,
              shape: const CircularNotchedRectangle(),
              notchMargin: 10,
              clipBehavior: Clip.hardEdge,
              child: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                currentIndex: tabIndex,
                fixedColor: Constants.primaryColor,
                unselectedItemColor: Constants.black,
                onTap: (value) async {
                  SharedPrefs().get(SharedPreferencesKeys.customerId);
                  userID =
                      await SharedPrefs().get(SharedPreferencesKeys.customerId);
                   setState(() {
                     
                      tabIndex = pageId = value;
                      _pageController?.jumpToPage(value);
                    });
                  
                },
                //

                items: [
                  BottomNavigationBarItem(
                      icon: const ImageIcon(
                        AssetImage("assets/icon/home1.png"),
                        size: 30.0,
                      ),
                      activeIcon: SizedBox(
                          width: 30,
                          height: 30,
                          child: Image.asset('assets/icon/home_2.png')),
                      label: ('Home')),
                  BottomNavigationBarItem(
                    icon: const ImageIcon(
                      AssetImage("assets/icon/artikel1.png"),
                      size: 30.0,
                    ),
                    activeIcon: SizedBox(
                      width: 30,
                      height: 30,
                      child: Image.asset('assets/icon/artikel_2.png'),
                    ),
                    label: ('LikedNews'),
                  ),
                  BottomNavigationBarItem(
                    icon: const ImageIcon(
                      AssetImage("assets/icon/artikel1.png"),
                      size: 30.0,
                    ),
                    activeIcon: SizedBox(
                      width: 30,
                      height: 30,
                      child: Image.asset('assets/icon/artikel_2.png'),
                    ),
                    label: ('All News User'),
                  ),
                  
                ],
              ),
            ),
          ),
        ));
  }

  Widget headerWidget(BuildContext context) {
    final username = SharedPrefs().get(SharedPreferencesKeys.customerName);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 24),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 32,
            backgroundColor: Color.fromARGB(255, 209, 213, 219),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: username == null
                ? Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                          // Navigator.of(context).push(PageRouteBuilder(
                          //     pageBuilder: (_, __, ___) => const LoginView()));
                        },
                        child: const Text('Masuk',
                            style: TextStyle(
                                fontSize: 14,
                                fontFamily: Constants.primaryFontBold,
                                color: Constants.red)),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      const Text('Atau',
                          style:
                              TextStyle(fontSize: 14, color: Constants.gray)),
                      const SizedBox(
                        width: 5,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                          // Navigator.of(context).push(PageRouteBuilder(
                          //     pageBuilder: (_, __, ___) => SignUpView()));
                        },
                        child: const Text('Daftar',
                            style: TextStyle(
                                fontSize: 14,
                                fontFamily: Constants.primaryFontBold,
                                color: Constants.red)),
                      ),
                    ],
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(username,
                          style: const TextStyle(
                              fontSize: 16,
                              fontFamily: Constants.primaryFontBold,
                              color: Constants.black)),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(3),
                            color: Constants.white,
                            margin: const EdgeInsets.only(top: 5),
                            child: const Text(
                              'Silver',
                              style: TextStyle(fontSize: Constants.fontSizeSm),
                            ),
                          ),
                          const SizedBox(
                            width: 15,
                          )
                        ],
                      ),
                    ],
                  ),
          ),
        ],
      ),
    );
  }
}

enum DrawerSections {
  dashboard,
  contacts,
  events,
  notes,
  settings,
  notifications,
  privacy_policy,
  send_feedback,
}
