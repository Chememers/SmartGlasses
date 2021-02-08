import 'package:flutter/material.dart';
import 'package:latlong/latlong.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocation/geolocation.dart';

double dLat = 0.0;
double dLong = 0.0;
bool locGet = false;

class GuiMap extends StatefulWidget {
  @override
  _GuiMapState createState() => _GuiMapState();
}

class _GuiMapState extends State<GuiMap> {
  // @override
  // StreamSubscription<LocationResult> subscription = Geolocation.locationUpdates(
  //   accuracy: LocationAccuracy.best,
  //   displacementFilter: 10.0, // in meters
  //   inBackground: true, // by default, location updates will pause when app is inactive (in background). Set to `true` to continue updates in background.
  // )
  // .listen((result) {
  //   if(result.isSuccessful) {
  //     // todo with result
  //   }
  // });
  Widget build(BuildContext context) {
    //Position currLoc = Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    MapController controller = new MapController();

    getPermission() async {
      final GeolocationResult result =
          await Geolocation.requestLocationPermission(
        permission: const LocationPermission(
          android: LocationPermissionAndroid.fine,
          ios: LocationPermissionIOS.always,
        ),
        openSettingsIfDenied: true,
      );
      return result;
    }

    getLocation() {
      return getPermission().then((result) async {
        if (result.isSuccessful) {
          final coords = await Geolocation.currentLocation(
              accuracy: LocationAccuracy.best);
          return coords;
        }
      });
    }

    buildMap() {
      getLocation().then((response) {
        response.listen((value) {
          if (value.isSuccessful) {
            controller.move(
                new LatLng(value.location.latitude, value.location.longitude),
                8.0);
          }
        });
      });
    }

    getLoc() {
      getLocation().then((response) {
        response.listen((value) {
          if (value.isSuccessful) {
            setState(() async {
              LocationResult currLoc = await Geolocation.lastKnownLocation();
              //await Geolocation.currentLocation(accuracy: LocationAccuracy.best);
              // String sdLat = "${currLoc.location.latitude}";
              // String sdLong = "${currLoc.location.longitude}";
              dLat = double.parse("${currLoc.location.latitude}");
              dLong = double.parse("${currLoc.location.longitude}");
            });
          }
        });
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: new Text('Map'),
        centerTitle: true,
      ),
      body: new FlutterMap(
        mapController: controller,
        options: new MapOptions(
          center: buildMap(),
          //new LatLng(40.71, -74),
          zoom: 100.0,
        ),
        layers: [
          new TileLayerOptions(
              urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
              subdomains: ['a', 'b', 'c']),
          new MarkerLayerOptions(markers: [
            new Marker(
                width: 45.0,
                height: 45.0,
                point: new LatLng(dLat, dLong),
                builder: (context) => new Container(
                      child: IconButton(
                        icon: Icon(Icons.location_on),
                        color: Colors.red,
                        iconSize: 45.0,
                        onPressed: () {
                          getLoc();
                        },
                      ),
                    ))
          ])
        ],
      ),
    );
  }
}
