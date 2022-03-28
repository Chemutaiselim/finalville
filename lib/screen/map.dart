import "package:flutter/material.dart";


class MapLocation extends StatefulWidget {
  const MapLocation({Key? key}) : super(key: key);

  @override
  State<MapLocation> createState() => _MapLocationState();
}

class _MapLocationState extends State<MapLocation> {
  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return Scaffold(
      body: const Center(
        child: Text("Map"),
      )
    );
  }
}