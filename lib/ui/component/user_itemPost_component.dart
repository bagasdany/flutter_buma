// ignore_for_file: avoid_unnecessary_containers

import 'package:buma/infrastructure/database/shared_prefs.dart';
import 'package:buma/ui/component/app_shimmer.dart';
import 'package:buma/ui/component/zoom_interactive.dart';
import 'package:buma/ui/style/constants.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserItemPostComponent extends StatelessWidget {
  final dynamic item;

  double xOffset = 0;
  dynamic expand;
  final _sharedPrefs = SharedPrefs();
  Offset offset = Offset.zero;
  double yOffset = 0;


  final formatter = intl.NumberFormat.decimalPattern();

  UserItemPostComponent(this.item, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    List<String> tags =(item?['tags'] as List).map((item) => item as String).toList();
    print(tags);

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
                Icon(Icons.favorite,color: Constants.primaryColor,),
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
    String defaultcolor = "#BC4747";
    String getcolor = item?['tag'] != null
        ? item['tag']!['color']!.replaceAll('#', '0xff')
        : defaultcolor.replaceAll('#', '0xff');
    var color = int.parse(getcolor);
    
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed("/user/${item['id']}");
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
    );
  }
}
