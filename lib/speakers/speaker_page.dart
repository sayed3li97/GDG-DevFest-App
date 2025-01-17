import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_devfest/home/home_bloc.dart';
import 'package:flutter_devfest/home/index.dart';
import 'package:flutter_devfest/home/speaker.dart';
import 'package:flutter_devfest/universal/dev_scaffold.dart';
import 'package:flutter_devfest/utils/tools.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SpeakerPage extends StatelessWidget {
  static const String routeName = "/speakers";

  Widget socialActions(context, Speaker speaker) => FittedBox(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
              icon: Icon(
                FontAwesomeIcons.facebookF,
                size: 15,
              ),
              onPressed: () {
                launch(speaker.fbUrl);
              },
            ),
            IconButton(
              icon: Icon(
                FontAwesomeIcons.twitter,
                size: 15,
              ),
              onPressed: () {
                launch(speaker.twitterUrl);
              },
            ),
            IconButton(
              icon: Icon(
                FontAwesomeIcons.linkedinIn,
                size: 15,
              ),
              onPressed: () {
                launch(speaker.linkedinUrl);
              },
            ),
            IconButton(
              icon: Icon(
                FontAwesomeIcons.github,
                size: 15,
              ),
              onPressed: () {
                launch(speaker.githubUrl);
              },
            ),
          ],
        ),
      );

Widget streamBuilderSpeakers() {
    return  StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance.collection('speakers').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError)
            return new Text('Error: ${snapshot.error}');
          switch (snapshot.connectionState) {
            case ConnectionState.waiting: return Center(child: SpinKitChasingDots(
                  color: Tools.multiColors[Random().nextInt(3)],
                ),);
            default:
              return new ListView(

                padding: EdgeInsets.only(bottom: 80),
                children: snapshot.data.documents.map((DocumentSnapshot document) {
                  return Card(
                    elevation: 0.0,
                    child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            ConstrainedBox(
                              constraints: BoxConstraints.expand(
                                height: MediaQuery.of(context).size.height * 0.2,
                                width: MediaQuery.of(context).size.width * 0.3,
                              ),
                              child: CachedNetworkImage(
                                fit: BoxFit.cover,
                                imageUrl: document['img'],
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Text(
                                        document['speakerName'],
                                        style: Theme.of(context).textTheme.title,
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      AnimatedContainer(
                                        duration: Duration(seconds: 1),
                                        width: MediaQuery.of(context).size.width * 0.2,
                                        height: 5,
                                        color: Tools.multiColors[Random().nextInt(4)],
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    document['desc'],
                                    style: Theme.of(context).textTheme.subtitle,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    document['session'],
                                    style: Theme.of(context).textTheme.caption,
                                  ),
                                  // socialActions(context, speakers[i]),
                                ],
                              ),
                            )
                          ],
                        )),
                     );
                }).toList(),
              );
          }
        },
      );
  }
  @override
  Widget build(BuildContext context) {
    var _homeBloc = HomeBloc();
    var state = _homeBloc.currentState as InHomeState;
    var speakers = state.speakersData.speakers;
    return DevScaffold(
      // body: ListView.builder(
      //   shrinkWrap: true,
      //   itemBuilder: (c, i) {
      //     return Card(
      //       elevation: 0.0,
      //       child: Padding(
      //           padding: const EdgeInsets.all(12.0),
      //           child: Row(
      //             mainAxisSize: MainAxisSize.min,
      //             children: <Widget>[
      //               ConstrainedBox(
      //                 constraints: BoxConstraints.expand(
      //                   height: MediaQuery.of(context).size.height * 0.2,
      //                   width: MediaQuery.of(context).size.width * 0.3,
      //                 ),
      //                 child: CachedNetworkImage(
      //                   fit: BoxFit.cover,
      //                   imageUrl: speakers[i].speakerImage,
      //                 ),
      //               ),
      //               SizedBox(
      //                 width: 20,
      //               ),
      //               Expanded(
      //                 child: Column(
      //                   crossAxisAlignment: CrossAxisAlignment.start,
      //                   mainAxisAlignment: MainAxisAlignment.start,
      //                   mainAxisSize: MainAxisSize.min,
      //                   children: <Widget>[
      //                     Column(
      //                       crossAxisAlignment: CrossAxisAlignment.start,
      //                       mainAxisSize: MainAxisSize.min,
      //                       children: <Widget>[
      //                         Text(
      //                           speakers[i].speakerName,
      //                           style: Theme.of(context).textTheme.title,
      //                         ),
      //                         SizedBox(
      //                           height: 5,
      //                         ),
      //                         AnimatedContainer(
      //                           duration: Duration(seconds: 1),
      //                           width: MediaQuery.of(context).size.width * 0.2,
      //                           height: 5,
      //                           color: Tools.multiColors[Random().nextInt(4)],
      //                         ),
      //                       ],
      //                     ),
      //                     SizedBox(
      //                       height: 10,
      //                     ),
      //                     Text(
      //                       speakers[i].speakerDesc,
      //                       style: Theme.of(context).textTheme.subtitle,
      //                     ),
      //                     SizedBox(
      //                       height: 10,
      //                     ),
      //                     Text(
      //                       speakers[i].speakerSession,
      //                       style: Theme.of(context).textTheme.caption,
      //                     ),
      //                     // socialActions(context, speakers[i]),
      //                   ],
      //                 ),
      //               )
      //             ],
      //           )),
      //     );
      //   },
      //   itemCount: speakers.length,
      // ),


      body: streamBuilderSpeakers(),
      title: "Speakers",
    );


    
  }

//  @override
//   Widget build(BuildContext context) {
//     // var _homeBloc = HomeBloc();
//     // var state = _homeBloc.currentState as InHomeState;
//     // var speakers = state.speakersData.speakers;
//     // return DevScaffold(
//     //               title: "Speakers",
//     //               body: 

//      return StreamBuilder<QuerySnapshot>(
//         stream: Firestore.instance.collection('speakers').snapshots(),
//         builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//           if (snapshot.hasError)
//             return new Text('Error: ${snapshot.error}');
//           switch (snapshot.connectionState) {
//             case ConnectionState.waiting: return Center(child: CircularProgressIndicator(),);
//             default:
//               return new ListView(
//                 padding: EdgeInsets.only(bottom: 80),
//                 children: snapshot.data.documents.map((DocumentSnapshot speakers) {
//                    Card(
//                   elevation: 0.0,
//                   child: Padding(
//                     padding: const EdgeInsets.all(12.0),
//                     child: Row(
//                   mainAxisSize: MainAxisSize.min,
//                   children: <Widget>[
//                     ConstrainedBox(
//                       constraints: BoxConstraints.expand(
//                         height: MediaQuery.of(context).size.height * 0.2,
//                         width: MediaQuery.of(context).size.width * 0.3,
//                       ),
//                       child: CachedNetworkImage(
//                         fit: BoxFit.cover,
//                         imageUrl: speakers["speaker_image"],
//                       ),
//                     ),
//                     SizedBox(
//                       width: 20,
//                     ),
//                     Expanded(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         mainAxisSize: MainAxisSize.min,
//                         children: <Widget>[
//                           Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             mainAxisSize: MainAxisSize.min,
//                             children: <Widget>[
//                               Text(
//                                 speakers["speaker_name"],
//                                 style: Theme.of(context).textTheme.title,
//                               ),
//                               SizedBox(
//                                 height: 5,
//                               ),
//                               AnimatedContainer(
//                                 duration: Duration(seconds: 1),
//                                 width: MediaQuery.of(context).size.width * 0.2,
//                                 height: 5,
//                                 color: Tools.multiColors[Random().nextInt(4)],
//                               ),
//                             ],
//                           ),
//                           SizedBox(
//                             height: 10,
//                           ),
//                           Text(
//                             speakers["speaker_desc"],
//                             style: Theme.of(context).textTheme.subtitle,
//                           ),
//                           SizedBox(
//                             height: 10,
//                           ),
//                           Text(
//                             speakers["speaker_session"],
//                             style: Theme.of(context).textTheme.caption,
//                           ),
//                           // socialActions(context, speakers),
//                         ],
//                       ),
//                     )
//                   ],
//                 )),
//           );
            
//                 }).toList(),
//               );


//           }
//         },
//       //  )
//       );

//   }



}
