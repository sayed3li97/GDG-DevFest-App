import 'dart:math';
import 'dart:async';
import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_devfest/home/home_bloc.dart';
import 'package:flutter_devfest/home/index.dart';
import 'package:flutter_devfest/home/speaker.dart';
import 'package:flutter_devfest/universal/dev_scaffold.dart';
import 'package:flutter_devfest/utils/tools.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'package:json_annotation/json_annotation.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';



class BadgesPage extends StatefulWidget {
  static const String routeName = "/badges";

  @override
  _BadgesPageState createState() => _BadgesPageState();
}

class _BadgesPageState extends State<BadgesPage> {
  Future<Post> post;

  @override
  void initState() {
    super.initState();
    post = fetchPost();
  }



Future<Post> fetchPost() async {
  final response =
      await http.get('https://dev-fest-qwiklabs-crawler.herokuapp.com/parameters?url=https://www.qwiklabs.com/public_profiles/7bd5d950-8196-4406-9e24-bc30a2c5f42d');

  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON.
    return Post.fromJson(json.decode(response.body));
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load post');
  }
}

  @override
  Widget build(BuildContext context) {
    var _homeBloc = HomeBloc();
    var state = _homeBloc.currentState as InHomeState;
    var speakers = state.speakersData.speakers;
    return DevScaffold(
      body: Center(
          child: FutureBuilder<Post>(
            future: post,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if(snapshot.data.status == 1) {
                  return Text(snapshot.data.message);
                }else {
                  List<Badge> Badges = snapshot.data.badges;
                  return ListView.builder
                      (
                        itemCount: Badges.length,
                        itemBuilder: (BuildContext ctxt, int index) {
                          
                         return Padding(
                           padding: const EdgeInsets.all(8.0),
                           child: Card(
                             child: Column(
                               children: <Widget>[
                                 if (index == 0) ...{
                                   Row(
                                     crossAxisAlignment: CrossAxisAlignment.center,
                                     mainAxisAlignment: MainAxisAlignment.center,
                                     children: <Widget>[
                                       Padding(
                                         padding: EdgeInsets.all(10),
                                         child: Text("Quests: " + snapshot.data.quests),
                                       ),
                                       Padding(
                                         padding: EdgeInsets.all(10),
                                         child: Text("Labs: " + snapshot.data.labs),
                                       ),
                                     ],
                                   )
                                 },
                                    Image.network(Badges[index].img, height: 200,),
                                    Text(Badges[index].name),
                                    Text(Badges[index].date)
                               ],
                             ),
                           ),
                         );
                        }
                      );
                }
                
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }

              // By default, show a loading spinner.
              return SpinKitChasingDots(
                  color: Tools.multiColors[Random().nextInt(3)],
                );
            },
          ),
        ),

      title: "Badges",
    );


    
  }
}

@JsonSerializable()
class Badge {
  final String name;
  final String date;
  final String img;
  Badge({this.name, this.date, this.img});

  factory Badge.fromJson(Map<String, dynamic> json) {
    return Badge(
      name: json['Badge'],
      date: json['Date'],
      img: json['img'],

    );

  }
}
class BadgeList{
  List<Badge> badges;

  BadgeList({this.badges});

  factory BadgeList.fromJson(List<dynamic> json) {
  return BadgeList(
      badges: json.map<Badge>((e) => Badge.fromJson(e as Map<String, dynamic>)).toList());
          
}
}

class Post {
  final String message;
  final String quests;
  final String labs;
  final int status;
  final List<Badge> badges; 
  // final String title;
  // final String body;

  Post({this.message, this.status, this.badges, this.labs, this.quests});

  factory Post.fromJson(Map<String, dynamic> json) {
    print("Badges = ");
    print( json['bagdes']);
    BadgeList badgeList = BadgeList.fromJson(json['bagdes']);

    return Post(
      message: json['Message'],
      status: json['Status'],
      labs: json['Labs'],
      quests: json['Quests'],
      badges:  badgeList.badges,

    );
  }
}