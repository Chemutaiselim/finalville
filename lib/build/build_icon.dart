import "package:flutter/material.dart";
import 'package:finalville/build/build_container.dart';

class AppIcon extends StatelessWidget {
  final String iconUrl;
  final Function() func;
  const AppIcon({Key? key, required this.iconUrl, required this.func}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BuildContainer(
          child: GestureDetector(
            onTap: func,
            child: Image.asset(iconUrl),
          ),
        ),
      ],
    );
  }
}