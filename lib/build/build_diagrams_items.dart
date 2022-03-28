// ignore_for_file: prefer_const_constructors
import 'package:finalville/screen/constants/constants.dart';
import "package:flutter/material.dart";
import 'package:google_fonts/google_fonts.dart';
import 'package:finalville/build/build_icon.dart';


class DisplayItems extends StatelessWidget {
  final String imageUrl;
  final String location;
  final String category;
  final int distance;
  final Function() func;
  const DisplayItems(
      {Key? key,
      required this.imageUrl,
      required this.category,
      required this.location,
      required this.distance, 
      required this.func})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Material(
        elevation: 10,
        borderRadius: BorderRadius.circular(20),
        child: Container(
            height: size.height * 0.29,
            width: size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Stack(
                // alignment: Alignment.s,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                          height: size.height * 0.17,
                          width: size.width,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20)),
                              shape: BoxShape.rectangle,
                              image: DecorationImage(
                                image: AssetImage(imageUrl),
                                fit: BoxFit.cover,
                              ))),
                      Padding(
                        padding: const EdgeInsets.only(left: 10, top: 8),
                        child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(height:5),
                              Text(category,
                                  style: GoogleFonts.roboto(
                                      fontSize:  MediaQuery.of(context).size.width * 0.05,
                                      color: Color.fromARGB(255, 7, 6, 12),
                                      fontWeight: FontWeight.w500)),
                              const SizedBox(height: 5),
                              Text(location,
                                  style: GoogleFonts.roboto(
                                      fontSize:  MediaQuery.of(context).size.width * 0.05,
                                      color: kGreen,
                                      fontWeight: FontWeight.w500)),
                              const SizedBox(height: 5),
                              Text('$distance km',
                                  style: GoogleFonts.roboto(
                                      fontSize: 15, color: Colors.grey)),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  // Positioned(
                  //   top: 5,
                  //   right: 5,
                  //   child: AppIcon(
                  //     iconUrl: "assets/images/mail.png",
                  //     func: (){},)),
                  Positioned(
                      bottom: 10,
                      right: 5,
                      child: AppIcon(
                        iconUrl: "assets/images/add.png",
                        func: func,
                      ))
                ],
              ),
            )),
      ),
    );
  }
}