import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:fluttertoast/fluttertoast.dart';

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
              connection = await BluetoothConnection.toAddress(MACAddress);
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

class Messager extends StatefulWidget {
  @override
  MessagerState createState() {
    return MessagerState();
  }
}

class MessagerState extends State<Messager> {
  final _formKey = GlobalKey<FormState>();
  final myController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: TextFormField(
              decoration: const InputDecoration(
                hintText: 'Send text',
              ),
              controller: myController,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: ElevatedButton(
              onPressed: () {
                if (!(connection == null || !connection.isConnected)) {
                  List<int> list = myController.text.codeUnits;
                  Uint8List bytes = Uint8List.fromList(list);
                  connection.output.add(bytes);
                }
              },
              child: Text('Submit'),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }
}
