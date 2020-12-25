import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Smart Glasses"),
        ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: RaisedButton(
          onPressed: () {},
          child: Text(
            "Connect",
            style: TextStyle(
              fontFamily: 'IndieFlower',
            )
          )
        )
      ),
    )
  ));