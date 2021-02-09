import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:async';

class Gmapp extends StatefulWidget {
  @override
  _GmappState createState() => _GmappState();
}

class _GmappState extends State<Gmapp> {
  Set<Marker> _marker = {};
  double bottampaddingofMap = 0;
  Completer<GoogleMapController> _controllergooglemap = Completer();
  GoogleMapController newGoogleMapcontroller;
  GlobalKey<ScaffoldState> scaffolkey = new GlobalKey<ScaffoldState>();
  Position currentlocation;
  var geoLocator = Geolocator();
  LatLng latLatPosition;
  void locatePostion() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    currentlocation = position;
    latLatPosition = LatLng(position.latitude, position.longitude);
    CameraPosition cameraPosition =
        new CameraPosition(target: latLatPosition, zoom: 14);
    newGoogleMapcontroller
        .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
    // print(latLatPosition);
  }

  static final CameraPosition _kGoogleplex =
      CameraPosition(target: LatLng(19.3064218, 72.9371035), zoom: 12);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Google Map"),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          GoogleMap(
            padding: EdgeInsets.only(bottom: bottampaddingofMap),
            mapType: MapType.normal,
            myLocationButtonEnabled: true,
            initialCameraPosition: _kGoogleplex,
            myLocationEnabled: true,
            zoomControlsEnabled: true,
            zoomGesturesEnabled: true,
            markers: _marker,
            onMapCreated: (GoogleMapController controller) {
              _controllergooglemap.complete(controller);
              newGoogleMapcontroller = controller;
              locatePostion();
              setState(() {
                print(latLatPosition);
                bottampaddingofMap = 300;
                _marker.add(Marker(
                  markerId: MarkerId('id-1'),
                  position: LatLng(19.3064218, 72.9371035),
                  infoWindow:
                      InfoWindow(title: 'Jai mata di', snippet: 'temple'),
                ));
                _marker.add(Marker(
                  markerId: MarkerId('id-2'),
                  position: LatLng(19.3719936, 72.8754067),
                  infoWindow:
                      InfoWindow(title: 'Jai mata di', snippet: 'temple'),
                ));
              });
            },
          )
        ],
      ),
    );
  }
}
