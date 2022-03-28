// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors, prefer_collection_literals, unused_local_variable

import 'dart:convert';
import 'dart:io';
import 'dart:async';
// import 'package:animated_text_kit/animated_text_kit.dart';
// import 'package:dropdown_button2/dropdown_button2.dart';
// import 'package:finalspace/build/build_appBar.dart';
// import 'package:finalspace/build/lottie_contain.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import "package:flutter/material.dart";
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart' hide ServiceStatus;
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:lottie/lottie.dart';
// import 'package:permission_handler/permission_handler.dart';
import 'package:location_permissions/location_permissions.dart';
import 'package:colorful_safe_area/colorful_safe_area.dart';


class Mapp extends StatefulWidget {
  Mapp({Key? key}) : super(key: key);

  @override
  State<Mapp> createState() => _MappState();
}

class _MappState extends State<Mapp> {
  final search = TextEditingController();
  Set<Marker> markers = {};
  GoogleMapController? newGoogleMapController;
  double? latitude;
  double? longitude;
  // LatLng ltPosition = LatLng(latitude!, longitude!);
  getPermission() async {
    PermissionStatus permission =
        await LocationPermissions().requestPermissions();
    ServiceStatus serviceStatus =
        await LocationPermissions().checkServiceStatus();
    // bool isOpened = await LocationPermissions().openAppSettings();
    bool isShown =
        await LocationPermissions().shouldShowRequestPermissionRationale();
    var locate = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.best,
    );
    // print(locate.longitude);
    latitude = locate.latitude;
    longitude = locate.longitude;
  }
  // void _updatePosition(CameraPosition _position) {
  //   Position newMarkerPosition = Position(
  //       accuracy: Accuracy.high,
  //       latitude: _position.target.latitude,
  //       longitude: _position.target.longitude);
  //   Marker marker = markers["1"];

  //   setState(() {
  //     markers["1"] = marker.copyWith(
  //         positionParam: LatLng(newMarkerPosition.latitude, newMarkerPosition.longitude));
  //   });
  // }

  getLocation() {
    getPermission().then((locate) {
      print(longitude);
      print(latitude);
      LatLng ltPosition = LatLng(latitude!, longitude!);
      CameraPosition cameraPosition =
          CameraPosition(target: ltPosition, zoom: 10);
      // ignore: unused_local_variable
      newGoogleMapController
          ?.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
    });
  }

  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: Color.fromARGB(255, 0, 0, 0),
      body: ColorfulSafeArea(
          // maintainBottomViewPadding: true,
          // top:true,
          overflowRules: OverflowRules.all(true),
          child: Stack(
            children: [
              GoogleMap(
                gestureRecognizers: Set()
                  ..add(Factory<PanGestureRecognizer>(() => PanGestureRecognizer()))
                  ..add(
                      Factory<ScaleGestureRecognizer>(() => ScaleGestureRecognizer()))
                  ..add(Factory<TapGestureRecognizer>(() => TapGestureRecognizer()))
                  ..add(Factory<VerticalDragGestureRecognizer>(
                      () => VerticalDragGestureRecognizer())),
                mapType: MapType.hybrid,
                myLocationEnabled: true,
                zoomControlsEnabled: false,
                zoomGesturesEnabled: true,
                initialCameraPosition: _kGooglePlex,
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                  getLocation();
                },

                markers: Set<Marker>.of(
                  <Marker>[
                    Marker(
                      draggable: true,
                      markerId: MarkerId("1"),
                      position: LatLng(37.42796133580664, -122.085749655962),
                      icon: BitmapDescriptor.defaultMarker,
                      infoWindow: const InfoWindow(
                        title: 'location marker',
                      ),
                    )
                  ],
                ),
              ),
            ],
          )),
    );
  }
}