// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

// class GoogleMap extends StatefulWidget {
//   @override
//   _GoogleMapState createState() => _GoogleMapState();
// }

// class _GoogleMapState extends State<GoogleMap> {
//   Completer<GoogleMapController> _controllergooglemap = Completer();
//   GoogleMapController newGoogleMapcontroller;
//   GlobalKey<ScaffoldState> scaffolkey = new GlobalKey<ScaffoldState>();
//   Position currentlocation;
//   var geoLocator = Geolocator();
//   void locatePostion() async {
//     Position position = await Geolocator.getCurrentPosition(
//         desiredAccuracy: LocationAccuracy.high);
//     currentlocation = position;
//     LatLng latLatPosition = LatLng(position.latitude, position.longitude);
//     CameraPosition cameraPosition =
//         new CameraPosition(target: latLatPosition, zoom: 14);
//     newGoogleMapcontroller
//         .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: Text("Map"),
//         ),
//         body: Stack(
//           fit: StackFit.expand,
//           children: [
//             GoogleMap(
//                 initialCameraPosition: CameraPosition(
//                     target: LatLng(-33.870840, 151.206286), zoom: 12))
//           ],
//         ));
//   }
// }
