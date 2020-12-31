import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

class BLE extends StatefulWidget {
  @override
  BLEPage createState() => BLEPage();
}

class BLEPage extends State<BLE> {
  FlutterBlue flutterBlue = FlutterBlue.instance;
  final List<BluetoothDevice> devices = new List<BluetoothDevice>();
  void addDevice(final BluetoothDevice device) {
    if (!devices.contains(device)) {
      setState(() {
        devices.add(device);
      });
    }
  }

  void scanDevices() {
    flutterBlue.startScan(timeout: Duration(seconds: 7));

    flutterBlue.scanResults.listen((results) {
      for (ScanResult r in results) {
        addDevice(r.device);
      }
    });

    flutterBlue.scanResults.listen((results) {
      for (ScanResult r in results) {
        addDevice(r.device);
      }
    });

    flutterBlue.stopScan();
  }

  ListView buildListView() {
    scanDevices();
    List<Container> containers = new List<Container>();
    for (BluetoothDevice device in devices) {
      containers.add(Container(
          height: 50,
          child: Row(
            children: <Widget>[
              Expanded(
                  child: Column(
                children: [Text(device.name), Text(device.id.toString())],
              )),
              FlatButton(
                color: Colors.blue,
                child: Text('Connect', style: TextStyle(color: Colors.white)),
                onPressed: () async {
                  await device.connect();
                },
              )
            ],
          )));
    }
    return ListView(
      padding: const EdgeInsets.all(8),
      children: <Widget>[
        ...containers,
      ],
    );
  }

  @override
  Widget build(BuildContext ctxt) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Connect to Glasses"),
      ),
      body: buildListView(),
    );
  }
}
