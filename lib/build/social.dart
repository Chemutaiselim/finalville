import 'package:flutter/material.dart';
// import 'package:flutter_auth/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../screen/constants/constants.dart';

class SocalIcon extends StatelessWidget {
  final String iconSrc;
  final Function() press;
  SocalIcon({Key? key, required this.iconSrc, required this.press}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color: kGreen,
          ),
          shape: BoxShape.circle,
        ),
        child: SvgPicture.asset(
          iconSrc,
          height: 30,
          width: 30,
        ),
      ),
    );
  }
}