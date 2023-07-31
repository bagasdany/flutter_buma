// main.dart
// ignore_for_file: avoid_unnecessary_containers

import 'dart:async';
import 'dart:convert';

import 'package:buma/application/exceptions/dio_exceptions.dart';
import 'package:buma/application/helpers/endpoint.dart';
import 'package:buma/application/services/dio_service.dart';
import 'package:buma/ui/component/button.dart';
import 'package:buma/ui/component/icon_refresh_indicator.dart';
import 'package:buma/ui/component/user_item.dart';
import 'package:buma/ui/style/constants.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_multi_select_items/flutter_multi_select_items.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

import 'package:flutter/widgets.dart' as text;

import 'package:intl/intl.dart' as intl;
import 'package:shared_preferences/shared_preferences.dart';




class UserLiked extends StatefulWidget {
  
  UserLiked({Key? key, }) : super(key: key);
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  @override
  _UserLikedState createState() => _UserLikedState();
}

class _UserLikedState extends State<UserLiked> {
  final Dio _dio = DioService.getInstance();
  // At the beginning, we fetch the first 20 posts
  int _page = 1;
  final int _limit = 20;
  Map<dynamic, dynamic> filters = {
    'brands': [],
    'motors': [],
    'sorts': [],
    'priceRanges': [],
    'priceRangesOpt': [],
    'count': 99,
  };
  Timer? _clearTimer;

  List filterlist = [];
  int urutan = 99;
  var filterkategori = "";
  String filterakhir = "";
  String rangeprice = "";
  int? idSorts = 99;

  List<dynamic> banners = [];
  List<dynamic> motors = [];
  List<dynamic> sorts = [];
  List<dynamic> brands = [];
  List<dynamic> priceRanges = [];
  List<dynamic> priceRangesOpt = [];
  int rangeValueStart = 0;
  int rangeValueEnd = 1000000000;
  int count = 99;
  RangeValues valuess = const RangeValues(4, 100);
  final currencyFormatter = NumberFormat.currency(locale: 'ID');
  final pricecontroller = TextEditingController();
  // There is next page or not
  bool _hasNextPage = true;

  // Used to display loading indicators when _firstLoad function is running
  bool _isFirstLoadRunning = false;

  // Used to display loading indicators when _loadMore function is running
  bool _isLoadMoreRunning = false;

  // This holds the posts fetched from the server
  List _posts = [];
  Map component = {};
  // List kategori = [];
  List _data = [];
  final List _filtermotor = [];
  int countfilter = 0;
  int countsfilter = 99;
  String namaawal = "";
  String sorting = "";
  // String
  List kategoribrand = [];

  RangeValues _currentRangeValues = const RangeValues(0, 0);
  dynamic filterPriceString;
  dynamic filterPriceStringDialog;
  Map type = {};
  int state = 0;

  // Future<Map> patch() async {
  //   var idkategori = widget.id;
  //   Response response =
  //       await _dio.patch("${Endpoint.userList}");
  //   if (response.data == null || response.data == "") {
  //     setState(() {
  //       state = -1;
  //     });
  //   }
  //   return response.data;
  // }

  void _firstLoad() async {
    setState(() {
      _isFirstLoadRunning = true;
      _page = 1;
    });
    try {
      var params = {
        'page': 1,
        'limit': 20
        // 'sorts': 1,
      };
      Response response = await _dio.get(Endpoint.userList, queryParameters: params);

      var nextItems = response.data['data'] as List;
      List getdata = nextItems.map((item) => item).toList();

      setState(() {
        _posts = getdata;
        _page = 1;
      });
    } on DioException catch (e) {
      dynamic errors = DioExceptions.fromDioError(e);
      if (errors != null) {
        if (errors.message == "No Internet") {
          setState(() {
            state = -2;
          });
        } else {
          setState(() {
            state = -1;
          });
        }
      }
    } finally{
      setState(() {
        _isFirstLoadRunning = false;
        state = 1;
      });
    }

    setState(() {
      _isFirstLoadRunning = false;
    });
  }

  void filtermotor(List kategori) async {
    setState(() {
      _isFirstLoadRunning = true;
    });
    try {
      filterakhir = "";
      filterkategori = kategori.join(",");
      if (filterkategori == "") {
        filterakhir.isEmpty;
      } else {
        filterakhir = filterkategori;
      }

      setState(() {
        kategoribrand = kategori;
      });
    } on DioException catch (err) {
      dynamic errors = DioExceptions.fromDioError(err);
      if (errors != null) {
        if (errors.message == "No Internet") {
          setState(() {
            state = -2;
          });
        } else {
          setState(() {
            state = -1;
          });
        }
      }
    }

    setState(() {
      _isFirstLoadRunning = false;
    });
  }

  // Future _filteredmotor(List kategori, dynamic setParentState) async {
  //   try {
  //     setState(() {
  //       _hasNextPage = true; // Display a progress indicator at the bottom
  //     });
  //     filterkategori = kategori.join(",");
  //     if (filterkategori == "") {
  //       filterkategori = "";
  //     } else {
  //       filterkategori = filterkategori;
  //     }

  //     int urutan = idSorts != 99 ? idSorts! : 1;
  //     rangeprice = filterPriceString ?? "";
  //     var params = {
  //       'categoryId': widget.id,
  //       'page': 1,
  //       'itemsPerPage': 12,
  //       'sorts': urutan,
  //       filterkategori != "" ? 'filters[motorId]' : filterkategori:
  //           filterkategori,
  //       rangeprice != "" ? 'filters[price]' : rangeprice: rangeprice,
  //     };
  //     var response =
  //         await _dio.get(Endpoint.userList, queryParameters: params);
  //     setState(() {
  //       kategoribrand = kategori;
  //       countsfilter = response.data['count'];
  //     });
  //     setParentState(() {
  //       kategoribrand = kategori;
  //       countsfilter = response.data['count'];
  //     });
  //     return response.data;
  //   } on DioException catch (e) {
  //     dynamic errors = DioExceptions.fromDioError(e);
  //     if (errors != null) {
  //       if (errors.message == "No Internet") {
  //         setState(() {
  //           state = -2;
  //         });
  //       } else {
  //         setState(() {
  //           state = -1;
  //         });
  //       }
  //     }
  //   }
  // }

  // Future _filtered(dynamic setParentState) async {
  //   setState(() {
  //     _isFirstLoadRunning = true;
  //   });
  //   try {
  //     int urutan = idSorts != 99 ? idSorts! : 1;
  //     filterkategori = kategoribrand.join(",");
  //     if (filterkategori == "") {
  //       filterkategori = "";
  //     } else {
  //       filterkategori = filterkategori;
  //     }
  //     rangeprice = filterPriceString ?? "";
  //     var params = {
  //       'categoryId': widget.id,
  //       'page': 1,
  //       'itemsPerPage': 12,
  //       'sorts': urutan,
  //       filterkategori != "" ? 'filters[motorId]' : filterkategori:
  //           filterkategori,
  //       rangeprice != "" ? 'filters[price]' : rangeprice: rangeprice,
  //     };
  //     Response response =
  //         await _dio.get(Endpoint.userList, queryParameters: params);
  //     var nextItems = response.data['items'] as List;
  //     List getdata = nextItems.map((item) => item).toList();

  //     setState(() {
  //       countsfilter = response.data['count'];

  //       _data = getdata;
  //       _posts = getdata;
  //       _page = 1;
  //     });
  //   } on DioException catch (err) {
  //     dynamic errors = DioExceptions.fromDioError(err);
  //     if (errors != null) {
  //       if (errors.message == "No Internet") {
  //         setState(() {
  //           state = -2;
  //         });
  //       } else {
  //         setState(() {
  //           state = -1;
  //         });
  //       }
  //     }
  //   }

  //   setState(() {
  //     _isFirstLoadRunning = false;
  //   });
  // }

  // Future filteredDialog(dynamic setParentState) async {
  //   try {
  //     // print(namaurutan);

  //     int urutan = idSorts != 99 ? idSorts! : 1;
  //     // print("urutan ${urutan}");
  //     filterkategori = kategoribrand.join(",");
  //     if (filterkategori == "") {
  //       filterkategori = "";
  //     } else {
  //       filterkategori = filterkategori;
  //     }
  //     rangeprice = filterPriceStringDialog ?? "";
  //     var params = {
  //       'categoryId': widget.id,
  //       'page': 1,
  //       'itemsPerPage': 12,
  //       'sorts': urutan,
  //       filterkategori != "" ? 'filters[motorId]' : filterkategori:
  //           filterkategori,
  //       rangeprice != "" ? 'filters[price]' : rangeprice: rangeprice,
  //     };
  //     Response response =
  //         await _dio.get(Endpoint.userList, queryParameters: params);
  //     var nextItems = response.data['items'] as List;
  //     var nexty = response.data['items'];

  //     var y = nextItems.map((e) => e.id);
  //     var ye = nextItems.asMap();
  //     var xe = ye.values;
  //     List getdata = nextItems.map((item) => item).toList();
  //     // return response
  //     int be = 0;
  //     setParentState(() {
  //       countsfilter = response.data['count'];
  //     });

  //     setState(() {
  //       countsfilter = response.data['count'];
  //     });
  //   } on DioException catch (err) {
  //     dynamic errors = DioExceptions.fromDioError(err);
  //     if (errors != null) {
  //       if (errors.message == "No Internet") {
  //         setState(() {
  //           state = -2;
  //         });
  //       } else {
  //         setState(() {
  //           state = -1;
  //         });
  //       }
  //     }
  //   }

  //   setState(() {
  //     _isFirstLoadRunning = false;
  //   });
  // }

  void reset() {
    setState(() {
      _currentRangeValues = const RangeValues(0, 0);
      rangeValueStart = 0;
      rangeValueEnd = 1000000000;
      urutan = 99;
      countsfilter = 99;
      filterkategori = "";
      rangeprice = "";
      _page = 1;
      kategoribrand = [];
      type = {};
      filterPriceString = "";
      _hasNextPage == true;
      _isFirstLoadRunning == false;
      _isLoadMoreRunning == false;
    });
  }

  // void openTypeFilterscategory(BuildContext context) {
  //   List<dynamic> types = motors;
  //   if (types.isNotEmpty && types[0]?['name'] != "Semua Tipe") {
  //     types.insert(0, {'name': 'Semua Tipe', 'id': 0});
  //   }

  //   showModalBottomSheet<dynamic>(
  //       context: context,
  //       isDismissible: true,
  //       builder: (BuildContext modalContext) {
  //         return StatefulBuilder(builder: (context, setParentState) {
  //           return Scaffold(
  //               appBar: AppBar(
  //                 automaticallyImplyLeading: false,
  //                 title: const text.Text('Filter Tipe'),
  //                 backgroundColor: Colors.white,
  //                 foregroundColor: Colors.black,
  //                 elevation: 0,
  //                 actions: [
  //                   InkWell(
  //                       splashColor: Colors.transparent,
  //                       onTap: () {
  //                         Navigator.pop(modalContext);
  //                       },
  //                       child: Container(
  //                         padding: const EdgeInsets.symmetric(
  //                             vertical: 0, horizontal: 8),
  //                         child: SvgPicture.asset(
  //                           'assets/svg/close.svg',
  //                           width: 24,
  //                           height: 24,
  //                           alignment: Alignment.center,
  //                         ),
  //                       ))
  //                 ],
  //               ),
  //               body: SingleChildScrollView(
  //                   padding: const EdgeInsets.fromLTRB(4, 16, 4, 16),
  //                   child: ListView.builder(
  //                     shrinkWrap: true,
  //                     physics: const NeverScrollableScrollPhysics(),
  //                     itemCount: types.length,
  //                     itemBuilder: (context, index) {
  //                       int? value = types[index]['id'];
  //                       if (!type.containsKey(value)) type[value] = false;

  //                       return Container(
  //                         color: Constants.white,
  //                         child: CheckboxListTile(
  //                             title: text.Text(types[index]['name']),
  //                             value: type[types[index]['id']],
  //                             selectedTileColor:
  //                                 Constants.primaryColor.shade400,
  //                             activeColor: Constants.primaryColor.shade400,
  //                             onChanged: (bool? checked) async {
  //                               if (value == 0) {
  //                                 setParentState(() {
  //                                   for (var _type in types) {
  //                                     type[_type['id']] = checked!;
  //                                   }
  //                                 });

  //                                 List tipess = type.keys.toList();
  //                                 var filterawal = [];

  //                                 tipess.remove(0);
  //                                 tipess.join(",");
  //                                 var lengthtipe = tipess.length;
  //                                 var lengthfilterlist = filterlist.length;
  //                                 lengthtipe == lengthfilterlist
  //                                     ? filterlist.remove(tipess)
  //                                     : filterawal.add(tipess);

  //                                 filterlist =
  //                                     filterawal.isEmpty ? [] : filterawal[0];

  //                                 _filteredmotor(filterlist, setParentState);
  //                                 setParentState(() {
  //                                   countsfilter = countsfilter;
  //                                 });
  //                               } else {
  //                                 setParentState(() {
  //                                   type[value] = checked!;

  //                                   bool allChecked = true;

  //                                   type.forEach((key, value) {
  //                                     if (key != 0 && !value) {
  //                                       allChecked = false;
  //                                     }
  //                                   });
  //                                   if (!allChecked) {
  //                                     type[0] = allChecked;
  //                                   }
  //                                   if (filterlist.contains(value) == true) {
  //                                     filterlist.remove(value);
  //                                   } else {
  //                                     filterlist.add(value);
  //                                   }
  //                                   _filteredmotor(filterlist, setParentState);
  //                                 });
  //                                 setParentState(() {
  //                                   countsfilter = countsfilter;
  //                                 });
  //                               }
  //                             }),
  //                       );
  //                     },
  //                   )),
  //               bottomNavigationBar: Container(
  //                 padding: const EdgeInsets.all(12),
  //                 child: Button(
  //                   state: countsfilter == 0
  //                       ? ButtonState.disabled
  //                       : ButtonState.normal,
  //                   text: countsfilter == 99
  //                       ? "Filter"
  //                       : countsfilter == 0
  //                           ? "Tidak ada data"
  //                           : "Filter ($countsfilter)",
  //                   fontSize: Constants.fontSizeLg,
  //                   onPressed: countsfilter == 0
  //                       ? null
  //                       : () {
  //                           _filtered(setParentState);
  //                           Navigator.pop(modalContext);
  //                         },
  //                 ),
  //               ));
  //         });
  //       }).whenComplete(() {
  //     patch().then((_filters) {
  //       setState(() {
  //         filters = _filters;
  //       });
  //     });
  //   });
  // }

  // void openTypeFilters(BuildContext context) {
  //   List kategori = [];

  //   setState(() {
  //     kategori = kategori;
  //   });

  //   showModalBottomSheet<dynamic>(
  //       context: context,
  //       isDismissible: true,
  //       builder: (BuildContext modalContext) {
  //         return StatefulBuilder(builder: (context, setState) {
  //           return Scaffold(
  //               appBar: AppBar(
  //                 automaticallyImplyLeading: false,
  //                 title: const text.Text('Filter Motor'),
  //                 backgroundColor: Colors.white,
  //                 foregroundColor: Colors.black,
  //                 elevation: 0,
  //                 actions: [
  //                   InkWell(
  //                       onTap: () {
  //                         Navigator.pop(modalContext);
  //                       },
  //                       child: Container(
  //                         padding: const EdgeInsets.symmetric(
  //                             vertical: 0, horizontal: 8),
  //                         child: SvgPicture.asset(
  //                           'assets/svg/close.svg',
  //                           width: 24,
  //                           height: 24,
  //                           alignment: Alignment.center,
  //                         ),
  //                       ))
  //                 ],
  //               ),
  //               body: SingleChildScrollView(
  //                   padding: const EdgeInsets.fromLTRB(
  //                       Constants.spacing1,
  //                       Constants.spacing4,
  //                       Constants.spacing1,
  //                       Constants.spacing4),
  //                   child: Container(
  //                     child: Column(
  //                       children: [
  //                         Column(
  //                           mainAxisAlignment: MainAxisAlignment.start,
  //                           crossAxisAlignment: CrossAxisAlignment.start,
  //                           children: [
  //                             const text.Text(
  //                               "Tipe Motor",
  //                               style: TextStyle(
  //                                   fontWeight: FontWeight.bold, fontSize: 16),
  //                               textAlign: TextAlign.left,
  //                             ),
  //                             Container(
  //                               // width:
  //                               margin:
  //                                   const EdgeInsets.only(top: 10, bottom: 10),
  //                               color: Constants.white,
  //                               width: MediaQuery.of(context).size.width,
  //                               child: MultiSelectContainer(

  //                                   // singleSelectedItem: true,
  //                                   showInListView: true,
  //                                   listViewSettings: ListViewSettings(
  //                                       scrollDirection: Axis.vertical,
  //                                       shrinkWrap: true,
  //                                       physics:
  //                                           const NeverScrollableScrollPhysics(),
  //                                       separatorBuilder: (_, __) => Container(
  //                                             margin: const EdgeInsets.only(
  //                                                 top: 2, bottom: 2),
  //                                           )),
  //                                   textStyles: const MultiSelectTextStyles(
  //                                       selectedTextStyle: TextStyle(
  //                                           color: text.Color.fromARGB(
  //                                               255, 0, 0, 0),
  //                                           fontWeight: FontWeight.bold),
  //                                       textStyle: TextStyle(
  //                                           fontWeight: FontWeight.normal,
  //                                           color: text.Color.fromARGB(
  //                                               255, 2, 2, 2))),
  //                                   itemsDecoration: MultiSelectDecorations(
  //                                     decoration: BoxDecoration(
  //                                         color: Colors.black,
  //                                         gradient: LinearGradient(colors: [
  //                                           const text.Color.fromARGB(
  //                                                   255, 255, 255, 255)
  //                                               .withOpacity(0.1),
  //                                           const text.Color.fromARGB(
  //                                                   255, 255, 255, 255)
  //                                               .withOpacity(0.1),
  //                                         ]),
  //                                         border: Border.all(
  //                                             color: const text.Color.fromARGB(
  //                                                 255, 88, 88, 88)),
  //                                         borderRadius:
  //                                             BorderRadius.circular(20)),
  //                                     selectedDecoration: BoxDecoration(
  //                                         color: Colors.black,
  //                                         gradient: const LinearGradient(
  //                                             colors: [
  //                                               text.Color.fromARGB(
  //                                                   255, 250, 202, 202),
  //                                               text.Color.fromARGB(
  //                                                   255, 255, 212, 212)
  //                                             ]),
  //                                         border: Border.all(
  //                                             color: const text.Color.fromARGB(
  //                                                 255, 253, 140, 140)),
  //                                         borderRadius:
  //                                             BorderRadius.circular(20)),
  //                                     disabledDecoration: BoxDecoration(
  //                                         color: Colors.grey,
  //                                         border: Border.all(
  //                                             color: Colors.grey[500]!),
  //                                         borderRadius:
  //                                             BorderRadius.circular(20)),
  //                                   ),
  //                                   splashColor: Constants.black,
  //                                   highlightColor: Constants.black,
  //                                   items: [
  //                                     for (var component in motors)
  //                                       MultiSelectCard(
  //                                           // perpetualSelected: true,

  //                                           alignment: Alignment.centerLeft,
  //                                           margin: const EdgeInsets.only(
  //                                               top: 5, bottom: 5),
  //                                           selected: kategoribrand.contains(
  //                                                       component['id']) ==
  //                                                   true
  //                                               ? true
  //                                               : false,
  //                                           // decorations : ,
  //                                           splashColor: Constants.gray,
  //                                           highlightColor: Constants.gray,
  //                                           value: component['id'],
  //                                           label: component['name']),
  //                                   ],
  //                                   onChange: (allSelectedItems, selectedItem) {
  //                                     // setState(() {
  //                                     //   ab = a;
  //                                     // });
  //                                     filtermotor(allSelectedItems);
  //                                   }),
  //                             ),
  //                           ],
  //                         ),
  //                       ],
  //                     ),
  //                   )),
  //               bottomNavigationBar: Container(
  //                 padding: const EdgeInsets.all(12),
  //                 child: Button(
  //                   text: "Tampilkan",
  //                   fontSize: Constants.fontSizeLg,
  //                   onPressed: () {
  //                     // print(kategori);
  //                     _filtered(setState);
  //                     Navigator.pop(modalContext);
  //                   },
  //                 ),
  //               ));
  //         });
  //       }).whenComplete(() {
  //     patch().then((_filters) {
  //       setState(() {
  //         filters = _filters;
  //         kategori = kategori;
  //       });
  //     });
  //   });
  // }

  // void openSortFilters(BuildContext context) {
  //   showModalBottomSheet<dynamic>(
  //       context: context,
  //       isDismissible: true,
  //       builder: (BuildContext modalContext) {
  //         return StatefulBuilder(builder: (context, setParentState) {
  //           return Scaffold(
  //               appBar: AppBar(
  //                 automaticallyImplyLeading: false,
  //                 title: const text.Text('Pilih Urutan'),
  //                 backgroundColor: Colors.white,
  //                 foregroundColor: Colors.black,
  //                 elevation: 0,
  //                 actions: [
  //                   InkWell(
  //                       onTap: () {
  //                         Navigator.pop(modalContext);
  //                       },
  //                       child: Container(
  //                         padding: const EdgeInsets.symmetric(
  //                             vertical: 0, horizontal: 8),
  //                         child: SvgPicture.asset(
  //                           'assets/svg/close.svg',
  //                           width: 24,
  //                           height: 24,
  //                           alignment: Alignment.center,
  //                         ),
  //                       ))
  //                 ],
  //               ),
  //               body: SingleChildScrollView(
  //                   padding: const EdgeInsets.fromLTRB(
  //                       0, Constants.spacing4, 0, Constants.spacing4),
  //                   child: Container(
  //                     child: Column(
  //                       children: [
  //                         Column(
  //                           mainAxisAlignment: MainAxisAlignment.start,
  //                           crossAxisAlignment: CrossAxisAlignment.start,
  //                           children: [
  //                             Container(
  //                               margin: const EdgeInsets.only(
  //                                   top: Constants.spacing2),
  //                               width: double.infinity,
  //                               child: Container(
  //                                 child: Column(
  //                                   children: [
  //                                     for (var component in sorts)
  //                                       GestureDetector(
  //                                         onTap: () {
  //                                           setParentState(() {
  //                                             idSorts = component['id'];
  //                                             namaawal = component['text'];
  //                                           });
  //                                         },
  //                                         child: Container(
  //                                           margin: const EdgeInsets.only(
  //                                               bottom: Constants.spacing1),
  //                                           color: idSorts == component['id']
  //                                               ? Constants
  //                                                   .primaryColor.shade300
  //                                               : Constants.white,
  //                                           width: double.infinity,
  //                                           padding: const EdgeInsets.all(
  //                                               Constants.spacing4),
  //                                           child: Text(
  //                                             component['text'],
  //                                             style: TextStyle(
  //                                               color:
  //                                                   idSorts == component['id']
  //                                                       ? Constants.white
  //                                                       : Constants.black,
  //                                             ),
  //                                           ),
  //                                         ),
  //                                       )
  //                                   ],
  //                                 ),
  //                               ),
  //                             ),
  //                           ],
  //                         ),
  //                       ],
  //                     ),
  //                   )),
  //               bottomNavigationBar: Container(
  //                 padding: const EdgeInsets.all(12),
  //                 child: Button(
  //                   text: "Tampilkan",
  //                   fontSize: Constants.fontSizeLg,
  //                   onPressed: () {
  //                     setParentState(() {
  //                       sorting = namaawal;
  //                     });
  //                     // print(kategori);
  //                     _filtered(setParentState);
  //                     Navigator.pop(modalContext);
  //                   },
  //                 ),
  //               ));
  //         });
  //       }).whenComplete(() {
  //     patch().then((_filters) {
  //       setState(() {
  //         filters = _filters;
  //       });
  //     });
  //   });
  // }

  // //rangeharga

  // void openPriceFilters(BuildContext context) {
  //   dynamic sortReview =
  //       (priceRangesOpt as List).map((item) => item as String).toList();

  //   // print(priceRanges);
  //   double as =
  //       (priceRanges[1].toInt()).toInt() / (priceRanges[2].toInt()).toInt();

  //   int valueawal = rangeValueStart != 0 ? rangeValueStart : priceRanges[0];
  //   int valueakhir =
  //       rangeValueEnd != 1000000000 ? rangeValueEnd : priceRanges[1];
  //   _currentRangeValues =
  //       RangeValues(valueawal.toDouble(), valueakhir.toDouble());

  //   showModalBottomSheet<dynamic>(
  //       context: context,
  //       isDismissible: true,
  //       builder: (BuildContext modalContext) {
  //         return StatefulBuilder(builder: (context, setParentState) {
  //           return Scaffold(
  //               appBar: AppBar(
  //                 automaticallyImplyLeading: false,
  //                 title: const text.Text('Filter Harga'),
  //                 backgroundColor: Colors.white,
  //                 foregroundColor: Colors.black,
  //                 elevation: 0,
  //                 actions: [
  //                   InkWell(
  //                       onTap: () {
  //                         Navigator.pop(modalContext);
  //                       },
  //                       child: Container(
  //                         padding: const EdgeInsets.symmetric(
  //                             vertical: 0, horizontal: 8),
  //                         child: SvgPicture.asset(
  //                           'assets/svg/close.svg',
  //                           width: 24,
  //                           height: 24,
  //                           alignment: Alignment.center,
  //                         ),
  //                       ))
  //                 ],
  //               ),
  //               body: SingleChildScrollView(
  //                   padding: const EdgeInsets.fromLTRB(4, 16, 4, 16),
  //                   child: Container(
  //                     child: Column(
  //                       children: [
  //                         Container(
  //                           child: Column(
  //                             mainAxisAlignment: MainAxisAlignment.start,
  //                             crossAxisAlignment: CrossAxisAlignment.start,
  //                             children: [
  //                               Container(
  //                                 margin: const EdgeInsets.fromLTRB(
  //                                     Constants.spacing4,
  //                                     Constants.spacing4,
  //                                     Constants.spacing4,
  //                                     Constants.spacing2),
  //                                 child: const text.Text(
  //                                   "Custom Harga",
  //                                   style: TextStyle(
  //                                     fontFamily: Constants.primaryFontBold,
  //                                   ),
  //                                   textAlign: TextAlign.left,
  //                                 ),
  //                               ),
  //                               Container(
  //                                 color: Constants.white,
  //                                 child: RangeSlider(
  //                                   values: _currentRangeValues,
  //                                   activeColor:
  //                                       Constants.primaryColor.shade300,
  //                                   inactiveColor: Constants.gray.shade300,
  //                                   max: priceRanges[1].toDouble(),
  //                                   divisions: as.round(),
  //                                   labels: RangeLabels(
  //                                     _currentRangeValues.start
  //                                         .round()
  //                                         .toString(),
  //                                     _currentRangeValues.end
  //                                         .round()
  //                                         .toString(),
  //                                   ),
  //                                   onChanged: (RangeValues values) {
  //                                     setParentState(() {
  //                                       _currentRangeValues = values;
  //                                       rangeValueStart =
  //                                           _currentRangeValues.start.round();
  //                                       rangeValueEnd =
  //                                           _currentRangeValues.end.round();
  //                                       filterPriceStringDialog =
  //                                           "$rangeValueStart"
  //                                           "-"
  //                                           "$rangeValueEnd";
  //                                     });
  //                                   },
  //                                   onChangeEnd: (value) {
  //                                     filteredDialog(setParentState);

  //                                     countsfilter = countsfilter;
  //                                   },
  //                                 ),
  //                               ),
  //                               Container(
  //                                 margin: const EdgeInsets.symmetric(
  //                                     horizontal: Constants.spacing4,
  //                                     vertical: Constants.spacing2),
  //                                 child: Row(
  //                                   mainAxisAlignment:
  //                                       MainAxisAlignment.spaceBetween,
  //                                   crossAxisAlignment:
  //                                       CrossAxisAlignment.start,
  //                                   children: [
  //                                     text.Text(
  //                                       _currentRangeValues.start
  //                                           .round()
  //                                           .toString(),
  //                                       style: const TextStyle(
  //                                           fontWeight: FontWeight.normal,
  //                                           fontSize: 14),
  //                                       textAlign: TextAlign.left,
  //                                     ),
  //                                     text.Text(
  //                                       _currentRangeValues.end
  //                                           .round()
  //                                           .toString(),
  //                                       style: const TextStyle(
  //                                           fontWeight: FontWeight.normal,
  //                                           fontSize: 14),
  //                                       textAlign: TextAlign.left,
  //                                     ),
  //                                   ],
  //                                 ),
  //                               ),
  //                             ],
  //                           ),
  //                         ),
  //                         Row(
  //                           children: [
  //                             Expanded(
  //                               child: Container(
  //                                 margin: const EdgeInsets.fromLTRB(
  //                                     Constants.spacing4,
  //                                     Constants.spacing4,
  //                                     Constants.spacing4,
  //                                     Constants.spacing2),
  //                                 child: const text.Text(
  //                                   "Range Harga",
  //                                   style: TextStyle(
  //                                     fontFamily: Constants.primaryFontBold,
  //                                   ),
  //                                   textAlign: TextAlign.left,
  //                                 ),
  //                               ),
  //                             ),
  //                           ],
  //                         ),
  //                         Container(
  //                           // color: Constants.white,
  //                           width: double.infinity,
  //                           child: Container(
  //                             child: Column(
  //                               children: [
  //                                 for (var component in sortReview)
  //                                   GestureDetector(
  //                                     onTap: () {
  //                                       setParentState(() {
  //                                         final tagName = component;
  //                                         final split = tagName.split('-');
  //                                         final Map<int, String> values = {
  //                                           for (int i = 0;
  //                                               i < split.length;
  //                                               i++)
  //                                             i: split[i]
  //                                         };
  //                                         final value1 = values[0];
  //                                         final value2 = values[1];

  //                                         _currentRangeValues = RangeValues(
  //                                             double.parse(value1!),
  //                                             double.parse(value2!));
  //                                         // print(_currentRangeValues);

  //                                         filterPriceStringDialog = component;

  //                                         filteredDialog(setParentState);

  //                                         countsfilter = countsfilter;

  //                                         // idSorts = component['id'];
  //                                         // namaawal = component['text'];
  //                                       });
  //                                     },
  //                                     child: Container(
  //                                       margin: const EdgeInsets.only(
  //                                           bottom: Constants.spacing1),
  //                                       color: component == filterPriceString
  //                                           ? Constants.primaryColor.shade300
  //                                           : Constants.white,
  //                                       width: double.infinity,
  //                                       padding: const EdgeInsets.all(
  //                                           Constants.spacing4),
  //                                       child: Text(
  //                                         component,
  //                                         style: TextStyle(
  //                                           color:
  //                                               component == filterPriceString
  //                                                   ? Constants.white
  //                                                   : Constants.black,
  //                                         ),
  //                                       ),
  //                                     ),
  //                                   )
  //                               ],
  //                             ),
  //                           ),
  //                         ),
  //                       ],
  //                     ),
  //                   )),
  //               bottomNavigationBar: Container(
  //                 padding: const EdgeInsets.all(12),
  //                 child: Button(
  //                   state: countsfilter == 0
  //                       ? ButtonState.disabled
  //                       : ButtonState.normal,
  //                   text: countsfilter == 99
  //                       ? "Filter"
  //                       : countsfilter == 0
  //                           ? "Tidak ada data"
  //                           : "Filter ($countsfilter)",
  //                   fontSize: Constants.fontSizeLg,
  //                   onPressed: countsfilter == 0
  //                       ? null
  //                       : () {
  //                           rangeValueStart = _currentRangeValues.start.round();
  //                           rangeValueEnd = _currentRangeValues.end.round();
  //                           filterPriceString = filterPriceStringDialog;
  //                           _filtered(setParentState);
  //                           Navigator.pop(modalContext);
  //                         },
  //                 ),
  //               ));
  //         });
  //       }).whenComplete(() {
  //     // patch().then((_filters) {
  //     //   setState(() {
  //     //     filters = _filters;
  //     //     // kategori = kategori;
  //     //   });
  //     // });
  //   });
  // }

  // This function will be triggered whenver the user scroll
  // to near the bottom of the list view
  void _loadMore() async {
    if (_hasNextPage == true &&
        _isFirstLoadRunning == false &&
        _isLoadMoreRunning == false &&
        _controller.position.extentAfter < 300) {
      setState(() {
        _isLoadMoreRunning = true; // Display a progress indicator at the bottom
      });
      _page += 1; // Increase _page by 1

      try {
        
        var params = {
          'page': _page,
          // 'sorts': urutan,
          'limit': 20
        };
        Response res = await _dio.get(Endpoint.userList, queryParameters: params);
        // final List fetchedPosts = json.decode(res.data);
        var nextItems = res.data['data'] as List;
        List fetchedPosts = nextItems.map((item) => item).toList();
        if (fetchedPosts.isNotEmpty) {
          setState(() {
            _posts.addAll(fetchedPosts);
          });
        } else {
          // This means there is no more data
          // and therefore, we will not send another GET request
          setState(() {
            _hasNextPage = false;
          });
        }
      } on DioException catch (err) {
        dynamic errors = DioExceptions.fromDioError(err);
        if (errors != null) {
          if (errors.message == "No Internet") {
            setState(() {
              state = -2;
            });
          } else {
            setState(() {
              state = -1;
            });
          }
        }
      }

      setState(() {
        _isLoadMoreRunning = false;
      });
    }
  }

  // The controller for the ListView
  // ScrollController _controller;
  ScrollController _controller = ScrollController();
  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async{
    await readMap().then((value) => setState(() {
        _posts = [value];
      }));
      // _firstLoad();
      // patch().then((obj) {
      //   setState(() {
      //     banners = obj['banners'];
      //     motors = obj['motors'];
      //     brands = obj['brands'];
      //     sorts = obj['sorts'];
      //     priceRanges = obj['priceRanges'];
      //     priceRangesOpt = obj['priceRangesOpt'];
      //   });
      // });
      _controller = ScrollController()..addListener(_loadMore);
    });
  }

  @override
  void dispose() {
    _controller.removeListener(_loadMore);
    super.dispose();
  }
  Future<void> saveMap(Map<String, dynamic> data) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = jsonEncode(data);
    prefs.setString('form', jsonString);
  }

    Future<Map<String, dynamic>> readMap() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString('liked');
    if (jsonString == null) {
      return {};
    }
    return jsonDecode(jsonString);
  }

  Widget renderImage(Map image) {
    String imageUrl = image['imageUrl'];
    String target = image['target'];
    final appImageUrl = imageUrl.substring(0, imageUrl.indexOf(','));

    return GestureDetector(
      onTap: () {},
      child: Container(
        margin: const EdgeInsets.all(0),
        child: InteractiveViewer(
          child: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: CachedNetworkImageProvider(appImageUrl),
                    fit: BoxFit.cover)),
          ),
        ),
      ),
    );
  }

  Widget filter() {
    return Container(
      // margin: EdgeInsets.only(left: 10),
      width: MediaQuery.of(context).size.width,
      // margin: EdgeInsets.only(top: 20),
      height: MediaQuery.of(context).size.width * 0.17,
      color: Constants.white,

      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            for (var component in motors)
              InkWell(
                onTap: () {
                  // viewModel.updateSpesifikasi(
                  //     component);
                },
                child: Container(
                  margin: const EdgeInsets.only(left: 15),
                  padding: const EdgeInsets.only(
                      top: 10.0, left: 10.0, bottom: 5.0, right: 10.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Constants.primaryColor,
                  ),
                  child: text.Text(
                    component['name'].toString(),
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Constants.white,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  // Widget filtersmotor() {
  //   return Row(
  //     children: [
  //       InkWell(
  //         onTap: () {
  //           openTypeFilters(context);
  //         },
  //         child: Container(
  //           margin: const EdgeInsets.only(left: 15),
  //           decoration: BoxDecoration(
  //               border: Border.all(color: Colors.grey[500]!),
  //               color: Constants.gray.shade100,
  //               borderRadius: const BorderRadius.all(Radius.circular(12))),
  //           padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
  //           child: Row(
  //             children: [
  //               const text.Text('Motor'),
  //               SvgPicture.asset(
  //                 'assets/svg/chevron_down.svg',
  //                 width: 19,
  //                 height: 19,
  //                 alignment: Alignment.center,
  //                 color: Constants.gray.shade400,
  //               )
  //             ],
  //           ),
  //         ),
  //       ),
  //     ],
  //   );
  // }

  // Widget filterscategory() {
  //   return Container(
  //     padding: const EdgeInsets.symmetric(
  //         horizontal: Constants.spacing4, vertical: Constants.spacing2),
  //     color: Constants.white,
  //     margin: const EdgeInsets.only(
  //       top: Constants.spacing4,
  //     ),
  //     child: Container(
  //       child: Row(
  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //         children: [
  //           Row(
  //             children: [
  //               InkWell(
  //                 onTap: () {
  //                   List brandss = (filters['brands'] as List)
  //                       .map((item) => item as Map)
  //                       .toList();
  //                   List motors = (filters['motors'] as List)
  //                       .map((item) => item as Map)
  //                       .toList();
  //                   List sorts = (filters['sorts'] as List)
  //                       .map((item) => item as Map)
  //                       .toList();

  //                   openTypeFilterscategory(context);
  //                 },
  //                 child: Container(
  //                   margin: const EdgeInsets.only(right: Constants.spacing2),
  //                   decoration: BoxDecoration(
  //                       border: Border.all(color: Constants.gray.shade200),
  //                       color: Constants.gray.shade100,
  //                       borderRadius:
  //                           const BorderRadius.all(Radius.circular(12))),
  //                   padding: const EdgeInsets.symmetric(
  //                       vertical: Constants.spacing2,
  //                       horizontal: Constants.spacing4),
  //                   child: Row(
  //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                     children: [
  //                       text.Text('Motor',
  //                           style: TextStyle(color: Constants.gray.shade500)),
  //                       SvgPicture.asset(
  //                         'assets/svg/chevron_down.svg',
  //                         width: 19,
  //                         height: 19,
  //                         color: Constants.gray.shade500,
  //                         alignment: Alignment.center,
  //                       )
  //                     ],
  //                   ),
  //                 ),
  //               ),
  //               InkWell(
  //                 onTap: () {
  //                   openPriceFilters(context);
  //                   List priceRanges =
  //                       (filters['priceRanges'] as List).toList();
  //                   List priceRangesOpt =
  //                       (filters['priceRangesOpt'] as List).toList();
  //                 },
  //                 child: Container(
  //                   margin: const EdgeInsets.only(left: Constants.spacing1),
  //                   decoration: BoxDecoration(
  //                       border: Border.all(color: Constants.gray.shade200),
  //                       color: Constants.gray.shade100,
  //                       borderRadius:
  //                           const BorderRadius.all(Radius.circular(12))),
  //                   padding:
  //                       const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
  //                   child: Row(
  //                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //                     children: [
  //                       text.Text('Harga',
  //                           style: TextStyle(color: Constants.gray.shade500)),
  //                       SvgPicture.asset(
  //                         'assets/svg/chevron_down.svg',
  //                         width: 19,
  //                         height: 19,
  //                         alignment: Alignment.center,
  //                         color: Constants.gray.shade500,
  //                       )
  //                     ],
  //                   ),
  //                 ),
  //               ),
  //             ],
  //           ),
  //           InkWell(
  //             onTap: () {
  //               openSortFilters(context);

  //               List sorts = (filters['sorts'] as List)
  //                   .map((item) => item as Map)
  //                   .toList();
  //               // print("sorts $sorts");
  //             },
  //             child: Container(
  //               // margin: EdgeInsets.only(right: 15),
  //               decoration: BoxDecoration(
  //                   border: Border.all(color: Constants.gray.shade200),
  //                   color: Constants.gray.shade100,
  //                   borderRadius: const BorderRadius.all(Radius.circular(12))),
  //               padding:
  //                   const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
  //               child: Row(
  //                 children: [
  //                   text.Text(sorting != "" ? sorting : "Pilih Urutan",
  //                       style: TextStyle(color: Constants.gray.shade500)),
  //                   SvgPicture.asset(
  //                     'assets/svg/chevron_down.svg',
  //                     width: 19,
  //                     height: 19,
  //                     alignment: Alignment.center,
  //                     color: Constants.gray.shade500,
  //                   )
  //                 ],
  //               ),
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  Widget listitem() {
    int defaultcolor = 0xffBC4747;
    final formatter = intl.NumberFormat.decimalPattern();
    return Container(
      color: Constants.white,
      margin: const EdgeInsets.only(
        top: Constants.spacing4,
      ),
      child: Column(
        children: [
          // Container(
          //   margin: const EdgeInsets.all(Constants.spacing4),
          //   child: GridView.count(
          //     shrinkWrap: true,
          //     physics: const NeverScrollableScrollPhysics(),
          //     padding: const EdgeInsets.fromLTRB(Constants.spacing2,
          //         Constants.spacing3, Constants.spacing2, Constants.spacing2),
          //     crossAxisSpacing: Constants.spacing5,
          //     mainAxisSpacing: Constants.spacing5,
          //     childAspectRatio: 0.46,
          //     crossAxisCount: 2,
          //     children: List.generate(_posts.length,
          //         (index) => SparepartItemComponent(_posts[index])),
          //   ),
          // ),
          if (_isLoadMoreRunning == true)
            const Padding(
              padding: EdgeInsets.only(top: 10, bottom: 40),
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          if (_hasNextPage == false) Container(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget buildItem(item, index) {
      return item != null
          ? Container(
              margin: index % 2 == 0
                  ? const EdgeInsets.only(
                      right: Constants.spacing4,
                      top: Constants.spacing4,
                    )
                  : const EdgeInsets.only(top: Constants.spacing4),
              width: MediaQuery.of(context).size.width * 0.43,
              child: UserItemComponent(item),
              // child: Container(
              //   child: Text(item['firstName']),
              // ),
            )
          : Container(
              decoration: BoxDecoration(
                  color: Constants.gray.shade200,
                  borderRadius: const BorderRadius.all(
                      Radius.circular(Constants.spacing3))),
            );
    }

    List<Widget> items = [];
    if (_posts != null) {
      for (var i = 0; i < _posts.length; i++) {
        items.add(
          buildItem(_posts[i], i),
        );
      }
    }
    Widget buildGridItem() {
      return Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.only(bottom: Constants.spacing4),
        color: Constants.white,
        child: Container(
          child: Wrap(
            crossAxisAlignment: WrapCrossAlignment.start,
            alignment: WrapAlignment.center,
            runAlignment: WrapAlignment.center,
            children: items,
          ),
        ),
      );
    }

    int defaultcolor = 0xffBC4747;

    final formatter = intl.NumberFormat.decimalPattern();
    return Scaffold(
                extendBodyBehindAppBar: true,
                body: NestedScrollView(
                  floatHeaderSlivers: true,
                  headerSliverBuilder:
                      (BuildContext context, bool innerBoxIsScrolled) {
                    return <Widget>[
                      // bottom
                      SliverAppBar(
                        automaticallyImplyLeading: false,
                        elevation: 0,
                        floating: true,
                        pinned: true,
                        toolbarHeight: 66,
                        backgroundColor: Constants.white,
                        // flexibleSpace: AppbarGradient(
                        //   warna: Constants.black,
                        //   isBack: true,
                        // ),
                      ),
                    ];
                  },
                  body: _isFirstLoadRunning
                      ? const Center(
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                          ),
                        )
                      : CustomRefreshIndicator(
                          builder: MaterialIndicatorDelegate(
                            builder: (context, controller) {
                              return IconRefreshIndicator();
                            },
                          ),
                          key: widget._refreshIndicatorKey,
                          onRefresh: () async {
                            // Replace this delay with the code to be executed during refresh
                            // and return a Future when code finishs execution.
                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              reset();
                              _firstLoad();
                              // patch().then((obj) {
                              //   setState(() {
                              //     banners = obj['banners'];
                              //     motors = obj['motors'];
                              //     brands = obj['brands'];
                              //     sorts = obj['sorts'];
                              //     priceRanges = obj['priceRanges'];
                              //     priceRangesOpt = obj['priceRangesOpt'];
                              //   });
                              // });
                              _controller = ScrollController()
                                ..addListener(_loadMore);
                            });
                          },
                          child: SingleChildScrollView(
                            controller: _controller,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                // carousel(),
                                // filterscategory(),
                                // listitem(),
                                Column(
                                  children: [
                                    buildGridItem(),
                                    if (_isLoadMoreRunning == true)
                                      const Padding(
                                        padding: EdgeInsets.only(
                                            top: 10, bottom: 40),
                                        child: Center(
                                          child: CircularProgressIndicator(),
                                        ),
                                      ),
                                    if (_hasNextPage == false) Container(),
                                  ],
                                ),
                                const SizedBox(
                                  height: 50,
                                )
                              ],
                            ),
                          ),
                        ),
                ));
  }
}
