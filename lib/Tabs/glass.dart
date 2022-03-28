// ignore_for_file: prefer_const_constructors

import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:flutter/material.dart';
import 'package:finalville/build/build_diagrams_items.dart';


class Glass extends StatefulWidget {
 const Glass({Key? key}) : super(key: key);

  @override
  State<Glass> createState() => _GlassState();
}

class _GlassState extends State<Glass> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ColorfulSafeArea(
        overflowRules: OverflowRules.all(true),
        child: SingleChildScrollView(
          child: Column(
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              DisplayItems(
                func: (){},
                category: "Glass",
                imageUrl: 'assets/images/pastic.jpg',
                location: 'Dedan Kimathi University,Nyeri',
                distance: 200,
              ),
              DisplayItems(
                func: (){},
                category: "Glass",
                imageUrl: 'assets/images/g1.jpg',
                location: 'Chuka University,Chuka',
                distance: 500,
              ),
              DisplayItems(
                func: (){},
                category: "Glass",
                imageUrl: 'assets/images/g2.jpg',
                location: 'Kisii University,Kisii',
                distance: 240,
              ),
              DisplayItems(
                func: (){},
                category: "Glass",
                imageUrl: 'assets/images/p4.jpg',
                location: 'Mt Kenya University,thika',
                distance: 60,
              ),
              DisplayItems(
                func: (){},
                category: "Glass",
                imageUrl: 'assets/images/g1.jpg',
                location: 'University of Nairobi,Nairobi',
                distance: 2000,
              ),
              DisplayItems(
                func: (){},
                category: "Glass",
                imageUrl: 'assets/images/p3.jpg',
                location: 'Multi Media University,Juja',
                distance: 120,
              ),
              DisplayItems(
                func: (){},
                category: "Glass",
                imageUrl: 'assets/images/p2.jpg',
                location: 'Kiriri University,Nakuru',
                distance: 670,
              ),
              DisplayItems(
                func: (){},
                category: "Glass",
                imageUrl: 'assets/images/p1.jpg',
                location: 'Kabarak University,Gilgil',
                distance: 90,
              ),
            ],
          ),
        ),
      ),
    );
  }
}