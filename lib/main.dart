import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'BLEscan.dart';

void main() => runApp(MaterialApp(
      //debugShowCheckedModeBanner: false,
      home: Home(),
    ));

class Home extends StatelessWidget {
  @override
  Widget build (BuildContext ctxt) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Smart Glasses"),
      ),
      floatingActionButton: new FloatingActionButton(
          onPressed: (){
            Navigator.push(
              ctxt,
              new MaterialPageRoute(builder: (ctxt) => new BLE()),
            );
          },
          child: Icon(Icons.add),
      )
    );
  }
}