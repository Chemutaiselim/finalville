import "package:flutter/material.dart";
import 'package:google_fonts/google_fonts.dart';

class Indicate extends StatelessWidget {
  final String imageUrl;
  
  const Indicate({Key? key, required this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
        height: size.height * 0.2,
        width: size.width * 0.1,
        child: Container(
            height: 30,
            width: 40,
            // width: size.width * 0.26,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                shape: BoxShape.rectangle,
                image: DecorationImage(
                  image: AssetImage(imageUrl),
                  fit: BoxFit.cover,
                ))));
  }
}