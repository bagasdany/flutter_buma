// ignore_for_file: must_be_immutable, unnecessary_null_comparison, avoid_function_literals_in_foreach_calls, use_build_context_synchronously

import 'dart:async';

import 'package:buma/application/services/dio_service.dart';
import 'package:buma/infrastructure/apis/user_api.dart';
import 'package:buma/ui/component/app_shimmer.dart';
import 'package:buma/ui/component/button.dart';
import 'package:buma/ui/component/icon_refresh_indicator.dart';
import 'package:buma/ui/component/zoom_interactive.dart';
import 'package:buma/ui/style/constants.dart';
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart' as intl;
import 'package:intl/intl.dart';
import '../../../../infrastructure/database/shared_prefs.dart';
import '../../../infrastructure/database/shared_prefs_key.dart';

class UserDetail extends StatefulWidget {
  dynamic id;
  int? cityId;
  Map? user, queryUrl;
  UserDetail({
    Key? key,
    this.user,
    this.queryUrl,
    this.id,
  }) : super(key: key);

  @override
  _UserDetail createState() => _UserDetail();
}

class _UserDetail extends State<UserDetail> {
  late TransformationController controller;
  late AnimationController animationController;
  Animation<Matrix4>? animation;
  final dataKey = GlobalKey();
  final Dio _dio = DioService.getInstance();
  final formatter = intl.NumberFormat.decimalPattern();
  bool isChangedReferral = false;

  ScrollController scrollController = ScrollController();
  String imageUrl = '';
  int stateVoucher = 1;
  dynamic codeVoucher;
  ScrollController slideController = ScrollController();

  final TextEditingController referralController = TextEditingController();

  dynamic cityId;

  int state = 1; // 1:done 2:loading 3:load price -1:error

  final _sharedPrefs = SharedPrefs();

  @override
  void initState() {
    super.initState();
    // controller = TransformationController();
    // animationController =
    //     AnimationController(vsync: this, duration: Duration(milliseconds: 200))
    //       ..addListener(() => controller.value = animation!.value);

    WidgetsBinding.instance.addPostFrameCallback((_)async {
      if(widget.user != null){
         UserApi().getUserDetail(widget.id).then((userDetail) async {
          // await SharedPrefs().set(SharedPreferencesKeys.cityId, widget.hmc?['cityId']);
          // await SharedPrefs().set(SharedPreferencesKeys.userLocation, cityName);

          // events.emit('locationChanged', cityName);

        setState(() { 
        widget.user = userDetail;
        });
        
        },
      );
      }
       else {
        setState(() {
          state = 2;
        });
       await UserApi().getUserDetail(widget.id).then((userDetail) async {
          // await SharedPrefs().set(SharedPreferencesKeys.cityId, widget.hmc?['cityId']);
          // await SharedPrefs().set(SharedPreferencesKeys.userLocation, cityName);

          // events.emit('locationChanged', cityName);

        setState(() { 
        widget.user = userDetail;
        state = 1;
        });
        
        },
      );

      
      }
    });
  }

  @override
  void dispose() {
    // controller.dispose();
    // animationController.dispose();
    super.dispose();
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  void resetAnimation() {
    animation = Matrix4Tween(
      begin: controller.value,
      end: Matrix4.identity(),
    ).animate(
        CurvedAnimation(parent: animationController, curve: Curves.easeIn));
    animationController.forward(from: 0);
  }
  // String formatDateOfBirth(String dob) {
  //   DateTime dateTime = DateTime.parse(dob);
  //   String formattedDob = DateFormat("dd MMM y").format(dateTime);
  //   return formattedDob;
  // }

  // Future<void> load(String? jenis) async {
  //   jenis == "empty"
  //       ? null
  //       : setState(() {
  //           state = 2;
  //         });

  //   dynamic cityIdPrefs = _sharedPrefs.get(SharedPreferencesKeys.cityId);
  //   if ((widget.queryUrl ?? {}).containsKey('cityId')) {
  //     setState(() {
  //       widget.cityId = widget.queryUrl?['cityId'] == null
  //           ? null
  //           : int.parse((widget.queryUrl?['cityId'] ?? ""));
  //     });
  //   }

  //   var params = {
  //     ...widget.cityId != null
  //         ? {}
  //         : cityIdPrefs == null
  //             ? {}
  //             : {"cityId": cityIdPrefs},
  //     ...widget.queryUrl ?? {}
  //   };
  //   var _page = await patch(params);
  //   if (_page == null || _page == "") {
  //     AppLog().logScreenView("Detail HMC nonaktif");
  //   } else {
  //     setState(() {
  //       if (_page != "" || _page != null) {
  //         widget.hmc = _page ?? {};
  //         if (widget.hmc?['series']['colorId'] == null) {
  //           widget.hmc?['series']['colorId'] =
  //               widget.hmc?['series']['colors'][0]['id'] ?? 111;
  //         }
  //         if (widget.hmc?['series']['selectedSpec'] == null &&
  //             widget.hmc?['series']['specifications'] != null &&
  //             (widget.hmc?['series']['specifications'] as Map).isNotEmpty) {
  //           widget.hmc?['series']['selectedSpec'] =
  //               (widget.hmc?['series']['specifications'] as Map).keys.first;
  //         }
  //         state = 1;
  //       }
  //     });
  //   }
  // }

  // Future<dynamic> patch(Map params) async {
  //   try {
  //     final response = await _dio
  //         .patch("${Endpoint.getMotordetail}/${widget.id}", data: params);
  //     if (response.data != null || response.data == "") {
  //       setState(() {
  //         state = -1;
  //       });
  //       AppLog().logScreenView("HMC nonaktif");
  //     }
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

  // Future<void> getPrice() async {
  //   try {
  //     dynamic cityId = _sharedPrefs.get(SharedPreferencesKeys.cityId);

  //     var params = {};
  //     if (widget.queryUrl?['typeId'] != null) {
  //       setState(() {
  //         widget.voucher = widget.queryUrl?['voucherId'] == null
  //             ? null
  //             : Voucher(
  //                 id: int.parse(widget.queryUrl?['voucherId'] ?? "1"),
  //                 title: widget.queryUrl?['title'] ?? "",
  //                 description: widget.queryUrl?['description'] ?? "",
  //               );
  //         widget.hmc?['creditDownPayment'] = widget
  //                     .queryUrl?['creditDownPayment'] ==
  //                 null
  //             ? null
  //             : int.parse(widget.queryUrl?['creditDownPayment'] ?? "6000000");
  //       });

  //       params = {
  //         "cityId": widget.queryUrl?['cityId'] == null
  //             ? null
  //             : int.parse(widget.queryUrl?['cityId'] ?? "158"),
  //         'typeId': widget.queryUrl?['typeId'] == null
  //             ? null
  //             : int.parse(widget.queryUrl?['typeId'] ?? ""),
  //         'paymentType': widget.queryUrl?['paymentType'] == null
  //             ? null
  //             : int.parse(widget.queryUrl?['paymentType'] ?? ""),
  //         'creditDownPayment': widget.queryUrl?['creditDownPayment'] == null
  //             ? null
  //             : int.parse(widget.queryUrl?['creditDownPayment'] ?? ""),
  //         'term': widget.queryUrl?['term'] == null
  //             ? null
  //             : int.parse(widget.queryUrl?['term'] ?? ""),
  //         'voucherId':
  //             widget.queryUrl?['voucherId'] == null ? null : widget.voucher?.id
  //       };
  //     } else {
  //       params = {
  //         ...cityId != null ? {'cityId': cityId} : {},
  //         'seriesId': widget.id,
  //         'typeId': widget.hmc?['series']['typeId'],
  //         'paymentType': widget.hmc?['paymentType'],
  //         'creditDownPayment': widget.hmc?['creditDownPayment'],
  //         'colorId': widget.hmc?['series']?['colorId'],
  //         'term': widget.hmc?['term'],
  //         ...widget.voucher?.id != null ? {'voucherId': widget.voucher?.id} : {}
  //       };
  //     }

  //     setState(() {
  //       state = 3;
  //     });
  //     dynamic response = await _dio.get("/motor/${widget.id}/price",
  //         queryParameters: Map<String, dynamic>.from(params));
  //     setState(() {
  //       (response.data as Map).forEach((key, value) {
  //         widget.hmc?[key] = value;
  //       });
  //     });
  //     if (widget.queryUrl?['typeId'] != null) {
  //       setState(() {
  //         widget.hmc?['term'] = widget.queryUrl?['term'] == null
  //             ? null
  //             : int.parse(widget.queryUrl?['term'] ?? "");
  //         widget.hmc?['creditDownPayment'] =
  //             widget.queryUrl?['creditDownPayment'] == null
  //                 ? null
  //                 : int.parse(widget.queryUrl?['creditDownPayment'] ?? "");
  //         widget.voucher = widget.queryUrl?['voucherId'] == null
  //             ? null
  //             : Voucher(
  //                 id: int.parse(widget.queryUrl?['voucherId'] ?? "1"),
  //                 title: widget.queryUrl?['title'] ?? "",
  //                 description: widget.queryUrl?['description'] ?? "",
  //               );
  //         widget.hmc?['cashPrice'] = widget.queryUrl?['cashPrice'] == null
  //             ? null
  //             : int.parse(widget.queryUrl?['cashPrice'] ?? "");
  //         widget.hmc?['paymentType'] = widget.queryUrl?['paymentType'] == null
  //             ? null
  //             : int.parse(widget.queryUrl?['paymentType'] ?? "");
  //       });
  //     }
  //     setState(() {
  //       state = 1;
  //     });
  //   } on DioException catch (e) {
  //     dynamic message = GetErrorMessage.getErrorMessage(
  //         e.response?.data['errors'] ?? "Terjadi Kesalahan Harap coba kembali");
  //     AppDialog.snackBar(text: message);
  //     setState(() {
  //       state = 1;
  //       widget.voucher = null;
  //     });
  //   }
  // }

  // Future<void> checkout(BuildContext context) async {
  //   setState(() {
  //     state = 5;
  //   });

  //   Future<void> doCheckout() async {
  //     //ADD LAT DAN LONGITUDE
  //     // MiscApi().retrieveLocation().then((value) async {
  //     //   print("value location $value");
  //     //   return value;
  //     // });
  //     int cityId = _sharedPrefs.get(SharedPreferencesKeys.cityId) ?? 158;
  //     final response = await _dio.post(Endpoint.checkout, data: {
  //       'type': 1,
  //       'cityId': cityId,
  //       'seriesId': widget.id,
  //       'typeId': widget.hmc?['series']['typeId'],
  //       'colorId': widget.hmc?['series']['colorId'],
  //       'paymentMethod': widget.hmc?['paymentType'],
  //       'price': widget.hmc?['paymentType'] == 1
  //           ? widget.hmc!['cashPrice']
  //           : widget.hmc?['creditDownPayment'],
  //       'term': widget.hmc?['term'],
  //       'referralCode': referralController.text,
  //       'voucherId': widget.voucher?.id
  //     });
  //     final order = response.data['order'];

  //     setState(() {
  //       state = 1;
  //     });

  //     Navigator.of(context).push(MaterialPageRoute(builder: (_) {
  //       return HMCCheckout1(order);
  //     }));
  //   }

  //   try {
  //     await doCheckout();
  //   } on SignInRequiredException {
  //     setState(() {
  //       state = 1;
  //     });
  //     Navigator.of(context).push(MaterialPageRoute(
  //         builder: (_) => LoginView(onSuccess: () async {
  //           setState(() {
  //     state = 5;
  //   });
  //               await doCheckout().then((value) {
  //                 setState(() {
  //     state = 1;
  //   });
  //               });
  //             })));
  //   } on DioException catch (e) {
  //     String errorMessage =
  //         GetErrorMessage.getErrorMessage(e.response?.data['errors']);
  //     AppDialog.snackBar(text: errorMessage);
  //     setState(() {
  //       state = 1;
  //     });
  //   }
  // }

  Widget buildImage() {
    if (widget.user != null) {
      

      imageUrl = widget.user?['picture'] != null 
          ? "${widget.user?['picture'] ?? ""}"
          : '';
    }

    return Column(
      children: [
        ClipOval(
          
          child: SizedBox(
            width: MediaQuery.of(context).size.width *0.4,
           
            child: ZoomInteractive(
              aspectRatio: 1/1,
              url: imageUrl,
              state: state,
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: Constants.spacing2),
          child: AppShimmer(
          
          active: state ==2,
          
          child: Container(

          padding: const EdgeInsets.symmetric(horizontal: Constants.spacing3,vertical: Constants.spacing1),
            color: Constants.white,
          child: 
          
           Text(state == 2 ? "Memuat data user" : "${(widget.user?['title'] ?? "")} ${(widget.user?['firstName'] ?? "")} ${(widget.user?['lastName'] ?? "") ?? "Nama Disembunyikan"}",
                                    overflow: TextOverflow.ellipsis,
                                    style:  TextStyle(
                                      fontFamily: Constants.primaryFontBold,
                                      color: Constants.primaryBlack.shade500,
                                        fontSize: Constants.fontSizeLg),textAlign: TextAlign.center,
                                  ))),)
      ],
    );
  }

  Widget buildDescriptionUser(){
    return Container(
      color: Constants.white,
      margin: const EdgeInsets.only(top: Constants.spacing3),
     padding: const EdgeInsets.fromLTRB(0,0, 0, Constants.spacing4),
      child: Column(
        children: [
          Container(
            // margin: const EdgeInsets.only(bottom: Constants.spacing2),
            padding: const EdgeInsets.fromLTRB(Constants.spacing4, Constants.spacing4, Constants.spacing4, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AppShimmer(
                  active: state == 2,
                  child: Container(
                
                  padding: const EdgeInsets.fromLTRB(0, 0, Constants.spacing2, 0),
                    color: Constants.white,
                  child: Text(state == 2 ? "Gender" : "Gender :",
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                              fontFamily: Constants.primaryFontBold,
                                                fontSize: Constants.fontSizeMd),textAlign: TextAlign.center,
                                          )),
                ),
                AppShimmer(
                  active: state == 2,
                  child: Container(
          
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                
                  // padding: EdgeInsets.symmetric(horizontal: Constants.spacing3,vertical: Constants.spacing1),
                    color: Constants.white,
                  child: 
                  
                   Text(state == 2 ? "Memuat data user" : "${(widget.user?['gender'] ?? "-")}",
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                              // fontFamily: Constants.primaryFontBold,
                                                fontSize: Constants.fontSizeMd),textAlign: TextAlign.center,
                                          )),
                ),
              ],
            ),
          ),

          (widget.user?['dateOfBirth'] == null && state != 2) ? Container() :
          Container(
            margin: const EdgeInsets.only(bottom: Constants.spacing2),
            padding: const EdgeInsets.fromLTRB(Constants.spacing4, Constants.spacing4, Constants.spacing4, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppShimmer(
                  active: state == 2,
                  child: Container(
                
                  padding: const EdgeInsets.fromLTRB(0, 0, Constants.spacing2, 0),
                    color: Constants.white,
                  child: Text(state == 2 ? "Date of birth" : "Date of birth :",
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                              fontFamily: Constants.primaryFontBold,
                                                fontSize: Constants.fontSizeMd),textAlign: TextAlign.center,
                                          )),
                ),
                AppShimmer(
                  active: state == 2,
                  child: Container(
          
                  // padding: const EdgeInsets.fromLTRB(Constants.spacing1, 0, 0, 0),
                
                  // padding: EdgeInsets.symmetric(horizontal: Constants.spacing3,vertical: Constants.spacing1),
                    color: Constants.white,
                  child: 
                  // (DateFormat("dd MMM y").format(DateTime.parse(widget.user?['dateOfBirth]))
                   Text(state == 2 ? "Memuat data user" : "${(DateFormat("dd MMM y").format(DateTime.parse(widget.user?['dateOfBirth'] ?? "1976-10-02T17:55:48.463Z")))}",
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                              // fontFamily: Constants.primaryFontBold,
                                                fontSize: Constants.fontSizeMd),textAlign: TextAlign.center,
                                          )),
                ),
              ],
            ),
          ),
          widget.user?['registerDate'] == null && state != 2 ? Container() :
          Container(
            margin: const EdgeInsets.only(bottom: Constants.spacing2),
            padding: const EdgeInsets.fromLTRB(Constants.spacing4, Constants.spacing4, Constants.spacing4, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppShimmer(
                  active: state == 2,
                  child: Container(
                
                  padding: const EdgeInsets.fromLTRB(0, 0, Constants.spacing2, 0),
                    color: Constants.white,
                  child: Text(state == 2 ? "Join From" : "Join From :",
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                              fontFamily: Constants.primaryFontBold,
                                                fontSize: Constants.fontSizeMd),textAlign: TextAlign.center,
                                          )),
                ),
                AppShimmer(
                  active: state == 2,
                  child: Container(
          
                  // padding: const EdgeInsets.fromLTRB(Constants.spacing1, 0, 0, 0),
                
                  // padding: EdgeInsets.symmetric(horizontal: Constants.spacing3,vertical: Constants.spacing1),
                    color: Constants.white,
                  child: 
                  // (DateFormat("dd MMM y").format(DateTime.parse(widget.user?['dateOfBirth]))
                   Text(state == 2 ? "Memuat data user" : "${(DateFormat("dd MMM y").format(DateTime.parse(widget.user?['registerDate'] ?? "2021-06-21T21:02:14.440Z")))}",
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                              // fontFamily: Constants.primaryFontBold,
                                                fontSize: Constants.fontSizeMd),textAlign: TextAlign.center,
                                          )),
                ),
              ],
            ),
          ),
          widget.user?['email'] == null && state != 2 ? Container() :
          Container(
            margin: const EdgeInsets.only(bottom: Constants.spacing2),
            padding: const EdgeInsets.fromLTRB(Constants.spacing4, Constants.spacing4, Constants.spacing4, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppShimmer(
                  active: state == 2,
                  child: Container(
                
                  padding: const EdgeInsets.fromLTRB(0, 0, Constants.spacing2, 0),
                    color: Constants.white,
                  child: Text(state == 2 ? "Email" : "Email :",
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                              fontFamily: Constants.primaryFontBold,
                                                fontSize: Constants.fontSizeMd),textAlign: TextAlign.center,
                                          )),
                ),
                Expanded(
                  child: AppShimmer(
                    active: state == 2,
                    child: Container(
                          
                    // padding: const EdgeInsets.fromLTRB(Constants.spacing1, 0, 0, 0),
                  
                    // padding: EdgeInsets.symmetric(horizontal: Constants.spacing3,vertical: Constants.spacing1),
                      color: Constants.white,
                    child: 
                    // (DateFormat("dd MMM y").format(DateTime.parse(widget.user?['dateOfBirth]))
                     Text(state == 2 ? "Memuat data user" : "${widget.user?['email'] ?? "-"}",
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                // fontFamily: Constants.primaryFontBold,
                                                  fontSize: Constants.fontSizeMd),textAlign: TextAlign.start,maxLines: 3,
                                            )),
                  ),
                ),
              ],
            ),
          ),
          widget.user?['location'] == null && state != 2 ? Container() :
          Container(
            margin: const EdgeInsets.only(bottom: Constants.spacing2),
            padding: const EdgeInsets.fromLTRB(Constants.spacing4, Constants.spacing4, Constants.spacing4, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppShimmer(
                  active: state == 2,
                  child: Container(
                
                  padding: const EdgeInsets.fromLTRB(0, 0, Constants.spacing2, 0),
                    color: Constants.white,
                  child: Text(state == 2 ? "Address" : "Address :",
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                              fontFamily: Constants.primaryFontBold,
                                                fontSize: Constants.fontSizeMd),textAlign: TextAlign.start,
                                          )),
                ),
                Expanded(
                  child: AppShimmer(
                    active: state == 2,
                    child: Container(
                            
                    // padding: const EdgeInsets.fromLTRB(Constants.spacing1, 0, 0, 0),
                                  
                    // padding: EdgeInsets.symmetric(horizontal: Constants.spacing3,vertical: Constants.spacing1),
                      color: Constants.white,
                    child: 
                    // (DateFormat("dd MMM y").format(DateTime.parse(widget.user?['dateOfBirth]))
                     Text(state == 2 ? "Memuat data user" : "${widget.user?['location']?['country'] ?? ""},${widget.user?['location']?['state'] ?? ""},${widget.user?['location']?['city'] ?? ""},${widget.user?['location']?['street'] ?? ""}",
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                
                                                // fontFamily: Constants.primaryFontBold,
                                                  fontSize: Constants.fontSizeMd),textAlign: TextAlign.start,maxLines: 3,
                                            )),
                  ),
                ),
              ],
            ),
          ),
          widget.user?['location'] == null && state != 2 ? Container() :
          Container(
            margin: const EdgeInsets.only(bottom: Constants.spacing2),
            padding: const EdgeInsets.fromLTRB(Constants.spacing4, Constants.spacing4, Constants.spacing4, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppShimmer(
                  active: state == 2,
                  child: Container(
                
                  padding: const EdgeInsets.fromLTRB(0, 0, Constants.spacing2, 0),
                    color: Constants.white,
                  child: Text(state == 2 ? "Phone" : "Phone :",
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                              fontFamily: Constants.primaryFontBold,
                                                fontSize: Constants.fontSizeMd),textAlign: TextAlign.start,
                                          )),
                ),
                Expanded(
                  child: AppShimmer(
                    active: state == 2,
                    child: Container(
                            
                    // padding: const EdgeInsets.fromLTRB(Constants.spacing1, 0, 0, 0),
                                  
                    // padding: EdgeInsets.symmetric(horizontal: Constants.spacing3,vertical: Constants.spacing1),
                      color: Constants.white,
                    child: 
                    // (DateFormat("dd MMM y").format(DateTime.parse(widget.user?['dateOfBirth]))
                     Text(state == 2 ? "Memuat data user" : "${widget.user?['phone'] ?? ""}",
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                
                                                // fontFamily: Constants.primaryFontBold,
                                                  fontSize: Constants.fontSizeMd),textAlign: TextAlign.start,maxLines: 3,
                                            )),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
  

  Widget buildTypeItem(child, active) {
    return Container(
      padding: const EdgeInsets.all(Constants.spacing2),
      color: active ? Colors.white : Constants.gray.shade100,
      child: child,
    );
  }

 

  @override
  Widget build(BuildContext context) {

    // TODO Add Network Page
    return Scaffold(
          appBar: 
          AppBar(
            toolbarHeight: 67,
            title: Container(
                          padding: EdgeInsets.symmetric(horizontal: Constants.spacing4),
                          child: Text("Detail")),
            automaticallyImplyLeading: false,
            shadowColor: Colors.transparent,
            backgroundColor: Constants.white,
            leading: InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            padding: EdgeInsets.only(left: Constants.spacing4),
                            child: Icon(Icons.arrow_back,color: Constants.black,)),
                        ),
            flexibleSpace: Container()),
            body: CustomRefreshIndicator(
              builder: MaterialIndicatorDelegate(
                builder: (context, controller) {
                  return IconRefreshIndicator();
                },
              ),
              onRefresh: () async{
                setState(() {
                  setState(() { 
                    state = 2;
                  });
                  UserApi().getUserDetail(widget.id).then((userDetail) async {
          // await SharedPrefs().set(SharedPreferencesKeys.cityId, widget.hmc?['cityId']);
          // await SharedPrefs().set(SharedPreferencesKeys.userLocation, cityName);

          // events.emit('locationChanged', cityName);

        setState(() { 
        widget.user = userDetail;
        state =1;
        });
        
        });
                  // widget.queryUrl = null;
                  // widget.voucher = null;
                });

                // return Misc("").then((value) => setState(() {
                //       widget.voucher = null;
                //     }));
              },
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    
                    const SizedBox(
                        width: 0, height: Constants.spacing3),
                    Container(
                      padding: const EdgeInsets.fromLTRB(0, Constants.spacing4, 0, Constants.spacing4),
                      color: Constants.white,
                      child: Align(
                        alignment: Alignment.center,
                        child: buildImage()),
                    ),
                    buildDescriptionUser(),
                    
                  ],
                ),
              ),
            ),
            bottomNavigationBar: SafeArea(
              child: Container(
                decoration: const BoxDecoration(color: Colors.white),
                padding: const EdgeInsets.symmetric(
                    vertical: Constants.spacing3,
                    horizontal: Constants.spacing4),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Button(
                        fontSize: Constants.fontSizeLg,
                        type: ButtonType.secondary,
                        iconSvg: 'assets/svg/add.svg',
                        text: "Add",
                        onPressed: () {
                         
                          Navigator.of(context).pushNamed('/chat' );
                        },
                      ),
                    ),
                    const SizedBox(width: 8, height: 8),
                    Expanded(
                      flex: 2,
                        child: Button(
                        
                      text: state == 2 ? "Memuat..": '${widget.user?['firstName'] ?? "User"} Post News',
                      // iconSvg: 'assets/svg/add.svg',
                      fontSize: Constants.fontSizeLg,
                      //TODO : bisa dipencet kalau Price ID ada isinya dan tenornya udah dipilih,dp bayar...dan [terms] = [] ..,city ada (cash , otr price null/angka) (credit,terms.isNotEmpty ?? []) otrPrice
                      state: state == 5
                          ? ButtonState.loading
                          : ButtonState.normal,
                      onPressed: () {
                       
                        Navigator.of(context).pushNamed("/userpost/${widget.user?['id']}?name=${widget.user?['firstName'] ?? "User"}");
                      },
                    ))
                  ],
                ),
              ),
            ),
          );
  }
}
