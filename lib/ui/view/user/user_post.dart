// main.dart
// ignore_for_file: avoid_unnecessary_containers

import 'dart:async';
import 'dart:convert';

import 'package:buma/application/exceptions/dio_exceptions.dart';
import 'package:buma/application/helpers/endpoint.dart';
import 'package:buma/application/services/dio_service.dart';
import 'package:buma/ui/app_dialog.dart';
import 'package:buma/ui/component/icon_refresh_indicator.dart';
import 'package:buma/ui/component/user_itemPost_component.dart';
import 'package:buma/ui/component/zoom_interactive.dart';
import 'package:buma/ui/style/constants.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:flutter/widgets.dart' as text;

import 'package:intl/intl.dart' as intl;
import 'package:shared_preferences/shared_preferences.dart';



class UserPost extends StatefulWidget {
  dynamic id,name;
  UserPost({Key? key, this.id,this.name}) : super(key: key);
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  @override
  _UserPostState createState() => _UserPostState();
}

class _UserPostState extends State<UserPost> {
  final Dio _dio = DioService.getInstance();
  // At the beginning, we fetch the first 20 posts
  int _page = 0;
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
  List _postsResult = [];
  Map component = {};
  // List kategori = [];
  List _data = [];
  final List _filtermotor = [];
  int countfilter = 0;
  int countsfilter = 99;
  String namaawal = "";
  String sorting = "";
  // String
  int _inputPhase = 0;
  List kategoribrand = [];

  RangeValues _currentRangeValues = const RangeValues(0, 0);
  dynamic filterPriceString;
  dynamic filterPriceStringDialog;
  Map type = {};
  int state = 0;



  final TextEditingController searchController = TextEditingController();

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

  Future<Map<String, dynamic>> readMap() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString('liked');
    if (jsonString == null) {
      return {};
    }
    return jsonDecode(jsonString);
  }

// Function to save the updated 'liked' map to SharedPreferences
Future<void> saveMap(Map? savemap) async {
  final prefs = await SharedPreferences.getInstance();
  final jsonString = jsonEncode(savemap);
  prefs.setString('liked', jsonString);
}

// Function to add or remove liked posts from the 'savemap'
void toggleLikedPost(String postId,Map? map) async {
  Map<String, dynamic> savemap = await readMap();

  if (savemap.containsKey(postId)) {
    // If the post is already liked, remove it from 'savemap'
    savemap.remove(postId);
  } else {
    // If the post is not liked, add it to 'savemap'
    // savemap[postId] = true;
    await saveMap(map);
  }

  // Save the updated 'savemap' to SharedPreferences
  // await saveMap(savemap)
  
  
}
  void _firstLoad() async {
    setState(() {
      _isFirstLoadRunning = true;
      _page = 1;
    });
    try {
      var params = {
        'limit': 20
        // 'sorts': 1,
      };
      Response response = await _dio.get("${Endpoint.userList}/${widget.id}/post", queryParameters: params);

      var nextItems = response.data['data'] as List;
      List getdata = nextItems.map((item) => item).toList();

      setState(() {
        _posts = getdata;

        _postsResult = _posts;
        _page = 0;
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
        Response res = await _dio.get("${Endpoint.userList}/${widget.id}/post", queryParameters: params);
        // final List fetchedPosts = json.decode(res.data);
        var nextItems = res.data['data'] as List;
        List fetchedPosts = nextItems.map((item) => item).toList();
        if (fetchedPosts.isNotEmpty) {
          setState(() {
            _posts.addAll(fetchedPosts);
            _postsResult.addAll(fetchedPosts);

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
      _controller = ScrollController()..addListener(_loadMore);
    });
  }

  @override
  void dispose() {
    _controller.removeListener(_loadMore);
    super.dispose();
  }

  Widget searchPost(){
    return Container(
      padding: const EdgeInsets.fromLTRB(Constants.spacing11, 0, Constants.spacing4, 0),
      child: Focus(
                    onFocusChange: (hasFocus) {
                      if (hasFocus && _inputPhase < 1) {
                        _inputPhase = 1;
                      }
                    },
                    child: TextField(
                      
                      controller: searchController,
                      decoration: InputDecoration(
                          filled: true,
                          
                          fillColor: searchController.text == null || searchController.text == ""
                              ? Constants.white
                              : Constants.gray.shade100,
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: Constants.spacing2),
                          border: const OutlineInputBorder(),
                          suffixIcon:  InkWell(child:
                           searchController.text == null || searchController.text == "" ?
                           Icon(Icons.search) : InkWell
                           
                           (
                            onTap: () {
                              setState(() {
                                
                              searchController.clear();
                              _posts = _postsResult;
                              });
                            },
                            child: Icon(Icons.close))),
                          hintText: "Search in ${widget.name} posts",
                          hintStyle: TextStyle(
                              color: Constants.gray.shade400,
                              overflow: TextOverflow.ellipsis,
                              fontSize: Constants.fontSizeSm,
                              fontWeight: FontWeight.w400,),
                              hintMaxLines: 2,
                          enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Constants.gray.shade200),
                              borderRadius: const BorderRadius.all(
                                  Radius.circular(Constants.spacing3))),
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Constants.gray.shade200),
                              borderRadius: const BorderRadius.all(
                                  Radius.circular(Constants.spacing3)))),
                                  onChanged: (value) {
                                     if (value.isEmpty) {
                                      setState(() {
                                        
                                          _posts = _postsResult;
                                          
                                      });
                                        } else {
                                          setState(() {
                                          if(_posts.isEmpty){
                                            setState(() {
                                              _posts = _postsResult;
                                          
                                            });
                                          }
                                          _posts = _postsResult
                                              .where((post) =>
                                                  post['text']
                                                      .toString()
                                                      .toLowerCase()
                                                      .contains(value.toLowerCase()))
                                              .toList();
                                          });
                                         
                                          
      }
                                  },
                      // onChanged: (text) {
                        
                      // },
                    ),
                  ),
    );
                
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
      

    Widget buildDescription(){
      return Container(

        padding: const EdgeInsets.symmetric(horizontal: Constants.spacing10),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(top: Constants.spacing2),
                    child: Text(item['text'] ?? "",maxLines: 5,style: TextStyle(fontSize: Constants.fontSizeMd),),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(top: Constants.spacing1),
                    child: Text("https://www.logique.co.id",maxLines: 1,style: TextStyle(fontSize: Constants.fontSizeSm,color: Constants.sky),),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(top: Constants.spacing1),
                    child: Text("${(item['likes'] ?? "0").toString() ?? ""} likes",maxLines: 1,style: TextStyle(fontSize: Constants.fontSizeSm,color: Constants.primaryColor.shade400),),
                  ),
                ),
              ],
            ),
            Divider(thickness: 2,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      print(item['liked']); 
                    item['liked'] = item['liked'] ==null ? true: item['liked'] == false ? true : false;
                    print(item['liked']);
                    });
                    setState(() {
                      if(item['liked'] == true){
                        AppDialog.snackBar(text: "berhasil di like");
                        setState(() {
                          
                        // item['liked'] = false;
                        item['likes'] = item['likes'] + 1;
                        });
                        toggleLikedPost(item['id'],item);
                        // saveMap(item);
                      }else if(item['liked'] == false){

                        AppDialog.snackBar(text: "berhasil di unlike");
                        setState(() {
                          
                        // item['liked'] = true;

                        item['likes'] = item['likes'] - 1;
                        });

                        toggleLikedPost(item['id'],item);
                        // saveMap(item);
                      }
                    });
                  
                  },
                  child:  Icon(Icons.favorite,color: item['liked'] == true ? Constants.primaryColor : Constants.gray,)),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(left: Constants.spacing1),
                    child: Text("liked",maxLines: 1,style: TextStyle(fontSize: Constants.fontSizeSm,color: Constants.primaryColor.shade400),),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    }
    Widget buildListTag(){

    List<String> tags =(item?['tags'] as List).map((item) => item as String).toList();
      return Container(
        margin: EdgeInsets.only(top: Constants.spacing2),
        padding: const EdgeInsets.symmetric(horizontal: Constants.spacing10),
        color: Constants.white,
        width: MediaQuery.of(context).size.width,
        height: 30,

        child: ListView.builder(
        itemCount:(tags ?? []).length,
        scrollDirection: Axis.horizontal,
        semanticChildCount: 0,
        itemBuilder: (context, index) {
          // var item = item['tag'][index];
          return Container(
            margin: const EdgeInsets.only(right: Constants.spacing2),
            // padding: EdgeInsets.symmetric(horizontal: Constants.spacing1),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                fixedSize: const Size(40, 40),
                minimumSize: const Size(80, 40),
                // padding: const EdgeInsets.only(bottom: Constants.spacing1),
                foregroundColor:Constants.black,
                animationDuration:const Duration(milliseconds: 1000,),
                backgroundColor: Constants.sky,
                splashFactory: InkSplash.splashFactory,
                shadowColor:Colors.transparent,
                elevation: 0.0,
              ),
              onPressed:(){
                setState(() {
                  _posts = _postsResult
                  .where((post) =>
                      post['tags']
                          .toString()
                          .toLowerCase()
                          .contains(tags[index].toLowerCase()))
                  .toList();
                  searchController.text = tags[index];
                  
                });
                // if(callback != null){
                //   callback!();
                // }
              },
              child: Text(
                "${tags[index]}",
                textAlign:
                    TextAlign.center,
                overflow:
                    TextOverflow.ellipsis,
                style: const TextStyle(
                  color:
                      Constants.white,
                      fontSize: Constants.fontSizeMd,
                ),
              ),
            ),
          );
        },
      ),
      );
    }
    Widget buildImage(){
      String imageSrc = item != null
        // ignore: prefer_if_null_operators
        ? item['image'] != null
            ? item['image']
            : item['image'] != null
                ? item['image']
                : 'https://i.pinimg.com/564x/b8/b8/f7/b8b8f787c454cf1ded2d9d870707ed96.jpg'
        : 'https://i.pinimg.com/564x/b8/b8/f7/b8b8f787c454cf1ded2d9d870707ed96.jpg';

      return Wrap(
            children: <Widget>[
              Container(
                margin: const EdgeInsets.symmetric(horizontal: Constants.spacing8),
                decoration: const BoxDecoration(
                        color: Constants.white,
                        borderRadius: BorderRadius.all(Radius.circular(Constants.spacing4))
                      
                      ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    //
                    Container(
                      
                      padding: const EdgeInsets.fromLTRB(Constants.spacing4, Constants.spacing2, Constants.spacing4, 0),
                      child: AspectRatio(
                        aspectRatio:2/1,
                        child: Stack(
                          alignment: Alignment.bottomLeft,
                          children: [
                            CachedNetworkImage(
                                imageUrl: imageSrc,
                                fit: BoxFit.cover,
                                imageBuilder: (context, imageProvider) =>
                                    AspectRatio(
                                      aspectRatio: 2/1,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Constants.white,
                                          // shape: BoxShape.circle,
                                          image: DecorationImage(
                                              image: imageProvider,
                                              fit: BoxFit.cover),
                                        ),
                                      ),
                                    ),
                                errorWidget: (context, url, error) => AspectRatio(
                                    aspectRatio: 1/1,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Constants.gray.shade300,
                                      ),
                                    ))),
                          ],
                        ),
                      ),
                    ),
                    
                  ],
                ),
              ),
            ],
          );
    }

    Widget buildAuthor() {
    return Container(
      // padding: EdgeInsets.only(bottom: Constants.spacing2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipOval(
            
            child: SizedBox(
              width: MediaQuery.of(context).size.width *0.1,
             
              child: ZoomInteractive(
                aspectRatio: 1/1,
                url: item?['owner']['picture'] ?? "",
                // state: ,
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                // margin: const EdgeInsets.only(top: Constants.spacing2),
                child: Container(
    
                padding: const EdgeInsets.symmetric(horizontal: Constants.spacing3),
                  color: Constants.white,
                child: 
                
                 Text("${(item?['owner']['title'] ?? "")} ${(item?['owner']['firstName'] ?? "")} ${(item?['owner']['lastName'] ?? "") ?? "Nama Disembunyikan"}",
                                          overflow: TextOverflow.ellipsis,
                                          style:  TextStyle(
                                            fontFamily: Constants.primaryFontBold,
                                            color: Constants.sky.shade500,
                                              fontSize: Constants.fontSizeLg),textAlign: TextAlign.start,
                                        )),),
                                         Container(

                padding: const EdgeInsets.symmetric(horizontal: Constants.spacing3,),
          
                  // padding: const EdgeInsets.fromLTRB(Constants.spacing1, 0, 0, 0),
                
                  // padding: EdgeInsets.symmetric(horizontal: Constants.spacing3,vertical: Constants.spacing1),
                    color: Constants.white,
                  child: 
                  // (DateFormat("dd MMM y").format(DateTime.parse(widget.user?['dateOfBirth]))
                   Text((DateFormat("dd MMM y").format(DateTime.parse(item?['dateOfBirth'] ?? "1976-10-02T17:55:48.463Z"))),
                                            overflow: TextOverflow.ellipsis,
                                            style:  TextStyle(
                                            color: Constants.sky.shade500,
                                              // fontFamily: Constants.primaryFontBold,
                                                fontSize: Constants.fontSizeMd),textAlign: TextAlign.center,
                                          )),
            ],
          )
        ],
      ),
    );
  }
      return item != null
          ? Container(
              margin: const EdgeInsets.only(top: Constants.spacing4),
              width: MediaQuery.of(context).size.width * 0.94,
              child: InkWell(
      onTap: () {
        // Navigator.of(context).pushNamed("/user/${item['id']}");
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: Constants.spacing2,vertical: Constants.spacing2),
        decoration: BoxDecoration(
          border: Border.all(
            color: Constants.gray.shade400,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(Constants.spacing4),
        ),
        child: Column(
          children: [
            buildAuthor(),
            buildImage(),
            buildListTag(),
            buildDescription()
      
          ],
        ),
      ),
    ))
            
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
        margin: const EdgeInsets.symmetric(vertical: Constants.spacing2),
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
                        automaticallyImplyLeading: true,
                        elevation: 0,
                        floating: true,
                        leading: InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            padding: EdgeInsets.only(left: Constants.spacing4),
                            child: Icon(Icons.arrow_back,color: Constants.black,)),
                        ),
                        pinned: true,
                        toolbarHeight: 60,
                        backgroundColor: Constants.white,
                        flexibleSpace: SafeArea(
                          child: Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [searchPost()],
                            ),
                          ),
                        )
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
                              searchController.clear();
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
