// ignore_for_file: prefer_const_constructors, avoid_print

import 'dart:io';
import 'dart:async';
import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:finalville/screen/constants/constants.dart';
import 'package:firebase_database/firebase_database.dart';
import "package:flutter/material.dart";
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location_permissions/location_permissions.dart';
// import 'package:finalville/Screens/items.dart';
import 'package:finalville/build/build_icon.dart';
import 'package:geolocator/geolocator.dart' hide ServiceStatus;
import 'package:image_picker/image_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';

class User {
  double? longitude;
  double? latitude;
  User({required this.longitude, required this.latitude});
}

class Post extends StatefulWidget {
  Post({Key? key}) : super(key: key);

  @override
  State<Post> createState() => _PostState();
}

class _PostState extends State<Post> {
  final database = FirebaseDatabase.instance.ref();
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

  List<String> items = [
    'Plastic',
    'Metal',
    'Glass',
    'Organic',
  ];
  String? selectedType;
  File? image;
  ImagePicker picker = ImagePicker();

  void takePhoto(ImageSource source) async {
    final image = await picker.pickImage(source: source);
    try {
      if (image == null) return;

      final imageTempo = File(image.path);
      setState(() {
        this.image = imageTempo;
      });
    } on PlatformException catch (e) {
      print("Failed to pick image $e");
    }
  }

  final title = TextEditingController();
  final description = TextEditingController();
  final location = TextEditingController();
  final type = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final post = database.child('post');
    final size = MediaQuery.of(context).size;
    return Scaffold(
        // backgroundColor: Color.fromARGB(255, 245, 96, 10),
        body: ColorfulSafeArea(
      overflowRules: OverflowRules.all(true),
      child: SingleChildScrollView(
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 10, left: 15, top: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text("Title",
                    style: GoogleFonts.robotoCondensed(
                        fontSize: 23,
                        color: kGreen,
                        fontWeight: FontWeight.w600)),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: TextFormField(
              maxLength: 15,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  // icon: Icon(Icons.person,size:30,color: Colors.black),
                  filled: true,
                  hintStyle: TextStyle(color: Colors.grey[800]),
                  focusColor: Colors.red,
                  hintText: "Summary of the waste",
                  // suffixText: "10",
                  // prefixIcon: Icon(Icons.mail,color: Colors.blueGrey[900]),
                  fillColor: Colors.grey[200]),
              controller: title,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10, left: 15, top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text("Description",
                    style: GoogleFonts.robotoCondensed(
                        fontSize: 23,
                        color: kGreen,
                        fontWeight: FontWeight.w600)),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: TextFormField(
              minLines: 2,
              maxLines: 10,
              keyboardType: TextInputType.multiline,
              // style: TextStyle(height:10),
              maxLength: 360,
              decoration: InputDecoration(
                  // contentPadding: const EdgeInsets.symmetric(vertical: 40.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  // icon: Icon(Icons.person,size:30,color: Colors.black),
                  filled: true,
                  hintStyle: TextStyle(color: Colors.grey[800]),
                  focusColor: Colors.red,
                  hintText: "Summary of the waste",
                  // suffixText: "10",
                  // prefixIcon: Icon(Icons.mail,color: Colors.blueGrey[900]),
                  fillColor: Colors.grey[200]),
              controller: description,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10, left: 15, top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text("Type of Waste",
                    style: GoogleFonts.robotoCondensed(
                        fontSize: 23,
                        color: kGreen,
                        fontWeight: FontWeight.w600)),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
            child: DropdownButton2(
              hint: Text("Choose waste"),
              value: selectedType,
              onChanged: (value) {
                setState(() {
                  selectedType = value as String;
                  print(selectedType);
                });
              },
              icon: const Icon(
                Icons.arrow_forward_ios_outlined,
              ),
              iconSize: 18,
              iconEnabledColor: kGreen,
              iconDisabledColor: Color.fromARGB(255, 255, 255, 255),
              buttonHeight: size.height * 0.07,
              buttonWidth: size.width,
              items: items
                  .map((item) => DropdownMenuItem<String>(
                        value: item,
                        child: Text(
                          item,
                          style: GoogleFonts.notoSerif(
                              fontSize: 18,
                              color: kGreen,
                              fontWeight: FontWeight.w600),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ))
                  .toList(),
              buttonPadding: const EdgeInsets.only(left: 14, right: 14),
              buttonDecoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  width: 1,
                  color: Color.fromARGB(255, 87, 86, 86),
                ),
                color: Color.fromARGB(255, 238, 237, 237),
              ),
              buttonElevation: 5,
              itemHeight: 40,
              itemPadding: const EdgeInsets.only(left: 14, right: 14),
              dropdownMaxHeight: 200,
              dropdownWidth: 200,
              dropdownPadding: EdgeInsets.only(top: 3),
              dropdownDecoration: BoxDecoration(
                color: Color.fromARGB(255, 238, 235, 235),
              ),
              dropdownElevation: 5,
              scrollbarRadius: const Radius.circular(20),
              scrollbarThickness: 10,
              scrollbarAlwaysShow: true,
              //  offset: const Offset(18, -50),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10, left: 15, top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text("Location",
                    style: GoogleFonts.robotoCondensed(
                        fontSize: 23,
                        color: kGreen,
                        fontWeight: FontWeight.w600)),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: GestureDetector(
              onTap: getLocation,
              child: TextFormField(
                maxLength: 15,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    // icon: Icon(Icons.person,size:30,color: Colors.black),
                    filled: true,
                    hintStyle: TextStyle(color: Colors.grey[800]),
                    focusColor: Colors.red,
                    hintText: "Enter Location",
                    // suffixText: "10",
                    // prefixIcon: Icon(Icons.mail,color: Colors.blueGrey[900]),
                    fillColor: Colors.grey[200]),
                controller: location,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10, left: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text("Images",
                    style: GoogleFonts.robotoCondensed(
                        fontSize: 23,
                        color: kGreen,
                        fontWeight: FontWeight.w600)),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 8),
            child: Stack(
              children: [
                Material(
                  color: Color.fromARGB(255, 247, 247, 247),
                  elevation: 20,
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    //  color: Colors.grey,
                    // color: Color.fromARGB(255, 36, 47, 53),
                    child: Center(
                      child: image != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.file(
                                image!,
                                width: size.width,
                                height: size.height * 0.2,
                                fit: BoxFit.cover,
                              ),
                            )
                          : Text("Select Image",
                              style: GoogleFonts.roboto(color: Colors.white)),
                    ),
                    height: size.height * 0.2,
                    width: size.width,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 255, 255, 255),
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromARGB(255, 163, 165, 165)
                              .withOpacity(0.6),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    // image: image
                  ),
                ),
                Positioned(
                    top: 5,
                    right: 5,
                    child: IconButton(
                        onPressed: () {
                          // takePhoto(ImageSource.camera);
                          setState(() {
                            showDialog<String>(
                              context: context,
                              builder: (BuildContext context) => Container(
                                width: size.width,
                                height: size.height * 0.2,
                                decoration: BoxDecoration(
                                  //border: Border.all(color: Color.fromARGB(255, 182, 36, 116),width:1 ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: AlertDialog(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  contentPadding: EdgeInsets.all(5),
                                  title: const Text('choose image from: '),
                                  content: SingleChildScrollView(
                                    child: ListBody(children: [
                                      ListTile(
                                        selectedColor: Colors.grey,
                                        onTap: () {
                                          takePhoto(ImageSource.camera);
                                          Navigator.pop(context);
                                        },
                                        leading: Icon(Icons.camera,
                                            color: Colors.blueGrey[900]),
                                        title: Text("Camera"),
                                      ),
                                      ListTile(
                                        selectedColor: Colors.grey,
                                        onTap: () {
                                          setState(() {
                                            takePhoto(ImageSource.gallery);
                                            Navigator.pop(context);
                                          });
                                        },
                                        leading: Icon(Icons.layers,
                                            color: Colors.blueGrey[900]),
                                        title: GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                takePhoto(ImageSource.gallery);
                                                Navigator.pop(context);
                                              });
                                            },
                                            child: Text("Gallery")),
                                      ),
                                    ]),
                                  ),
                                ),
                              ),
                            );
                          });
                        },
                        icon: Icon(Icons.add_a_photo,
                            size: 30,
                            color:
                                image != null ? Colors.white : Colors.black)))
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(size.width * 0.4, size.height * 0.04),
                  primary: kGreen,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ), // Background color
                ),
                onPressed: () async {
                  final order = <String, dynamic>{
                    'description': description.text,
                    'title': title.text,
                    'location': location.text,
                    'type': selectedType,
                    'image': image?.path,

                  };
                  database.child('post').push().set(order).then((_) => print("data has been written")).catchError((e)=>print(e));
                  // setState(() {
                  //   Navigator.of(context).pushReplacement(
                  //       MaterialPageRoute(builder: ((context) => Items())));
                  // });
                },
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                  child: Text("Post",
                      style: GoogleFonts.robotoCondensed(
                          fontSize: 23,
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontWeight: FontWeight.bold)),
                )),
          )
        ]),
      ),
    ));
  }
}