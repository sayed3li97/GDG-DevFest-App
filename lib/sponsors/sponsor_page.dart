import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_devfest/universal/dev_scaffold.dart';

class SponsorPage extends StatelessWidget {
  static const String routeName = "/sponsor";

  @override
  Widget build(BuildContext context) {
    // var _homeBloc = HomeBloc();
    return DevScaffold(
      body: ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(10),
            // alignment: Alignment.center,
            child: Align(
              alignment: Alignment.center,
              child: Text("Headliner", 
              style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
          ),
          ),
          ),
          SponsorImage(
            imgUrl: "http://imake-apps.com/devfestbahrain/img/sponsers/edblogo.png",
          ),
          // SizedBox(
          //   height: 30,
          // ),
          Padding(
            padding: EdgeInsets.all(10),
            // alignment: Alignment.center,
            child: Align(
              alignment: Alignment.center,
              child: Text("Sponsor", 
              style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
          ),
          ),
          ),
          SponsorImage(
            imgUrl: "http://imake-apps.com/devfestbahrain/img/sponsers/VIVA_Eng%20Logo.jpg",
          ),
          // SizedBox(
          //   height: 30,
          // ),
          Padding(
            padding: EdgeInsets.all(10),
            // alignment: Alignment.center,
            child: Align(
              alignment: Alignment.center,
              child: Text("Parteners", 
              style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
          ),
          ),
          ),
          SponsorImage(
            imgUrl:
                "http://imake-apps.com/devfestbahrain/img/sponsers/StartUp-Bahrain-Logo.png",
          ),
          SizedBox(
            height: 30,
          ),
          SponsorImage(
            imgUrl:
                "http://imake-apps.com/devfestbahrain/img/sponsers/majra-orange.png",
          )
        ],
      ),
      title: "Sponsors",
    );
  }
}

class SponsorImage extends StatelessWidget {
  final String imgUrl;

  const SponsorImage({Key key, this.imgUrl}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.0,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: CachedNetworkImage(
          imageUrl: imgUrl,
          height: 200.0,
          width: 200.0,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
