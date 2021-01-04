import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:smart_glasses/messager.dart';

String MACAddress = "00:18:E4:34:BE:8E"; //MAC Address of HC-06 Module
BluetoothConnection connection;

void main() => runApp(MaterialApp(
      //debugShowCheckedModeBanner: false,
      home: Home(),
    ));

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext ctxt) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Smart Glasses"),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 20, right: 20, top: 10),
        child: Column(
          children: [
            Messager(),
          ],
        ),
      ),
      floatingActionButton: new FloatingActionButton(
          onPressed: () async {
            if (connection == null || !connection.isConnected) {
              try {
                connection = await BluetoothConnection.toAddress(MACAddress);
              } catch (e) {
                Fluttertoast.showToast(
                  msg: "Make sure you have enabled Bluetooth.",
                  toastLength: Toast.LENGTH_SHORT,
                );
              }
              if (connection.isConnected) {
                Fluttertoast.showToast(
                  msg: "Connected to Glasses",
                  toastLength: Toast.LENGTH_SHORT,
                );
              }
            } else {
              connection.close();
              Fluttertoast.showToast(
                msg: "Disconnected",
                toastLength: Toast.LENGTH_SHORT,
              );
            }
          },
          child: Icon(Icons.bluetooth)),
    );
  }
}
