import 'dart:async';

import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_devfest/config/config_bloc.dart';
import 'package:flutter_devfest/universal/dev_scaffold.dart';

class ScanScreen extends StatefulWidget {
  static const String routeName = "/scan";
  @override
  _ScanState createState() => new _ScanState();
}

class _ScanState extends State<ScanScreen> {
  String barcode = "";

  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DevScaffold(
       title: "QR Reader",
        body: new Center(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child:
                
                 RaisedButton(
                   
                   elevation: 0.0, 
                    color:  ConfigBloc().darkModeOn ? Colors.black : Colors.white,
                    textColor:  ConfigBloc().darkModeOn ?  Colors.white : Colors.black,
                    // splashColor: Colors.blueGrey,
                    onPressed: scan,
                    child: Column(
                      children: <Widget>[
                        Icon(Icons.camera_alt, size: 200, color: ConfigBloc().darkModeOn ? Colors.white : Colors.red ,),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: Text('Click to start camera scan'),
                      )
                      ],
                    )
                ),
              )
              ,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Text(barcode, textAlign: TextAlign.center,),
              )
              ,
            ],
          ),
        ));
  }

  Future scan() async {
    try {
      String barcode = await BarcodeScanner.scan();
      setState(() {
      this.barcode = barcode;
      }
      );
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.CameraAccessDenied) {
        setState(() {
          this.barcode = 'The user did not grant the camera permission!';
        });
      } else {
        setState(() => this.barcode = 'Unknown error: $e');
      }
    } on FormatException{
      setState(() => this.barcode = 'Nothing was detected');
    } catch (e) {
      setState(() => this.barcode = 'Unknown error: $e');
    }
  }
}