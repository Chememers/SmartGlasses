import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

void main() => runApp(MaterialApp(
      //debugShowCheckedModeBanner: false,
      home: Home(),
    ));

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  void showDevices() {
    FlutterBlue flutterBlue = FlutterBlue.instance;
    flutterBlue.startScan(timeout: Duration(seconds: 4));

    var subscription = flutterBlue.scanResults.listen((results) {
      for (ScanResult r in results) {
        print('${r.device.name} found! rssi: ${r.rssi}');
      }
    });

    flutterBlue.stopScan();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Smart Glasses"),
      ),
      body: Container(
          padding: EdgeInsets.all(20.0),
          child: RaisedButton(
              onPressed: () {
                showDevices();
              },
              child: Text("Connect",
                  style: TextStyle(
                    fontFamily: 'IndieFlower',
            )
          )
        )
      ),
    );
  }
}
