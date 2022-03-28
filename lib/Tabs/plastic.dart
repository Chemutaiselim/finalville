// ignore_for_file: prefer_const_constructors

import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:finalville/Stream/stream_data.dart';
import 'package:finalville/screen/post.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'package:finalville/build/build_diagrams_items.dart';

import '../build/build_diagrams_items.dart';
import '../firebase/post_model.dart';

class Plastic extends StatefulWidget {
  const Plastic({Key? key}) : super(key: key);

  @override
  State<Plastic> createState() => _PlasticState();
}

class _PlasticState extends State<Plastic> {
  final database = FirebaseDatabase.instance.ref().child('post');
  void read(){
    
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ColorfulSafeArea(
        overflowRules: OverflowRules.all(true),
        child: SingleChildScrollView(
          child: Column(
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              // StreamBuilder(
              //     stream: DataStream().getPostStream(),
              //     builder: (context, snapshot) {
              //       final datalist = <DisplayItems>[];
              //       if (snapshot.hasData) {
              //         final myOrders = Map<String, dynamic>.from(
              //             (snapshot.data as Map<String, dynamic>));
              //         myOrders.forEach((key, value) {
              //           final nextOrder = Map<String, dynamic>.from(value);
              //           final order = DisplayItems(
              //               imageUrl: "assets/images/m1.jpg",
              //               category: nextOrder['category'],
              //               location: nextOrder['location'],
              //               distance: 200,
              //               func: () {});
              //           datalist.add(order);
              //         });
              //         print("Emilio");

              //       }
              //       return ListView(
              //             children: datalist,

              //         );

              //     }),
              // FirebaseAnimatedList(
              //     query: database,
              //     itemBuilder: (BuildContext context, DataSnapshot snapshot,
              //         Animation<double> animation, int index) {
              //           List<String> listStaff =
              //               snapshot.data.value.toString().split(",");
              //       return ListTile(
              //         leading: CircleAvatar(
              //           backgroundImage:
              //               NetworkImage(snapshot.value['imageUrl']),
              //         ),
              //         title:snapshot.value['category'],
              //         subtitle: Text(snapshot.value['location']),
              //         trailing: Text(snapshot.value['distance'].toString()),
              //       );
              //     }),

              DisplayItems(
                func: () {},
                category: "plastics",
                imageUrl: 'assets/images/p2.jpg',
                location: 'Chuka University,Chuka',
                distance: 500,
              ),
              // DisplayItems(
              //   func: () {},
              //   category: "plastics",
              //   imageUrl: 'assets/images/p3.jpg',
              //   location: 'Kisii University,Kisii',
              //   distance: 240,
              // ),
              // DisplayItems(
              //   func: () {},
              //   category: "plastics",
              //   imageUrl: 'assets/images/p4.jpg',
              //   location: 'Mt Kenya University,thika',
              //   distance: 60,
              // ),
              // DisplayItems(
              //   func: () {},
              //   category: "plastics",
              //   imageUrl: 'assets/images/p5.jpg',
              //   location: 'University of Nairobi,Nairobi',
              //   distance: 2000,
              // ),
              // DisplayItems(
              //   func: () {},
              //   category: "plastics",
              //   imageUrl: 'assets/images/p3.jpg',
              //   location: 'Multi Media University,Juja',
              //   distance: 120,
              // ),
              // DisplayItems(
              //   func: () {},
              //   category: "plastics",
              //   imageUrl: 'assets/images/p2.jpg',
              //   location: 'Kiriri University,Nakuru',
              //   distance: 670,
              // ),
              // DisplayItems(
              //   func: () {},
              //   category: "plastics",
              //   imageUrl: 'assets/images/p1.jpg',
              //   location: 'Kabarak University,Gilgil',
              //   distance: 90,
              //),
            ],
          ),
        ),
      ),
    );
  }
}
