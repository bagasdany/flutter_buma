// ignore_for_file: avoid_unnecessary_containers, sized_box_for_whitespace, must_be_immutable

import 'package:buma/ui/style/constants.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shimmer/shimmer.dart';

import 'dart:math' as math;
import 'app_shimmer.dart';
import 'button.dart';

class BannerShimmer extends StatelessWidget {
  double aspectRatio;
  BannerShimmer({Key? key, required this.aspectRatio}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Constants.gray.shade200,
      highlightColor: Colors.white,
      child: CarouselSlider(
          options: CarouselOptions(
            viewportFraction: 1,
            aspectRatio: aspectRatio,
            initialPage: 0,
            enableInfiniteScroll: true,
            reverse: false,
            autoPlay: false,
            autoPlayInterval: const Duration(seconds: 3),
            autoPlayAnimationDuration: const Duration(milliseconds: 800),
            autoPlayCurve: Curves.fastOutSlowIn,
            enlargeCenterPage: false,
          ),
          items: [
            Container(
              decoration: BoxDecoration(
                color: Constants.gray.shade100,
              ),
            ),
          ]),
    );
  }
}


class MotorShimmer extends StatelessWidget {
  int state;
  MotorShimmer({Key? key, required this.state}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: const EdgeInsets.all(0),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          return Container(
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(
                    bottom: Constants.spacing4,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              child: state == 2
                                  ? AppShimmer(
                                      active: state == 2,
                                      child: Container(
                                        padding: const EdgeInsets.all(
                                            Constants.spacing4),
                                        child: Container(
                                          color: Constants.gray,
                                          child: const Text(
                                            "....",
                                            style: TextStyle(
                                                fontSize: Constants.fontSizeLg,
                                                fontFamily:
                                                    Constants.primaryFontBold),
                                          ),
                                        ),
                                      ))
                                  : Container(
                                      padding: const EdgeInsets.all(
                                          Constants.spacing4),
                                      color: Constants.black,
                                      child: const Text(
                                        "",
                                        style: TextStyle(
                                            color: Constants.white,
                                            fontSize: Constants.fontSizeLg,
                                            fontFamily:
                                                Constants.primaryFontBold),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                            ),
                          ]),
                      ListView.builder(
                        padding: const EdgeInsets.all(0),
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: 6,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            margin: const EdgeInsets.only(bottom: 2),
                            child: Column(
                              children: [
                                Column(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: Constants.spacing4,
                                          horizontal: Constants.spacing4),
                                      width: double.infinity,
                                      decoration: const BoxDecoration(
                                        color: Constants.white,
                                      ),
                                      child: Wrap(
                                        children: <Widget>[
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            mainAxisSize: MainAxisSize.min,
                                            children: <Widget>[
                                              GestureDetector(
                                                onTap: () {},
                                                child: Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      .4,
                                                  child: AspectRatio(
                                                    aspectRatio: 1 / 1,
                                                    child: CachedNetworkImage(
                                                        imageUrl: "",
                                                        fit: BoxFit.contain,
                                                        imageBuilder: (context,
                                                                imageProvider) =>
                                                            AspectRatio(
                                                              aspectRatio:
                                                                  1 / 1,
                                                              child: Container(
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color:
                                                                      Constants
                                                                          .white,
                                                                  shape: BoxShape
                                                                      .rectangle,
                                                                  image: DecorationImage(
                                                                      image:
                                                                          imageProvider,
                                                                      fit: BoxFit
                                                                          .contain),
                                                                ),
                                                              ),
                                                            ),
                                                        errorWidget: (context,
                                                                url, error) =>
                                                            Shimmer.fromColors(
                                                              baseColor:
                                                                  Constants.gray
                                                                      .shade200,
                                                              highlightColor:
                                                                  Colors.white,
                                                              child:
                                                                  AspectRatio(
                                                                      aspectRatio:
                                                                          1 / 1,
                                                                      child:
                                                                          Container(
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          color: Constants
                                                                              .gray
                                                                              .shade300,
                                                                          shape:
                                                                              BoxShape.rectangle,
                                                                        ),
                                                                      )),
                                                            )),
                                                  ),
                                                ),
                                              ),

                                              // Padding(padding: EdgeInsets.only(top: 1.0)),
                                              Container(
                                                padding: const EdgeInsets.only(
                                                  left: Constants.spacing4,
                                                ),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      margin:
                                                          const EdgeInsets.only(
                                                              bottom: Constants
                                                                  .spacing1),
                                                      child: state == 2
                                                          ? AppShimmer(
                                                              active:
                                                                  state == 2,
                                                              child: SizedBox(
                                                                width: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width *
                                                                    0.4,
                                                                child:
                                                                    Container(
                                                                  color:
                                                                      Constants
                                                                          .gray,
                                                                  child:
                                                                      const Text(
                                                                    "",
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            Constants
                                                                                .fontSizeXs,
                                                                        fontFamily:
                                                                            Constants.primaryFontBold),
                                                                  ),
                                                                ),
                                                              ))
                                                          : Text(
                                                              // item[index]?['brand'] != null
                                                              //     ? item[index]['brand']
                                                              //         .toString()
                                                              // :
                                                              "",
                                                              maxLines: 2,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              style: TextStyle(
                                                                  color: Constants
                                                                      .gray
                                                                      .shade500,
                                                                  fontSize:
                                                                      Constants
                                                                          .fontSizeXs),
                                                            ),
                                                    ),
                                                    // Container(
                                                    //   margin: const EdgeInsets.only(
                                                    //       bottom: Constants.spacing1,
                                                    //       right: 1),
                                                    //   padding: EdgeInsets.all(2),
                                                    //   child: Text(
                                                    //     item[index]?['name'] != null
                                                    //         ? item[index]['name']
                                                    //         : "",
                                                    //     overflow: TextOverflow.ellipsis,
                                                    //     style: const TextStyle(
                                                    //         fontFamily: Constants
                                                    //             .primaryFontBold,
                                                    //         overflow:
                                                    //             TextOverflow.ellipsis,
                                                    //         fontSize:
                                                    //             Constants.fontSizeLg),
                                                    //   ),
                                                    // ),
                                                    Container(
                                                      margin:
                                                          const EdgeInsets.only(
                                                              bottom: Constants
                                                                  .spacing1,
                                                              right: 1),
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              .4,
                                                      child: state == 2
                                                          ? AppShimmer(
                                                              active:
                                                                  state == 2,
                                                              child: SizedBox(
                                                                width: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width *
                                                                    0.4,
                                                                child:
                                                                    Container(
                                                                  color:
                                                                      Constants
                                                                          .gray,
                                                                  child:
                                                                      const Text(
                                                                    "",
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            Constants
                                                                                .fontSizeLg,
                                                                        fontFamily:
                                                                            Constants.primaryFontBold),
                                                                  ),
                                                                ),
                                                              ))
                                                          : const Text(
                                                              // item[index]?['name'] != null
                                                              //     ? item[index]['name']
                                                              //     :
                                                              "",
                                                              maxLines: 4,
                                                              // overflow: TextOverflow.clip,
                                                              // softWrap: false,
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      Constants
                                                                          .primaryFontBold,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  fontSize:
                                                                      Constants
                                                                          .fontSizeLg),
                                                            ),
                                                    ),
                                                    Container(
                                                      margin:
                                                          const EdgeInsets.only(
                                                              bottom: Constants
                                                                  .spacing2),
                                                      child: Row(
                                                        children: [
                                                          Card(
                                                            margin:
                                                                EdgeInsets.zero,
                                                            shadowColor: Colors
                                                                .transparent,
                                                            color: const Color
                                                                    .fromARGB(
                                                                255,
                                                                255,
                                                                255,
                                                                255),
                                                            shape:
                                                                RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          14),
                                                              side: BorderSide(
                                                                color: Constants
                                                                    .gray
                                                                    .shade300,
                                                                width: 0.7,
                                                              ),
                                                            ),
                                                            child: SizedBox(
                                                              width: 45,
                                                              height: 20,
                                                              child: Center(
                                                                child: state ==
                                                                        2
                                                                    ? AppShimmer(
                                                                        active:
                                                                            state ==
                                                                                2,
                                                                        child:
                                                                            SizedBox(
                                                                          width:
                                                                              MediaQuery.of(context).size.width * 0.08,
                                                                          child:
                                                                              Container(
                                                                            color:
                                                                                Constants.gray,
                                                                            child:
                                                                                const Text(
                                                                              "",
                                                                              style: TextStyle(fontSize: Constants.fontSizeXs, fontFamily: Constants.primaryFontBold),
                                                                            ),
                                                                          ),
                                                                        ))
                                                                    : Text(
                                                                        ("cash"),
                                                                        overflow:
                                                                            TextOverflow.ellipsis,
                                                                        style: TextStyle(
                                                                            color:
                                                                                Constants.gray.shade500,
                                                                            fontSize: Constants.fontSizeXs),
                                                                      ),
                                                              ),
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                              width: Constants
                                                                  .spacing1),
                                                          Card(
                                                            margin:
                                                                EdgeInsets.zero,
                                                            shadowColor: Colors
                                                                .transparent,
                                                            color: Colors
                                                                .transparent,
                                                            shape:
                                                                RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          14),
                                                              side: BorderSide(
                                                                color: Constants
                                                                    .gray
                                                                    .shade300,
                                                                width: 0.7,
                                                              ),
                                                            ),
                                                            child: SizedBox(
                                                              width: 45,
                                                              height: 20,
                                                              child: Center(
                                                                child: state ==
                                                                        2
                                                                    ? AppShimmer(
                                                                        active:
                                                                            state ==
                                                                                2,
                                                                        child:
                                                                            SizedBox(
                                                                          width:
                                                                              MediaQuery.of(context).size.width * 0.08,
                                                                          child:
                                                                              Container(
                                                                            color:
                                                                                Constants.gray,
                                                                            child:
                                                                                const Text(
                                                                              "",
                                                                              style: TextStyle(fontSize: Constants.fontSizeXs, fontFamily: Constants.primaryFontBold),
                                                                            ),
                                                                          ),
                                                                        ))
                                                                    : Text(
                                                                        ("kredit"),
                                                                        overflow:
                                                                            TextOverflow.ellipsis,
                                                                        style: TextStyle(
                                                                            color: Constants.gray.shade500,
                                                                            // fontWeight: FontWeight.w500,
                                                                            fontSize: Constants.fontSizeXs),
                                                                      ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Container(
                                                            margin: const EdgeInsets
                                                                    .symmetric(
                                                                vertical: Constants
                                                                    .spacing1),
                                                            child: state == 2
                                                                ? AppShimmer(
                                                                    active:
                                                                        state ==
                                                                            2,
                                                                    child:
                                                                        SizedBox(
                                                                      width: MediaQuery.of(context)
                                                                              .size
                                                                              .width *
                                                                          0.4,
                                                                      child:
                                                                          Container(
                                                                        color: Constants
                                                                            .gray,
                                                                        child:
                                                                            const Text(
                                                                          "",
                                                                          style: TextStyle(
                                                                              fontSize: Constants.fontSizeXs,
                                                                              fontFamily: Constants.primaryFontBold),
                                                                        ),
                                                                      ),
                                                                    ))
                                                                : Text(
                                                                    ("Harga OTR mulai dari"),
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                    style: TextStyle(
                                                                        color: Constants.gray.shade500,
                                                                        // fontWeight: FontWeight.w500,
                                                                        fontSize: Constants.fontSizeXs),
                                                                  )),
                                                        Container(
                                                          margin:
                                                              const EdgeInsets
                                                                  .only(
                                                            bottom: Constants
                                                                .spacing1,
                                                          ),
                                                          child: state == 2
                                                              ? AppShimmer(
                                                                  active:
                                                                      state ==
                                                                          2,
                                                                  child:
                                                                      SizedBox(
                                                                    width: MediaQuery.of(context)
                                                                            .size
                                                                            .width *
                                                                        0.3,
                                                                    child:
                                                                        Container(
                                                                      color: Constants
                                                                          .gray,
                                                                      child:
                                                                          const Text(
                                                                        "",
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                Constants.fontSizeXl,
                                                                            fontFamily: Constants.primaryFontBold),
                                                                      ),
                                                                    ),
                                                                  ))
                                                              : const Text(
                                                                  // "${formatter.format(item[index]?['price']).substring(0, 4)}jt",
                                                                  "",
                                                                  style: TextStyle(
                                                                      fontFamily:
                                                                          Constants
                                                                              .primaryFontBold,
                                                                      color: Constants
                                                                          .primaryColor,
                                                                      fontSize:
                                                                          Constants
                                                                              .fontSizeXl),
                                                                ),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        Container(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(2),
                                                          margin: const EdgeInsets
                                                                  .only(
                                                              right: Constants
                                                                  .spacing1),
                                                          decoration: const BoxDecoration(
                                                              color: Colors
                                                                  .transparent,
                                                              borderRadius: BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          5.0))),
                                                          child: Center(
                                                              child: state == 2
                                                                  ? AppShimmer(
                                                                      active:
                                                                          state ==
                                                                              2,
                                                                      child:
                                                                          SizedBox(
                                                                        width: MediaQuery.of(context).size.width *
                                                                            0.08,
                                                                        child:
                                                                            Container(
                                                                          color:
                                                                              Constants.gray,
                                                                          child:
                                                                              const Text(
                                                                            "",
                                                                            style:
                                                                                TextStyle(fontSize: Constants.fontSizeXs, fontFamily: Constants.primaryFontBold),
                                                                          ),
                                                                        ),
                                                                      ))
                                                                  : const Text(
                                                                      // item[index]?[
                                                                      //             'discountPercentage'] !=
                                                                      //         null
                                                                      //     ? "${item[index]?['discountPercentage']}%"
                                                                      // :
                                                                      '',
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .white,
                                                                          fontSize:
                                                                              Constants.fontSizeXs),
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                    )),
                                                        ),
                                                        Container(
                                                            child: state == 2
                                                                ? AppShimmer(
                                                                    active:
                                                                        state ==
                                                                            2,
                                                                    child:
                                                                        SizedBox(
                                                                      width: MediaQuery.of(context)
                                                                              .size
                                                                              .width *
                                                                          0.08,
                                                                      child:
                                                                          Container(
                                                                        color: Constants
                                                                            .gray,
                                                                        child:
                                                                            const Text(
                                                                          "",
                                                                          style:
                                                                              TextStyle(fontFamily: Constants.primaryFontBold),
                                                                        ),
                                                                      ),
                                                                    ))
                                                                : const Text(
                                                                    "")),
                                                      ],
                                                    ),
                                                    Container(
                                                      margin: const EdgeInsets
                                                              .symmetric(
                                                          vertical: Constants
                                                              .spacing2),
                                                      child: Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: <Widget>[
                                                          Row(
                                                            children: <Widget>[
                                                              state == 2
                                                                  ? AppShimmer(
                                                                      active:
                                                                          state ==
                                                                              2,
                                                                      child:
                                                                          SizedBox(
                                                                        width: MediaQuery.of(context).size.width *
                                                                            0.04,
                                                                        child:
                                                                            Container(
                                                                          color:
                                                                              Constants.gray,
                                                                          child:
                                                                              const Text(
                                                                            "",
                                                                            style:
                                                                                TextStyle(fontSize: Constants.fontSizeXs, fontFamily: Constants.primaryFontBold),
                                                                          ),
                                                                        ),
                                                                      ))
                                                                  : const Icon(
                                                                      Icons
                                                                          .star,
                                                                      color: Colors
                                                                          .transparent,
                                                                      size:
                                                                          14.0,
                                                                    ),
                                                              state == 2
                                                                  ? AppShimmer(
                                                                      active:
                                                                          state ==
                                                                              2,
                                                                      child:
                                                                          SizedBox(
                                                                        width: MediaQuery.of(context).size.width *
                                                                            0.04,
                                                                        child:
                                                                            Container(
                                                                          color:
                                                                              Constants.gray,
                                                                          child:
                                                                              const Text(
                                                                            "",
                                                                            style:
                                                                                TextStyle(fontSize: Constants.fontSizeXs, fontFamily: Constants.primaryFontBold),
                                                                          ),
                                                                        ),
                                                                      ))
                                                                  : const Text(
                                                                      // "${item[index]?['reviewRate'] ?? ''}",
                                                                      "",
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              Constants.fontSizeXs),
                                                                    ),
                                                              const SizedBox(
                                                                width: Constants
                                                                    .spacing2,
                                                              ),
                                                              state == 2
                                                                  ? AppShimmer(
                                                                      active:
                                                                          state ==
                                                                              2,
                                                                      child:
                                                                          SizedBox(
                                                                        width: MediaQuery.of(context).size.width *
                                                                            0.15,
                                                                        child:
                                                                            Container(
                                                                          color:
                                                                              Constants.gray,
                                                                          child:
                                                                              const Text(
                                                                            "",
                                                                            style:
                                                                                TextStyle(fontSize: Constants.fontSizeXs, fontFamily: Constants.primaryFontBold),
                                                                          ),
                                                                        ),
                                                                      ))
                                                                  : const Text(
                                                                      // item[index]?[
                                                                      //             'qtySold'] !=
                                                                      //         null
                                                                      //     ? "Terjual ${item[index]?['qtySold']}"
                                                                      // :
                                                                      "",
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              Constants.fontSizeXs),
                                                                    ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
          // } else {
          //   return Container();
          // }
        },
        itemCount: 1);
  }
}

class AddressShimmer extends StatelessWidget {
  int state;
  AddressShimmer({Key? key, required this.state}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, Constants.spacing4, 0, 0),
      child: ListView.builder(
        shrinkWrap: true,
        padding: const EdgeInsets.all(0),
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 10,
        itemBuilder: (BuildContext context, int index) {
          return Container(
              margin: const EdgeInsets.only(bottom: 2),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        // openAddMotor(context, '/detailkendaraansaya', index);
                      },
                      child: Container(
                        width: double.infinity,
                        margin: const EdgeInsets.all(0),
                        decoration: const BoxDecoration(color: Colors.white),
                        child: Container(
                          padding: const EdgeInsets.all(Constants.spacing4),
                          child: SizedBox(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  // margin: const EdgeInsets.only(
                                  //     bottom: Constants.spacing1),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          state == 2
                                              ? AppShimmer(
                                                  active: state == 2,
                                                  child: SizedBox(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.2,
                                                    child: Container(
                                                      color: Constants.gray,
                                                      child: const Text(
                                                        "",
                                                        style: TextStyle(
                                                            fontFamily: Constants
                                                                .primaryFontBold),
                                                      ),
                                                    ),
                                                  ))
                                              : const Text(
                                                  "",
                                                  style: TextStyle(
                                                      fontFamily: Constants
                                                          .primaryFontBold),
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                          const SizedBox(
                                            width: Constants.spacing2,
                                          ),
                                          Container(
                                            padding: const EdgeInsets.all(
                                                Constants.spacing1),
                                            decoration: const BoxDecoration(
                                                // color: Constants
                                                //     .primaryColor.shade100,
                                                shape: BoxShape.rectangle),
                                            child: AppShimmer(
                                              active: state == 2,
                                              child: state == 2
                                                  ? AppShimmer(
                                                      active: state == 2,
                                                      child: SizedBox(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.3,
                                                        child: Container(
                                                          color: Constants.gray,
                                                          child: const Text(
                                                            "",
                                                            style: TextStyle(
                                                                fontSize: Constants
                                                                    .fontSizeXs),
                                                          ),
                                                        ),
                                                      ))
                                                  : const Text(
                                                      "",
                                                      style: TextStyle(
                                                          fontFamily: Constants
                                                              .primaryFontBold,
                                                          fontSize: Constants
                                                              .fontSizeXs),
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        // ignore: prefer_const_literals_to_create_immutables
                                        children: [
                                          state == 2
                                              ? AppShimmer(
                                                  active: state == 2,
                                                  child: SizedBox(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.1,
                                                    child: Container(
                                                      color: Constants.gray,
                                                      child: const Text(
                                                        "",
                                                        style: TextStyle(),
                                                      ),
                                                    ),
                                                  ))
                                              : const Text(
                                                  "",
                                                  // "Hapus",
                                                  style: TextStyle(
                                                      fontFamily: Constants
                                                          .primaryFontBold,
                                                      color: Constants
                                                          .primaryColor),
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                          const SizedBox(
                                            width: Constants.spacing4,
                                          ),
                                          state == 2
                                              ? AppShimmer(
                                                  active: state == 2,
                                                  child: SizedBox(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.1,
                                                    child: Container(
                                                      color: Constants.gray,
                                                      child: const Text(
                                                        "",
                                                        style: TextStyle(),
                                                      ),
                                                    ),
                                                  ))
                                              : const Text(
                                                  "",
                                                  // "Ubah",
                                                  style: TextStyle(
                                                      fontFamily: Constants
                                                          .primaryFontBold,
                                                      color: Constants
                                                          .primaryColor),
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                          // Container(
                                          //   child: const Icon(
                                          //     Icons
                                          //         .collections_bookmark_outlined,
                                          //     color: Constants.primaryColor,
                                          //     size: 20,
                                          //   ),
                                          // )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.symmetric(
                                      vertical: Constants.spacing1),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    // ignore: prefer_const_literals_to_create_immutables
                                    children: [
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.9,
                                        child: state == 2
                                            ? AppShimmer(
                                                active: state == 2,
                                                child: SizedBox(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.4,
                                                  child: Container(
                                                    color: Constants.gray,
                                                    child: const Text(
                                                      "",
                                                      style: TextStyle(
                                                          fontSize: Constants
                                                              .fontSizeSm),
                                                    ),
                                                  ),
                                                ))
                                            : const Text(
                                                // listDefaultAddress[index]
                                                //         ['recipientName'] ??
                                                "",
                                                style: TextStyle(
                                                    fontSize:
                                                        Constants.fontSizeSm),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.symmetric(
                                      vertical: Constants.spacing1),
                                  child: state == 2
                                      ? AppShimmer(
                                          active: state == 2,
                                          child: SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.9,
                                            child: Container(
                                              color: Constants.gray,
                                              child: const Text(
                                                "",
                                                style: TextStyle(
                                                    fontSize:
                                                        Constants.fontSizeSm),
                                              ),
                                            ),
                                          ))
                                      : const Text(
                                          // listDefaultAddress[index]['address'] ??
                                          "",
                                          style: TextStyle(
                                              fontSize: Constants.fontSizeSm)),
                                ),
                                // listDefaultAddress[index]['phone1'] == "" ||
                                //         listDefaultAddress[index]['phone1'] ==
                                //             null
                                // ? Container()
                                // :
                                Container(
                                  child: state == 2
                                      ? AppShimmer(
                                          active: state == 2,
                                          child: SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.4,
                                            child: Container(
                                              color: Constants.gray,
                                              child: const Text(
                                                "",
                                                style: TextStyle(
                                                    fontSize:
                                                        Constants.fontSizeSm),
                                              ),
                                            ),
                                          ))
                                      : const Text(
                                          // listDefaultAddress[index]
                                          //         ['phone1'] ??
                                          "",
                                          style: TextStyle(
                                              fontSize: Constants.fontSizeSm)),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  ]));
        },
      ),
    );
  }
}

class VoucherShimmer extends StatelessWidget {
  int state;
  VoucherShimmer({Key? key, required this.state}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: const EdgeInsets.all(0),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 6,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            margin: const EdgeInsets.fromLTRB(0, 0, 0, Constants.spacing4),
            child: Column(
              children: [
                Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(Constants.spacing3),
                      ),
                    ),
                    margin: const EdgeInsets.fromLTRB(Constants.spacing4,
                        Constants.spacing4, Constants.spacing4, 0),
                    // margin:
                    //     const EdgeInsets.only(top: Constants.spacing1),
                    child: Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(
                            Radius.circular(Constants.spacing3)),
                      ),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Column(
                            children: [
                              Container(
                                decoration: const BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                ),
                                child: AspectRatio(
                                  aspectRatio: 2.5 / 1,
                                  child: Shimmer.fromColors(
                                    baseColor: Constants.gray.shade200,
                                    highlightColor: Colors.white,
                                    child: CachedNetworkImage(
                                        imageBuilder: (context,
                                                imageProvider) =>
                                            Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    const BorderRadius.only(
                                                  topRight: Radius.circular(10),
                                                  topLeft: Radius.circular(10),
                                                ),
                                                image: DecorationImage(
                                                  image: imageProvider,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                        fit: BoxFit.fill,
                                        imageUrl: "",
                                        progressIndicatorBuilder:
                                            (context, url, downloadProgress) =>
                                                AppShimmer(
                                                    active: state == 2,
                                                    child: const AspectRatio(
                                                        aspectRatio: 2.5 / 1,
                                                        child: SizedBox())),
                                        errorWidget: (context, url, error) =>
                                            Shimmer.fromColors(
                                              baseColor:
                                                  Constants.gray.shade200,
                                              highlightColor: Colors.white,
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    color:
                                                        Constants.gray.shade200,
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                            Radius.circular(
                                                                Constants
                                                                    .spacing3))),
                                                width: 55,
                                                height: 60,
                                              ),
                                            )),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Positioned(
                              left: -15,
                              child: SizedBox(
                                child: Container(
                                  height: 30,
                                  width: 30,
                                  decoration: BoxDecoration(
                                    color: Constants.gray.shade100,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              )),
                          Positioned(
                              right: -15,
                              child: SizedBox(
                                child: Container(
                                  height: 30,
                                  width: 30,
                                  decoration: BoxDecoration(
                                      color: Constants.gray.shade100,
                                      shape: BoxShape.circle),
                                ),
                              )),
                        ],
                      ),
                    )),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      bottomRight: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Constants.gray.withOpacity(0.2),
                        spreadRadius: 1,
                        blurRadius: 4,
                        offset:
                            const Offset(0, 3), // changes position of shadow
                      ),
                    ],
                    color: Constants.white,
                  ),
                  margin: const EdgeInsets.symmetric(
                    horizontal: Constants.spacing4,
                  ),
                  child: Column(
                    children: [
                      Container(
                          child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: Constants.spacing4,
                            vertical: Constants.spacing2),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              child: state == 2
                                  ? AppShimmer(
                                      active: state == 2,
                                      child: SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: Container(
                                          color: Constants.gray,
                                          child: const Text(
                                            "",
                                            style: TextStyle(
                                                fontSize: Constants.fontSizeLg),
                                          ),
                                        ),
                                      ))
                                  : const Text(
                                      "",
                                      maxLines: 2,
                                      overflow: TextOverflow.clip,
                                      style: TextStyle(
                                          fontSize: Constants.fontSizeLg),
                                    ),
                            ),
                            const SizedBox(
                              height: Constants.spacing1,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Column(
                                  children: [
                                    AppShimmer(
                                      active: state == 2,
                                      child: Icon(
                                        Icons.access_time_rounded,
                                        color: Constants.primaryColor.shade300,
                                        size: 30,
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  width: Constants.spacing2,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: Constants.spacing1,
                                      ),
                                      child: const Text(
                                        "Berlaku Hingga",
                                        style: TextStyle(
                                            color: Constants.gray,
                                            fontSize: Constants.fontSizeXs),
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.only(
                                          bottom: Constants.spacing1),
                                      child: state == 2
                                          ? AppShimmer(
                                              active: state == 2,
                                              child: SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.4,
                                                child: Container(
                                                  color: Constants.gray,
                                                  child: const Text(
                                                    "",
                                                    style: TextStyle(
                                                        fontSize: Constants
                                                            .fontSizeLg),
                                                  ),
                                                ),
                                              ))
                                          : const Text(
                                              "",
                                              style: TextStyle(
                                                  fontSize:
                                                      Constants.fontSizeLg),
                                            ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.start,
                          //   children: [
                          //     Container(
                          //       child: Text(
                          //         "Berlaku Sampai ${_posts[index]?['endDate'] ?? "10%"}",
                          //         style: const TextStyle(
                          //             fontSize: Constants.fontSizeXs,
                          //             color: Constants.black),
                          //       ),
                          //     ),
                          //   ],
                          // ),
                          ),
                    ],
                  ),
                )
              ],
            ),
          );
          // return Column(
          //   children: [
          //     Container(
          //         margin: const EdgeInsets.only(top: Constants.spacing1),
          //         color: Constants.white,
          //         child: Container(
          //           padding: const EdgeInsets.all(Constants.spacing4),
          //           child: Stack(
          //             alignment: Alignment.center,
          //             children: [
          //               Column(
          //                 children: [
          //                   GestureDetector(
          //                       onTap: () {},
          //                       child: SizedBox(
          //                         child: Shimmer.fromColors(
          //                           baseColor: Constants.gray.shade200,
          //                           highlightColor: Colors.white,
          //                           child: SizedBox(
          //                             child: Image.network(
          //                               "",
          //                               fit: BoxFit.contain,
          //                               loadingBuilder: (BuildContext context,
          //                                   Widget child,
          //                                   ImageChunkEvent? loadingProgress) {
          //                                 return AspectRatio(
          //                                   aspectRatio: 2 / 1,
          //                                   child: SizedBox(
          //                                       child: Container(
          //                                     color: Constants.gray.shade300,
          //                                   )),
          //                                 );
          //                               },
          //                               errorBuilder: (BuildContext context,
          //                                   Object exception,
          //                                   StackTrace? stackTrace) {
          //                                 return AspectRatio(
          //                                   aspectRatio: 2 / 1,
          //                                   child: Container(
          //                                     color: Constants.gray,
          //                                   ),
          //                                 );
          //                               },
          //                             ),
          //                           ),
          //                         ),
          //                       )),
          //                   Row(
          //                     mainAxisAlignment: MainAxisAlignment.start,
          //                     children: [
          //                       Container(
          //                         padding: const EdgeInsets.fromLTRB(
          //                             0,
          //                             Constants.spacing1,
          //                             Constants.spacing1,
          //                             Constants.spacing1),
          //                         child: state == 2
          //                             ? AppShimmer(
          //                                 active: state == 2,
          //                                 child: SizedBox(
          //                                   width: MediaQuery.of(context)
          //                                           .size
          //                                           .width *
          //                                       0.4,
          //                                   child: Container(
          //                                     color: Constants.gray,
          //                                     child: const Text(
          //                                       "",
          //                                       style: TextStyle(
          //                                           fontSize:
          //                                               Constants.fontSizeXs),
          //                                     ),
          //                                   ),
          //                                 ))
          //                             : const Text(
          //                                 "",
          //                                 style: TextStyle(
          //                                     fontSize: Constants.fontSizeXs,
          //                                     color: Constants.black),
          //                               ),
          //                       ),
          //                     ],
          //                   )
          //                 ],
          //               ),
          //             ],
          //           ),
          //         )),
          //   ],
          // );
        });
  }
}

class OrderShimmer extends StatelessWidget {
  int state;
  OrderShimmer({Key? key, required this.state}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(
            height: 105,
          ),
          ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
              itemCount: 7,
              itemBuilder: (BuildContext context, index) {
                return Container(
                  margin: const EdgeInsets.symmetric(
                      horizontal: Constants.spacing3,
                      vertical: Constants.spacing1),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: const BorderRadius.all(
                            Radius.circular(Constants.spacing3)),
                        border: Border.all(color: Constants.gray.shade200)),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: Constants.spacing4,
                              vertical: Constants.spacing3),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                  child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  state == 2
                                      ? AppShimmer(
                                          active: state == 2,
                                          child: SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.4,
                                            child: Container(
                                              color: Constants.gray,
                                              child: const Text(
                                                "",
                                                style: TextStyle(
                                                    fontSize:
                                                        Constants.fontSizeXs),
                                              ),
                                            ),
                                          ))
                                      : const Text('Pembelian Motor',
                                          style: TextStyle(
                                              fontSize: Constants.fontSizeXs)),
                                  state == 2
                                      ? AppShimmer(
                                          active: state == 2,
                                          child: SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.4,
                                            child: Container(
                                              color: Constants.gray,
                                              child: const Text(
                                                "",
                                                style: TextStyle(),
                                              ),
                                            ),
                                          ))
                                      : const Text('', style: TextStyle()),
                                ],
                              )),
                              Container(
                                // color: bgColor,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: Constants.spacing1),
                                child: state == 2
                                    ? AppShimmer(
                                        active: state == 2,
                                        child: SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.3,
                                          child: Container(
                                            color: Constants.gray,
                                            child: const Text(
                                              "",
                                              style: TextStyle(
                                                fontSize: Constants.fontSizeSm,
                                              ),
                                            ),
                                          ),
                                        ))
                                    : Text(
                                        ""
                                        // order['statusText'] ?? ''
                                        ,
                                        style: TextStyle(
                                            fontSize: Constants.fontSizeSm,
                                            fontFamily:
                                                Constants.primaryFontBold,
                                            color: Constants.gray.shade800)),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                            height: 1,
                            child: Container(color: Constants.gray.shade200)),
                        Container(
                          padding: const EdgeInsets.all(Constants.spacing4),
                          child: Row(
                            children: [
                              Expanded(
                                  child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AppShimmer(
                                    active: state == 2,
                                    child: SizedBox(
                                      width: 56,
                                      height: 56,
                                      child: Image.network("", errorBuilder:
                                          (BuildContext context,
                                              Object exception,
                                              StackTrace? stackTrace) {
                                        return Image.asset(
                                            'assets/images/kliknss.png');
                                      }),
                                    ),
                                  ),
                                  const SizedBox(width: Constants.spacing3),
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        state == 2
                                            ? AppShimmer(
                                                active: state == 2,
                                                child: SizedBox(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.7,
                                                  child: Container(
                                                    color: Constants.gray,
                                                    child: const Text(
                                                      "",
                                                      style: TextStyle(),
                                                    ),
                                                  ),
                                                ))
                                            : const Text(
                                                ""
                                                // order['items'][0]['name']
                                                ,
                                                style: TextStyle(
                                                    fontFamily: Constants
                                                        .primaryFontBold)),
                                        const SizedBox(
                                            height: Constants.spacing2),
                                        Row(
                                          children: [
                                            Expanded(
                                                child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                  state == 2
                                                      ? AppShimmer(
                                                          active: state == 2,
                                                          child: SizedBox(
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                0.1,
                                                            child: Container(
                                                              color: Constants
                                                                  .gray,
                                                              child: const Text(
                                                                "",
                                                                style:
                                                                    TextStyle(
                                                                  fontSize:
                                                                      Constants
                                                                          .fontSizeXs,
                                                                ),
                                                              ),
                                                            ),
                                                          ))
                                                      : const Text('DP',
                                                          style: TextStyle(
                                                              fontSize: Constants
                                                                  .fontSizeXs,
                                                              color: Constants
                                                                  .gray)),
                                                  state == 2
                                                      ? AppShimmer(
                                                          active: state == 2,
                                                          child: SizedBox(
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                0.3,
                                                            child: Container(
                                                              color: Constants
                                                                  .gray,
                                                              child: const Text(
                                                                "",
                                                                style:
                                                                    TextStyle(),
                                                              ),
                                                            ),
                                                          ))
                                                      : const Text(""
                                                          // price > 0 ? 'Rp. ${formatter.format(price)}' : '-'
                                                          )
                                                ])),
                                            const SizedBox(
                                                width: Constants.spacing4),
                                            Expanded(
                                                child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                  state == 2
                                                      ? AppShimmer(
                                                          active: state == 2,
                                                          child: SizedBox(
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                0.325,
                                                            child: Container(
                                                              color: Constants
                                                                  .gray,
                                                              child: const Text(
                                                                "",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        Constants
                                                                            .fontSizeXs),
                                                              ),
                                                            ),
                                                          ))
                                                      : const Text(
                                                          'Cicilan/bln',
                                                          style: TextStyle(
                                                              fontSize: Constants
                                                                  .fontSizeXs,
                                                              color: Constants
                                                                  .gray)),
                                                  const Text(""
                                                      // priceInstallment > 0 ?
                                                      // 'Rp. ${formatter.format(priceInstallment)}' : '-'

                                                      )
                                                ])),
                                          ],
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ))
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              }),
        ],
      ),
    );
  }
}

class ArticleShimmer extends StatelessWidget {
  double aspectRatio;
  ArticleShimmer({Key? key, required this.aspectRatio}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: Constants.spacing4),
            child: SizedBox(
              width: double.infinity,
              child: Column(
                children: [
                  SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: 4,
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
                                  child: Container(
                                margin: const EdgeInsets.only(
                                    bottom: Constants.spacing4),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(5.0)),
                                    boxShadow: [
                                      BoxShadow(
                                        color: const Color(0xFF656565)
                                            .withOpacity(0.15),
                                        blurRadius: 2.0,
                                        spreadRadius: 1.0,
                                        //           offset: Offset(4.0, 10.0)
                                      ),
                                    ]),
                                child: Wrap(
                                  children: <Widget>[
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        Shimmer.fromColors(
                                          baseColor: Constants.gray.shade200,
                                          highlightColor: Colors.white,
                                          child: SizedBox(
                                            child: Image.network(
                                              "",
                                              fit: BoxFit.contain,
                                              loadingBuilder:
                                                  (BuildContext context,
                                                      Widget child,
                                                      ImageChunkEvent?
                                                          loadingProgress) {
                                                return AspectRatio(
                                                  aspectRatio: 2 / 1,
                                                  child: SizedBox(
                                                      child: Container(
                                                    color:
                                                        Constants.gray.shade300,
                                                  )),
                                                );
                                              },
                                              errorBuilder:
                                                  (BuildContext context,
                                                      Object exception,
                                                      StackTrace? stackTrace) {
                                                return AspectRatio(
                                                  aspectRatio: 2 / 1,
                                                  child: Container(
                                                    color: Constants.gray,
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                        ),
                                        Container(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            // ignore: prefer_const_literals_to_create_immutables
                                            children: [
                                              Shimmer.fromColors(
                                                baseColor:
                                                    Constants.gray.shade200,
                                                highlightColor: Colors.white,
                                                child: Container(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          Constants.spacing4,
                                                          Constants.spacing4,
                                                          Constants.spacing6,
                                                          Constants.spacing1),
                                                  child: const Icon(
                                                    Icons.rectangle,
                                                    color: Constants.gray,
                                                    size: 20.0,
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        Constants.spacing6,
                                                        Constants.spacing4,
                                                        Constants.spacing4,
                                                        Constants.spacing1),
                                                child: Shimmer.fromColors(
                                                  baseColor:
                                                      Constants.gray.shade200,
                                                  highlightColor: Colors.white,
                                                  child: const Icon(
                                                    Icons.rectangle,
                                                    color: Constants.gray,
                                                    size: 20.0,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            // ignore: prefer_const_literals_to_create_immutables
                                            children: [
                                              Shimmer.fromColors(
                                                baseColor:
                                                    Constants.gray.shade200,
                                                highlightColor: Colors.white,
                                                child: Container(
                                                    padding: const EdgeInsets
                                                            .fromLTRB(
                                                        Constants.spacing4,
                                                        0,
                                                        Constants.spacing6,
                                                        0),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .end,
                                                      children: [
                                                        //       item?['likes'] != null
                                                        // ? item['likes'][1] == true
                                                        //     ? Constants.sky
                                                        //     : Constants.gray
                                                        // : Colors.transparent,
                                                        SizedBox(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.42,
                                                          child: Container(
                                                            color:
                                                                Constants.gray,
                                                            child: const Text(
                                                              "",
                                                              style: TextStyle(
                                                                fontSize: Constants
                                                                    .fontSizeSm,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                              ),
                                                            ),
                                                          ),
                                                        )
                                                      ],
                                                    )),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Shimmer.fromColors(
                                          baseColor: Constants.gray.shade200,
                                          highlightColor: Colors.white,
                                          child: Container(
                                              margin: const EdgeInsets.only(
                                                  top: Constants.spacing2,
                                                  left: Constants.spacing4,
                                                  right: Constants.spacing4,
                                                  bottom: Constants.spacing1),
                                              child: SizedBox(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                child: Container(
                                                  color:
                                                      Constants.gray.shade200,
                                                  child: const Text(""),
                                                ),
                                              )),
                                        ),
                                        // const Padding(padding: EdgeInsets.only(top: 5.0)),
                                        Shimmer.fromColors(
                                          baseColor: Constants.gray.shade200,
                                          highlightColor: Colors.white,
                                          child: Container(
                                              margin: const EdgeInsets.only(
                                                  top: Constants.spacing2,
                                                  left: Constants.spacing4,
                                                  right: Constants.spacing4,
                                                  bottom: Constants.spacing1),
                                              child: SizedBox(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                child: Container(
                                                  color:
                                                      Constants.gray.shade200,
                                                  child: const Text(
                                                    "",
                                                    style: TextStyle(
                                                      fontSize:
                                                          Constants.fontSizeSm,
                                                      color: Constants.gray,
                                                    ),
                                                  ),
                                                ),
                                              )),
                                        ),
                                        Shimmer.fromColors(
                                          baseColor: Constants.gray.shade200,
                                          highlightColor: Colors.white,
                                          child: Container(
                                              margin: const EdgeInsets.only(
                                                  top: Constants.spacing2,
                                                  left: Constants.spacing4,
                                                  right: Constants.spacing4,
                                                  bottom: Constants.spacing1),
                                              child: SizedBox(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                child: Container(
                                                  color:
                                                      Constants.gray.shade200,
                                                  child: const Text(
                                                    "",
                                                    style: TextStyle(
                                                      fontSize:
                                                          Constants.fontSizeSm,
                                                      color: Constants.gray,
                                                    ),
                                                  ),
                                                ),
                                              )),
                                        ),
                                        Shimmer.fromColors(
                                          baseColor: Constants.gray.shade200,
                                          highlightColor: Colors.white,
                                          child: Container(
                                              margin: const EdgeInsets.only(
                                                  top: Constants.spacing2,
                                                  left: Constants.spacing4,
                                                  right: Constants.spacing4,
                                                  bottom: Constants.spacing1),
                                              child: SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.3,
                                                child: Container(
                                                  color:
                                                      Constants.gray.shade200,
                                                  child: const Text(
                                                    "",
                                                    style: TextStyle(
                                                      fontSize:
                                                          Constants.fontSizeSm,
                                                    ),
                                                  ),
                                                ),
                                              )),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ));
                            }),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class KendaraanSayaShimmer extends StatelessWidget {
  double aspectRatio;
  KendaraanSayaShimmer({Key? key, required this.aspectRatio}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: Constants.spacing4),
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 15,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                        margin: const EdgeInsets.only(bottom: 2),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GestureDetector(
                                onTap: () {},
                                child: Container(
                                  margin: const EdgeInsets.all(0),
                                  decoration:
                                      const BoxDecoration(color: Colors.white),
                                  child: Row(
                                    children: [
                                      Expanded(
                                          child: Container(
                                        padding: const EdgeInsets.all(
                                            Constants.spacing4),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              margin: const EdgeInsets.only(
                                                  right: Constants.spacing4),
                                              child: Shimmer.fromColors(
                                                baseColor:
                                                    Constants.gray.shade200,
                                                highlightColor: Colors.white,
                                                child: CachedNetworkImage(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.2,
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.2,
                                                    fit: BoxFit.contain,
                                                    //test
                                                    imageUrl:
                                                        // widget.kendaraansaya?['imageUrl'] ?? imageNetwork,
                                                        "",
                                                    imageBuilder: (context,
                                                            imageProvider) =>
                                                        AspectRatio(
                                                          aspectRatio: 17 / 5.2,
                                                          child: Container(
                                                            decoration:
                                                                BoxDecoration(
                                                              color: Constants
                                                                  .white,
                                                              shape: BoxShape
                                                                  .rectangle,
                                                              image: DecorationImage(
                                                                  image:
                                                                      imageProvider,
                                                                  fit: BoxFit
                                                                      .contain),
                                                            ),
                                                          ),
                                                        ),
                                                    errorWidget: (context, url,
                                                            error) =>
                                                        AspectRatio(
                                                            aspectRatio:
                                                                17 / 5.2,
                                                            child: Container(
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: Constants
                                                                    .gray
                                                                    .shade300,
                                                                shape: BoxShape
                                                                    .rectangle,
                                                              ),
                                                            ))),
                                              ),
                                            ),
                                            SizedBox(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Shimmer.fromColors(
                                                    baseColor:
                                                        Constants.gray.shade200,
                                                    highlightColor:
                                                        Colors.white,
                                                    child: SizedBox(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.5,
                                                      child: Container(
                                                        decoration:
                                                            const BoxDecoration(
                                                                color: Constants
                                                                    .gray,
                                                                shape: BoxShape
                                                                    .rectangle),
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.5,
                                                        child: const Text("",
                                                            style: TextStyle(
                                                                fontSize: Constants
                                                                    .fontSizeSm)),
                                                      ),
                                                    ),
                                                  ),
                                                  Shimmer.fromColors(
                                                    baseColor:
                                                        Constants.gray.shade200,
                                                    highlightColor:
                                                        Colors.white,
                                                    child: Container(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: Constants
                                                                  .spacing1),
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.2,
                                                      child: Container(
                                                        decoration:
                                                            const BoxDecoration(
                                                                color: Constants
                                                                    .gray,
                                                                shape: BoxShape
                                                                    .rectangle),
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.2,
                                                        child: const Text("",
                                                            style: TextStyle(
                                                                fontSize: Constants
                                                                    .fontSizeSm)),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      )),
                                      Container(
                                          padding: const EdgeInsets.fromLTRB(
                                              Constants.spacing1,
                                              0,
                                              Constants.spacing4,
                                              0),
                                          child: SvgPicture.asset(
                                            'assets/svg/chevron_forward.svg',
                                            width: 27,
                                            height: 27,
                                            alignment: Alignment.topCenter,
                                          ))
                                    ],
                                  ),
                                ),
                              )
                            ]));
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
