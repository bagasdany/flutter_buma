// ignore_for_file: avoid_unnecessary_containers

import 'package:buma/ui/style/constants.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;

class UserItemComponent extends StatelessWidget {
  final dynamic item;

  double xOffset = 0;
  dynamic expand;
  Offset offset = Offset.zero;
  double yOffset = 0;

  final formatter = intl.NumberFormat.decimalPattern();

  UserItemComponent(this.item, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String defaultcolor = "#BC4747";
    String getcolor = item?['tag'] != null
        ? item['tag']!['color']!.replaceAll('#', '0xff')
        : defaultcolor.replaceAll('#', '0xff');
    var color = int.parse(getcolor);
    String imageSrc = item != null
        // ignore: prefer_if_null_operators
        ? item['picture'] != null
            ? item['picture']
            : item['picture'] != null
                ? item['picture']
                : 'https://i.pinimg.com/564x/b8/b8/f7/b8b8f787c454cf1ded2d9d870707ed96.jpg'
        : 'https://i.pinimg.com/564x/b8/b8/f7/b8b8f787c454cf1ded2d9d870707ed96.jpg';

    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed("/user/${item['id']}");
      },
      child: Container(
        // 
        decoration: BoxDecoration(
             borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(Constants.spacing4),
                          topRight: Radius.circular(Constants.spacing4)),
            border: Border.all(
                    color: Constants.gray.shade400,
                    width: 1,
                  )
           ),
        child: Wrap(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                      color: Constants.white,
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(Constants.spacing4),
                          topRight: Radius.circular(Constants.spacing4)),
                    
                    ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  //
                  Container(
                    
                    padding: EdgeInsets.fromLTRB(Constants.spacing4, Constants.spacing4, Constants.spacing4, 0),
                    child: AspectRatio(
                      aspectRatio: 1/1,
                      child: Stack(
                        alignment: Alignment.bottomLeft,
                        children: [
                          CachedNetworkImage(
                              imageUrl: imageSrc,
                              fit: BoxFit.cover,
                              imageBuilder: (context, imageProvider) =>
                                  AspectRatio(
                                    aspectRatio: 1/1,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Constants.white,
                                        // shape: BoxShape.circle,
                                        image: DecorationImage(
                                            image: imageProvider,
                                            fit: BoxFit.contain),
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
                  Container(
                    margin: const EdgeInsets.symmetric(
                        vertical: Constants.spacing3),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: Constants.spacing3),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Container(
                                  child: Text(
                                    "${(item?['title'] ?? "")} ${(item?['firstName'] ?? "")} ${(item?['lastName'] ?? "")}",
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontFamily: Constants.primaryFontBold,
                                        fontSize: Constants.fontSizeMd),textAlign: TextAlign.center,
                                  ),
                                  margin: const EdgeInsets.fromLTRB(
                                      0, 0, 0, Constants.spacing1),
                                ),
                              ),
                            ],
                          ),
                        ),

                        Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: Constants.spacing3),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Container(
                                  child: Text(
                                    "${(item?['firstName'] ?? "")}${(item?['lastName'] ?? "")}@example.com",
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      color: Constants.gray,
                                        fontSize: Constants.fontSizeXs),textAlign: TextAlign.center,
                                        maxLines: 1,
                                  ),
                                  margin: const EdgeInsets.fromLTRB(
                                      0, 0, 0, Constants.spacing1),
                                ),
                              ),
                            ],
                          ),
                        ),
                        
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
