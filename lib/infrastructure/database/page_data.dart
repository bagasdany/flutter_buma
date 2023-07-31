import 'dart:async';

import 'package:buma/ui/view/user/user_all_news.dart';
import 'package:buma/ui/view/user/user_liked.dart';
import 'package:buma/ui/view/user/user_list.dart';
import 'package:flutter/material.dart';

class AppPage {

    // Buat StreamController dan Stream untuk mengelola data yang berubah.
  static final StreamController<Map<String, dynamic>> _pageDataController = StreamController<Map<String, dynamic>>();
  static Stream<Map<String, dynamic>> get onPageDataChanged => _pageDataController.stream;

  static Map<String, Widget> pages = {};

  static void dispose() {
    _pageDataController.close();
  }

  static Widget? withName(name) {
    if (!pages.containsKey(name)) {
      switch (name) {
        // case 'appbar':
        //   pages[name] = AppbarGradient();
          
        //   break;

        case 'userList':
          pages[name] = UserList();
          
        //   break;

        case 'userLiked':
          pages[name] = UserLiked();
          
        //   break;

        case 'userAllNews':
          pages[name] = AllNewsUser();
          
        //   break;

        // case 'm2w-motor':
        //   pages[name] = M2WSelectMotor();
          
        //   break;

        // case 'm4w':
        //   pages[name] = M4WView();
          
        //   break;

        // case 'sparepart':
        //   pages[name] = SparepartView();
          
        //   break;

        // case 'm4w-mobil':
        //   pages[name] = M4WSelectMobil();
          
        //   break;

        // case 'booking-servis':
        //   pages[name] = BookingServisView();
          
        //   break;

        // case 'booking-servis-motor':
        //   pages[name] = BookingServisAddMotorView();
          
        //   break;

        // case 'booking-servis-schedule':
        //   pages[name] = BookingServisAddScheduleView();
          
        //   break;

        // case 'artikel':
        //   pages[name] = InitialArticleView();
          
        //   break;

        // case 'add-kendaraan-saya':
        //   pages[name] = AddKendaraanSaya();
          
        //   break;

        // case 'order-list':
        //   pages[name] = OrderListView();
          
        //   break;

        // case 'akunsaya':
        //   pages[name] = InitialProfile();
          
        //   break;

        // case 'promo':
        //   pages[name] = ListPromotionView();
          
        //   break;

        // case 'voucher':
        //   pages[name] = InitialVoucherView();
          
        //   break;

        // case 'diskusi':
        //   pages[name] = DiskusiView();
          
        //   break;

        // case 'kelurahan-selector':
        //   pages[name] = KelurahanSelector();
          
        //   break;

        // case 'kelurahan-selector-global':
        //   pages[name] = KelurahanSelectorGlobal();
          
        //   break;

        // case 'city-selector-global':
        //   pages[name] = CitySelector();
          
        //   break;

        // case 'city-selector-agent':
        //   pages[name] = CitySelectorAgent();
          
        //   break;

        // case 'onboarding-agent':
        //   pages[name] = OnBoardingAgen();
          
        //   break;

        // case 'kelurahan-selectorKTP':
        //   pages[name] = KelurahanSelectorKTP();
          
        //   break;
        // //agent
        // case 'homeAgent':
        //   pages[name] = HomeAgentView();
          
        //   break;

        // case 'm2wAgent':
        //   pages[name] = M2WAgentView();
          
        //   break;

        // case 'multigunaAgent':
        //   pages[name] = MultigunaViewAgent();
          
        //   break;

        // case 'agent-m2w-motor':
        //   pages[name] = AgentM2WSelectMotor();
          
        //   break;
      }
    }

    return pages[name];
  }

  static void remove(name) {
    if (name == "m2w") {
      pages.remove("m2w");
      pages.remove("m2w-motor");
    } else if (name == "m4w") {
      pages.remove("m4w");
      pages.remove("m4w-mobil");
    } else if (name == "booking-servis") {
      pages.remove("booking-servis");
      pages.remove("booking-servis-motor");
      pages.remove("booking-servis-schedule");
    } else if (pages.containsKey(name)) {
      pages.remove(name);
      print("remove home");
    }
  }
    static void updatePageData(String name, Map<String, dynamic> newData) {
    // Ketika data di Page berubah, kirimkan data baru melalui StreamController.
    _pageDataController.add(newData);
  }
}
