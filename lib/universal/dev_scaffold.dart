import 'package:flutter/material.dart';
import 'package:flutter_devfest/config/config_bloc.dart';
import 'package:flutter_devfest/config/config_event.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:share/share.dart';

class DevScaffold extends StatelessWidget {
  final String title;
  final Widget body;
  final Widget tabBar;
  final bool homeIsavailable;

  const DevScaffold(
      {Key key, @required this.body, @required this.title, this.tabBar, this.homeIsavailable})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 500),
      color: ConfigBloc().darkModeOn ? Colors.grey[800] : Colors.white,
      child: SafeArea(
        top: false,
        bottom: false,
        child: Scaffold(
          appBar: AppBar(
            
            title: Text(title),
            centerTitle: true,
            bottom: tabBar != null ? tabBar : null,
            actions: <Widget>[
              IconButton(
                icon: Icon(
                  ConfigBloc().darkModeOn
                      ? FontAwesomeIcons.lightbulb
                      : FontAwesomeIcons.solidLightbulb,
                  size: 18,
                ),
                onPressed: () {
                  ConfigBloc()
                      .dispatch(DarkModeEvent(!ConfigBloc().darkModeOn));
                },
              ),
              IconButton(
                onPressed: () => Share.share(
                    "Join us on the Saturday, October 26, 2019 for \n Bahrain DevFest 2019 - Badge-a-Thon! - https://www.meetup.com/GDG-Manama/events/255523381/"),
                icon: Icon(
                  Icons.share,
                  size: 20,
                ),
              ),
            ],
          ),
          body: body,
        
        ),
      ),
    );
  }
}
