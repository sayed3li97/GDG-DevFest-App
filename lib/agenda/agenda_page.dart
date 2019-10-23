import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_devfest/agenda/cloud_screen.dart';
import 'package:flutter_devfest/agenda/mobile_screen.dart';
import 'package:flutter_devfest/agenda/web_screen.dart';
import 'package:flutter_devfest/home/index.dart';
import 'package:flutter_devfest/universal/dev_scaffold.dart';
import 'package:flutter_devfest/utils/tools.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AgendaPage extends StatelessWidget {
  static const String routeName = "/agenda";

  @override
  Widget build(BuildContext context) {
    var _homeBloc = HomeBloc();
    return DefaultTabController(
      length: 3,
      child: DevScaffold(
        title: "Agenda",
        // tabBar: TabBar(
        //   indicatorSize: TabBarIndicatorSize.label,
        //   indicatorColor: Tools.multiColors[Random().nextInt(4)],
        //   labelStyle: TextStyle(
        //     fontSize: 12,
        //   ),
          // isScrollable: false,
          // tabs: <Widget>[
          //   Tab(
          //     child: Text("Cloud"),
          //     icon: Icon(
          //       FontAwesomeIcons.cloud,
          //       size: 12,
          //     ),
          //   ),
          //   Tab(
          //     child: Text("Mobile"),
          //     icon: Icon(
          //       FontAwesomeIcons.mobile,
          //       size: 12,
          //     ),
          //   ),
          //   Tab(
          //     child: Text("Web & More"),
          //     icon: Icon(
          //       FontAwesomeIcons.chrome,
          //       size: 12,
          //     ),
          //   )
          // ],
        // ),




        // body: ListView(
        //   children: <Widget>[
        //     ListTile(
        //       title: Text("Registration"),
        //       trailing: Text("9:00 AM"),
        //     ),
        //     Divider(),
        //      ListTile(
        //       title: Text("Welcome Speech"),
        //       subtitle: Text("Lana Alattar"),
        //       trailing: Text("9:30 AM"),
        //     ),
        //      Divider(),
        //      ListTile(
        //       title: Text("EDB Keynote"),
        //       subtitle: Text("Lana Alattar"),
        //       trailing: Text("9:45 AM"),
        //     ),
        //     Divider(),
        //      ListTile(
        //       title: Text("Viva Speech "),
        //       // subtitle: Text("Lana Alattar"),
        //       trailing: Text("10:00 AM"),
        //     ),
        //     Divider(),
        //      ListTile(
        //       title: Text("Rules & Guidlines"),
        //       // subtitle: Text("Lana Alattar"),
        //       trailing: Text("10:30 AM"),
        //     ),
        //     Divider(),
        //      ListTile(
        //       title: Text("Google Cloud Platform Workshop"),
        //       // subtitle: Text("Lana Alattar"),
        //       trailing: Text("11:00 AM"),
        //     ),
        //      Divider(),
        //      ListTile(
        //       title: Text("Gsuite Essentials Workshop"),
        //       // subtitle: Text("Lana Alattar"),
        //       trailing: Text("12:00 PM"),
        //     ),
        //      Divider(),
        //      ListTile(
        //       title: Text("Lunch Break"),
        //       // subtitle: Text("Lana Alattar"),
        //       trailing: Text("01:00 PM"),
        //     ),
        //     Divider(),
        //      ListTile(
        //       title: Text("Intro to ML: Language Processing Workshop"),
        //       subtitle: Text("Habiba Maher"),
        //       trailing: Text("03:00 PM"),
        //     ),
        //     Divider(),
        //      ListTile(
        //       title: Text("Google Developer Essentials Workshop"),
        //       // subtitle: Text("Habiba Maher"),
        //       trailing: Text("04:00 PM"),
        //     ),
        //     Divider(),
        //      ListTile(
        //       title: Text("Machine Learning Workshop"),
        //       subtitle: Text("Faris Rahman"),
        //       trailing: Text("05:00 PM"),
        //     ),
        //      Divider(),
        //      ListTile(
        //       title: Text("Self-Branding For Techies: Telling the world how Awesome you are! – Tentative"),
        //       subtitle: Text("Lana Alattar"),
        //       trailing: Text("06:00 PM"),
        //     ),
        //      Divider(),
        //      ListTile(
        //       title: Text("Closing and Sponsor Awards"),
        //       // subtitle: Text("Lana Alattar"),
        //       trailing: Text("07:00 PM"),
        //     ),
        //      Divider(),
        //      ListTile(
        //       title: Text("Announcing Most Badges"),
        //       // subtitle: Text("Lana Alattar"),
        //       trailing: Text("07:30 PM"),
        //     ),
        //   ],
        // )
        body: streamBuilderAgenda(),
        // body: TabBarView(
        //   children: <Widget>[
        //     CloudScreen(
        //       homeBloc: _homeBloc,
        //     ),
        //     MobileScreen(
        //       homeBloc: _homeBloc,
        //     ),
        //     WebScreen(
        //       homeBloc: _homeBloc,
        //     ),
        //   ],
        // ),

      ),
    );
  }

  Widget streamBuilderAgenda() {
    return  StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance.collection('agenda').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError)
            return new Text('Error: ${snapshot.error}');
          switch (snapshot.connectionState) {
            case ConnectionState.waiting: return Center(child: CircularProgressIndicator(),);
            default:
              return new ListView(

                padding: EdgeInsets.only(bottom: 80),
                children: snapshot.data.documents.map((DocumentSnapshot document) {
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 3, horizontal: 10),
                    child: Card(
                      child: 
                      ListTile(
                        title:  Text( document['title']),
                        subtitle:  Text( document['subtitle']),
                        trailing: Text( document['tralling']),

                      ),
                    ),
                  );
                }).toList(),
              );
          }
        },
      );
  }
}
