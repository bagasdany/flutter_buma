// main.dart
// ignore_for_file: avoid_unnecessary_containers

import 'dart:async';

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




class UserList extends StatefulWidget {
  int? id;
  Map? data;
  UserList({Key? key, this.id,this.data}) : super(key: key);
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  @override
  _UserListState createState() => _UserListState();
}

class _UserListState extends State<UserList> {
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
        widget.data = {"data": _posts};
        print("cek");
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

    WidgetsBinding.instance.addPostFrameCallback((_) {
     if(widget.data == null) {

      _firstLoad();
     }else{
      setState(() {
      _posts = widget.data?['data'];
      });
     }
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
                        toolbarHeight: 60,
                        backgroundColor: Constants.white,
                        title: Container(
                          padding: EdgeInsets.symmetric(horizontal: Constants.spacing4),
                          child: Text("All User List")),
                        
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
