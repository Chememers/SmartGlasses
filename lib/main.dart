import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:smart_glasses/messager.dart';
import 'package:smart_glasses/settings.dart';

String MACAddress = "00:18:E4:34:BE:8E"; //MAC Address of HC-06 Module
BluetoothConnection connection;

String getTime() {
  // Returns the command to set the time on the Arduino
  var now = DateTime.now();
  return "setTime ${now.hour} ${now.minute} ${now.second} ${now.day} ${now.month} ${now.year}";
}

void sendString(String msg) {
  List<int> list = msg.codeUnits;
  Uint8List bytes = Uint8List.fromList(list);
  connection.output.add(bytes);
}

void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Smart Glasses",
      home: Home(),
    ));

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
            title: new Text("Smart Glasses"),
            centerTitle: true,
            backgroundColor: Colors.purple[900],
            actions: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.settings,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Settings()),
                  );
                },
              )
            ]),
        body: Container(
          padding: EdgeInsets.only(left: 20, right: 20, top: 10),
          child: Column(
            children: <Widget>[
              Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: Button("Message", Icons.message, () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Messager()),
                      );
                    }),
                  ),
                  SizedBox(height: 10), // Spacing
                  SizedBox(
                    width: double.infinity,
                    child: Button("Navigate", Icons.place, () {
                      print("Yet to Implement");
                    }),
                  ),
                ],
              ),
            ],
          ),
        ),
        floatingActionButton: new FloatingActionButton(
          heroTag: null,
          onPressed: () async {
            if (connection == null || !connection.isConnected) {
              try {
                connection = await BluetoothConnection.toAddress(MACAddress);
                sendString(getTime());
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
          child: Icon(Icons.bluetooth),
        ));
  }
}

class Button extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData icon;
  final String label;

  Button(this.label, this.icon, this.onPressed);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      heroTag: null,
      onPressed: onPressed,
      label: Text(label),
      icon: Icon(icon, color: Colors.white),
      //color: Colors.green,
      //padding: EdgeInsets.all(10),
      // child: Column(
      //   children: [
      //     Icon(icon, color: Colors.white),
      //     Text(label, style: TextStyle(color: Colors.white)),
      //   ],
    );
  }
}
