import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_devfest/universal/dev_scaffold.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_devfest/utils/tools.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SponsorPage extends StatelessWidget {
  static const String routeName = "/sponsor";
  Widget streamBuilderImage() {
    return  StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance.collection("sponserImg").snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError)
            return new Text('Error: ${snapshot.error}');
          switch (snapshot.connectionState) {
            case ConnectionState.waiting: return Center(child: SpinKitChasingDots(
                  color: Tools.multiColors[Random().nextInt(3)],
                ));
            default:
              return new ListView(

                padding: EdgeInsets.only(bottom: 80),
                children: snapshot.data.documents.map((DocumentSnapshot document) {
                      return SponsorImage(
                        imgUrl: document['image'],
                      );
                }).toList(),
              );
          }
        },
      );
  }
  Widget streamBuilderImages(String title) {
    return  StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance.collection(title).snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError)
            return new Text('Error: ${snapshot.error}');
          switch (snapshot.connectionState) {
            case ConnectionState.waiting: return Center(child: CircularProgressIndicator(),);
            default:
              return new ListView(

                padding: EdgeInsets.only(bottom: 80),
                children: snapshot.data.documents.map((DocumentSnapshot document) {
                      return SponsorImage(
                        imgUrl: document['image'],
                      );
                }).toList(),
              );
          }
        },
      );
  }
Widget streamBuilderSponsors() {
    return  StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance.collection('sponsors').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError)
            return new Text('Error: ${snapshot.error}');
          switch (snapshot.connectionState) {
            case ConnectionState.waiting: return Center(child: CircularProgressIndicator(),);
            default:
              return new ListView(

                padding: EdgeInsets.only(bottom: 80),
                children: snapshot.data.documents.map((DocumentSnapshot document) {
                  if (document['title'] != null){
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                       padding: EdgeInsets.all(10),
                       // alignment: Alignment.center,
                       child: Align(
                         alignment: Alignment.center,
                         child: Text(document['title'], 
                         style: TextStyle(
                       fontSize: 30,
                       fontWeight: FontWeight.bold,
                     ),
                     ),
                     ),
                     ),
                     SponsorImage(
                       imgUrl: document['image'],
                     )
                    ],
                  );
                  }else{
                    return Column(
                    children: <Widget>[
                      
                     SponsorImage(
                       imgUrl: document['image'],
                     )
                    ],
                  );
                  }
                  
                }).toList(),
              );
          }
        },
      );
  }
 
 
  @override
  Widget build(BuildContext context) {
    // var _homeBloc = HomeBloc();
    return DevScaffold(
      body: streamBuilderImage(),
      // body: ListView(
      //   children: <Widget>[
      //     Padding(
      //       padding: EdgeInsets.all(10),
      //       // alignment: Alignment.center,
      //       child: Align(
      //         alignment: Alignment.center,
      //         child: Text("Headliner", 
      //         style: TextStyle(
      //       fontSize: 30,
      //       fontWeight: FontWeight.bold,
      //     ),
      //     ),
      //     ),
      //     ),
      //     streamBuilderImages("headliner"),
      //     // SizedBox(
      //     //   height: 30,
      //     // ),
      //     Padding(
      //       padding: EdgeInsets.all(10),
      //       // alignment: Alignment.center,
      //       child: Align(
      //         alignment: Alignment.center,
      //         child: Text("Sponsor", 
      //         style: TextStyle(
      //       fontSize: 30,
      //       fontWeight: FontWeight.bold,
      //     ),
      //     ),
      //     ),
      //     ),
      //     streamBuilderImages("sponsors"),
      //     // SizedBox(
      //     //   height: 30,
      //     // ),
      //     Padding(
      //       padding: EdgeInsets.all(10),
      //       // alignment: Alignment.center,
      //       child: Align(
      //         alignment: Alignment.center,
      //         child: Text("Partners", 
      //         style: TextStyle(
      //       fontSize: 30,
      //       fontWeight: FontWeight.bold,
      //     ),
      //     ),
      //     ),
      //     ),
      //     streamBuilderImages("partners"),
      //   ],
      // ),
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
