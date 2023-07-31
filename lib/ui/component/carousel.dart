// ignore_for_file: must_be_immutable

import 'package:buma/ui/style/constants.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
class Carouselhome extends StatefulWidget {
  final List<dynamic>? banners;

  double aspectRatio;

  Carouselhome({Key? key, this.banners, required this.aspectRatio})
      : super(key: key);

  @override
  _CarouselhomeState createState() => _CarouselhomeState();
}

class _CarouselhomeState extends State<Carouselhome> {
  final koma = ",";
  Size imageSize = const Size(0.00, 0.00);

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void initState() {
    if (widget.banners != null && (widget.banners ?? []).length > 0) {
      String url = (widget.banners ?? []).first['imageUrl'] ?? "";
      final awalan2 = url.split("").elementAt(0);
      final awalIndex = url.indexOf(awalan2);
      final akhirIndex = url.indexOf(koma, awalIndex + awalan2.length);
      final imageURL = url.substring(0, akhirIndex);
      _getImageDimension(imageURL);
    }
    super.initState();
  }

  void _getImageDimension(imageURL) {
    Image image = Image.network(imageURL);
    image.image.resolve(const ImageConfiguration()).addListener(
      ImageStreamListener(
        (ImageInfo image, bool synchronousCall) {
          var myImage = image.image;
          setState(() {
            imageSize =
                Size(myImage.width.toDouble(), myImage.height.toDouble());
            widget.aspectRatio = imageSize.aspectRatio;
          });
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return 
    CarouselSlider(
        options: CarouselOptions(
          aspectRatio: widget.aspectRatio,
          viewportFraction: 1,
          initialPage: 0,
          enableInfiniteScroll: true,
          reverse: false,
          autoPlay: (widget.banners ?? []).length > 1 ? true : false,
          autoPlayInterval: const Duration(seconds: 3),
          autoPlayAnimationDuration: const Duration(milliseconds: 800),
          autoPlayCurve: Curves.fastOutSlowIn,
          enlargeCenterPage: false,
          // onPageChanged: callbackFunction,
          scrollDirection: Axis.horizontal,
        ),
        items: (widget.banners ?? [])
            .asMap()
            .map((key, value) => MapEntry(key, Builder(
                  builder: (BuildContext context) {
                    return renderImage(
                        widget.banners![key]['imageUrl'].toString(),
                        widget.banners?[key]['target']);
                  },
                )))
            .values
            .toList());
  }

  Widget renderImage(String url, String target) {
    final awalan2 = url.split("").elementAt(0);
    final awalIndex = url.indexOf(awalan2);
    final akhirIndex = url.indexOf(koma, awalIndex + awalan2.length);
    final imageUrl = url.substring(0, akhirIndex);
    final image = imageUrl.toString();

    AspectRatio imageWidget = AspectRatio(
      aspectRatio: widget.aspectRatio,
      child: CachedNetworkImage(
          imageUrl: image,
          progressIndicatorBuilder: (context, url, downloadProgress) =>
              AspectRatio(
                  aspectRatio: widget.aspectRatio,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Constants.gray.shade300,
                      shape: BoxShape.rectangle,
                    ),
                  )),
          errorWidget: (context, url, error) => AspectRatio(
              aspectRatio: 22 / 8,
              child: Container(
                key: const ValueKey("image_error"),
                decoration: BoxDecoration(
                  color: Constants.gray.shade300,
                  shape: BoxShape.rectangle,
                ),
              ))),
    );

    return InkWell(
        onTap: () async {
          await Navigator.pushNamed(context, target);
        },
        child: imageWidget);
  }
}
