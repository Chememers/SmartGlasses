import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';

var url = "http://www.mapquestapi.com/directions/v2/route";
var key = "ivvTktSW08yUuYd7TebZLeVB64ufAIZT"; // MapQuest API Key
List maneuvers = ['Start'];

Future<Map<String, dynamic>> getDirs(String from, String to) async {
  var url =
      "http://www.mapquestapi.com/directions/v2/route?key=${key}&from=${from}&to=${to}";
  final response = await http.get(url);
  final Map<String, dynamic> data = json.decode(response.body);
  //print(data['route']['legs'][0]['maneuvers']);
  return data;
}

ListView buildDirs(List<dynamic> dirs) {
  List<Widget> tiles = new List<Widget>();
  for (var entry in dirs) {
    tiles.add(
      ListTile(
        title: Text(entry.toString()),
      ),
    );
  }
  return ListView(
    padding: const EdgeInsets.all(8),
    children: <Widget>[
      ...tiles,
    ],
  );
}

class MapView extends StatefulWidget {
  @override
  _MapViewState createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Navigate"),
        centerTitle: true,
        backgroundColor: Colors.purple[900],
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Form(
          child: Column(
            //crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Where do you want to go?',
                ),
                controller: controller,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: FloatingActionButton.extended(
                    onPressed: () async {
                      setState(() async {
                        Position currLoc = await Geolocator.getCurrentPosition(
                            desiredAccuracy: LocationAccuracy.high);
                        String from =
                            "${currLoc.latitude},${currLoc.longitude}";
                        String to = controller.text;
                        maneuvers = (await getDirs(from, to))['route']['legs']
                            [0]['maneuvers'];
                      });
                    },
                    label: Text('GO'),
                    icon: Icon(Icons.send)),
              ),
              Container(height: 400, child: Directions())
            ],
          ),
        ),
      ),
    );
  }
}

class Directions extends StatefulWidget {
  @override
  DirectionState createState() => DirectionState();
}

class DirectionState extends State<Directions> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView.builder(
      itemCount: maneuvers.length,
      itemBuilder: (context, index) {
        String narration = maneuvers[index]['narrative'].toString();
        String dist = maneuvers[index]['distance'].toString() + " mi";
        return ListTile(
          title: Text(narration),
          subtitle: Text(dist),
        );
      },
    ));
  }
}
