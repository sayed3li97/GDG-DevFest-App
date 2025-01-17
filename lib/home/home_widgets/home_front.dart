import 'package:flutter/material.dart';
import 'package:flutter_devfest/agenda/agenda_page.dart';
import 'package:flutter_devfest/badges/badges_page.dart';
import 'package:flutter_devfest/config/index.dart';
import 'package:flutter_devfest/faq/faq_page.dart';
import 'package:flutter_devfest/map/map_page.dart';
import 'package:flutter_devfest/speakers/speaker_page.dart';
import 'package:flutter_devfest/sponsors/sponsor_page.dart';
import 'package:flutter_devfest/team/team_page.dart';
import 'package:flutter_devfest/universal/image_card.dart';
import 'package:flutter_devfest/utils/devfest.dart';
import 'package:flutter_devfest/utils/tools.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_devfest/qr/ScanScreen.dart';
import 'package:flutter_devfest/signup/login_page.dart';

class HomeFront extends StatelessWidget {
  List<Widget> devFestTexts(context) => [
        Text(
          Devfest.welcomeText,
          style: Theme.of(context).textTheme.headline,
          textAlign: TextAlign.center,
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          Devfest.descText,
          style: Theme.of(context).textTheme.caption,
          textAlign: TextAlign.center,
        ),
      ];

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Widget actions(context) => Wrap(
        alignment: WrapAlignment.center,
        spacing: 10.0,
        children: <Widget>[
          RaisedButton(
            child: Text("Agenda"),
            shape: StadiumBorder(),
            color: Colors.red,
            colorBrightness: Brightness.dark,
            onPressed: () => Navigator.pushNamed(context, AgendaPage.routeName),
          ),
          RaisedButton(
            child: Text("Speakers"),
            shape: StadiumBorder(),
            color: Colors.green,
            colorBrightness: Brightness.dark,
            onPressed: () =>
                Navigator.pushNamed(context, SpeakerPage.routeName),
          ),
          RaisedButton(
            child: Text("Sponsors"),
            shape: StadiumBorder(),
            color: Colors.orange,
            colorBrightness: Brightness.dark,
            onPressed: () =>
                Navigator.pushNamed(context, SponsorPage.routeName),
          ),
          RaisedButton(
            child: Text("Team"),
            shape: StadiumBorder(),
            color: Colors.purple,
            colorBrightness: Brightness.dark,
            onPressed: () => Navigator.pushNamed(context, TeamPage.routeName),
          ),
          RaisedButton(
            child: Text("FAQ"),
            shape: StadiumBorder(),
            color: Colors.brown,
            colorBrightness: Brightness.dark,
            onPressed: () => Navigator.pushNamed(context, FaqPage.routeName),
          ),
          RaisedButton(
            child: Text("Locate Us"),
            shape: StadiumBorder(),
            color: Colors.blue,
            colorBrightness: Brightness.dark,
            onPressed: () => Navigator.pushNamed(context, MapPage.routeName),
          ),
        ],
      );

  Widget newActions(context) => Wrap(
        alignment: WrapAlignment.center,
        spacing: 20.0,
        runSpacing: 20.0,
        children: <Widget>[
          ActionCard(
            icon: Icons.schedule,
            color: Colors.red,
            title: Devfest.agenda_text,
            onPressed: () => Navigator.pushNamed(context, AgendaPage.routeName),
          ),
          ActionCard(
            icon: Icons.person,
            color: Colors.green,
            title: Devfest.speakers_text,
            onPressed: () =>
                Navigator.pushNamed(context, SpeakerPage.routeName),
          ),
          // ActionCard(
          //   icon: Icons.people,
          //   color: Colors.amber,
          //   title: Devfest.team_text,
          //   onPressed: () => Navigator.pushNamed(context, TeamPage.routeName),
          // ),
          ActionCard(
            icon: Icons.attach_money,
            color: Colors.purple,
            title: Devfest.sponsor_text,
            onPressed: () =>
                Navigator.pushNamed(context, SponsorPage.routeName),
          ),
          ActionCard(
            icon: Icons.camera_rear,
            color: Colors.brown,
            title: "Badges",
            onPressed: () => Navigator.pushNamed(context, BadgesPage.routeName),
          ),
          ActionCard(
            icon: Icons.camera,
            color: Colors.red,
            title: "QR Reader",
            onPressed: () => Navigator.pushNamed(context, ScanScreen.routeName),
          ),
          ActionCard(
            icon: Icons.map,
            color: Colors.blue,
            title: Devfest.map_text,
            onPressed: () => Navigator.pushNamed(context, MapPage.routeName),
          )
        ],
      );

  Widget socialActions(context) => FittedBox(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(
              icon: Icon(FontAwesomeIcons.facebookF),
              onPressed: () async {
                await _launchURL("https://facebook.com/imthepk");
              },
            ),
            IconButton(
              icon: Icon(FontAwesomeIcons.twitter),
              onPressed: () async {
                await _launchURL("https://twitter.com/imthepk");
              },
            ),
            IconButton(
              icon: Icon(FontAwesomeIcons.linkedinIn),
              onPressed: () async {
                _launchURL("https://linkedin.com/in/imthepk");
              },
            ),
            IconButton(
              icon: Icon(FontAwesomeIcons.youtube),
              onPressed: () async {
                await _launchURL("https://youtube.com/mtechviral");
              },
            ),
            IconButton(
              icon: Icon(FontAwesomeIcons.meetup),
              onPressed: () async {
                await _launchURL("https://meetup.com/");
              },
            ),
            IconButton(
              icon: Icon(FontAwesomeIcons.envelope),
              onPressed: () async {
                var emailUrl =
                    '''mailto:mtechviral@gmail.com?subject=Support Needed For DevFest App&body={Name: Pawan Kumar},Email: pawan221b@gmail.com}''';
                var out = Uri.encodeFull(emailUrl);
                await _launchURL(out);
              },
            ),
          ],
        ),
      );


Widget socialActionsHome(context) => FittedBox(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(
              icon: Icon(FontAwesomeIcons.instagram),
              onPressed: () async {
                await _launchURL("https://www.instagram.com/gdgmanama/");
              },
            ),
            IconButton(
              icon: Icon(FontAwesomeIcons.facebookF),
              onPressed: () async {
                await _launchURL("https://www.facebook.com/GDGManama/?hc_ref=ARSHso-vNs85kFrdr-C1QkTESb0-0nSpyRYxoSiM2_nRYxhaDcjiMN46zzZn0VFfAf0&fref=nf&__xts__%5B0%5D=68.ARBxuwGcX2ZcX3k9_jpf25qoVsehpQ93iOa9GimPPIoZ8wFaiBtDeAkXLdEmoHnGscLedXgrskWSbhNW3qU2D5hz4Z-kPN2SXFaHN-Ho4_WvDjfzHivq_bTf2pNDlGm7XIADWIyKlXPoZ31DMSsGU-kAFYH2E9dSEN54xwZaim7u-cyeMPsJmIx0MPaMJyYTiqF_6D0zKxmZ1Ce0xGMQWEECPcDOaYXfbDJ5STaUcu0T5N2FoCF83XlXBDNC-7tfNKslC3L272LZborTeS--_cqXulMCWO-7aPRCr_sMZCshc_SY3GAYpfdVOoQ_7R6hwpBwnHsI6prZjWwLRF9M4U0&__tn__=kC-R");
              },
            ),
            IconButton(
              icon: Icon(FontAwesomeIcons.twitter),
              onPressed: () async {
                await _launchURL("https://twitter.com/GdgManama");
              },
            ),
            IconButton(
              icon: Icon(FontAwesomeIcons.linkedinIn),
              onPressed: () async {
                _launchURL("https://www.linkedin.com/company/gdg-manama/");
              },
            ),
            
            // IconButton(
            //   icon: Icon(FontAwesomeIcons.youtube),
            //   onPressed: () async {
            //     await _launchURL("https://youtube.com/mtechviral");
            //   },
            // ),
            IconButton(
              icon: Icon(FontAwesomeIcons.meetup),
              onPressed: () async {
                await _launchURL("https://www.meetup.com/GDG-Manama/");
              },
            ),
           IconButton(
              icon: Icon(FontAwesomeIcons.chrome),
              onPressed: () async {
                _launchURL("http://devfestbahrain.com/");
              },
            ),
          ],
        ),
      );
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            ImageCard(
              img: ConfigBloc().darkModeOn
                  ? Devfest.banner_dark
                  : Devfest.banner_light,
            ),
            SizedBox(
              height: 20,
            ),
            ...devFestTexts(context),
            Padding(
              padding: EdgeInsets.only(top: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                
                    RaisedButton(
                    color: Colors.green,
                    child: Text("Sign up ", style: TextStyle(color: Colors.white),),
                    onPressed: (){
                      Navigator.pushNamed(context, LoginPage.routeName);
                    },
                  ),

                  RaisedButton(
                  color: Colors.blue,
                  child: Text("log in ", style: TextStyle(color: Colors.white),),
                  onPressed: (){
                    Navigator.pushNamed(context, LoginPage.routeName);
                  },
                ),
                
                ],
              )
            ),
            SizedBox(
              height: 20,
            ),
            newActions(context),
            SizedBox(
              height: 20,
            ),
            socialActionsHome(context),
            SizedBox(
              height: 20,
            ),
            Text(
              Devfest.app_version,
              style: Theme.of(context).textTheme.caption.copyWith(fontSize: 10),
            )
          ],
        ),
      ),
    );
  }
}

class ActionCard extends StatelessWidget {
  final Function onPressed;
  final IconData icon;
  final String title;
  final Color color;

  const ActionCard({Key key, this.onPressed, this.icon, this.title, this.color})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: onPressed,
      child: Ink(
        height: MediaQuery.of(context).size.height * 0.1,
        width: MediaQuery.of(context).size.width * 0.2,
        decoration: BoxDecoration(
          color: ConfigBloc().darkModeOn
              ? Tools.hexToColor("#1f2124")
              : Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: !ConfigBloc().darkModeOn
              ? [
                  BoxShadow(
                    color: Colors.grey[200],
                    blurRadius: 10,
                    spreadRadius: 5,
                  )
                ]
              : null,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              icon,
              color: color,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              title,
              style: Theme.of(context).textTheme.title.copyWith(
                    fontSize: 12,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
