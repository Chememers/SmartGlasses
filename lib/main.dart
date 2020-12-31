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
  final List<BluetoothDevice> devices = new List<BluetoothDevice>();
  addDevice(final BluetoothDevice device) {
    if (!devices.contains(device)) {
      setState(() {
        devices.add(device);
      });
    }
  }

  void scanDevices() {
    FlutterBlue flutterBlue = FlutterBlue.instance;
    flutterBlue.startScan(timeout: Duration(seconds: 4));

    var subscription = flutterBlue.scanResults.listen((results) {
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
              Column(children: [Text(device.name), Text(device.id.toString())],),
              FlatButton(
                color: Colors.blue,
                child: Text('Connect', style: TextStyle(color: Colors.white)),
                onPressed: () {},
              )
            ],
          )));
    }
    return ListView(
      children: <Widget>[
        ...containers,
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Smart Glasses"),
      ),
      body: buildListView(),
    );
  }
}
