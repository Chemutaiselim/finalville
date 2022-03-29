// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:finalville/accounts/overview.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

import 'constants/constants.dart';


class Introduction extends StatefulWidget {
  const Introduction({Key? key}) : super(key: key);

  @override
  State<Introduction> createState() => _IntroductionState();
}

class _IntroductionState extends State<Introduction> {
  @override
 Widget build(BuildContext context) {

    //this is a page decoration for intro screen
    PageDecoration pageDecoration = PageDecoration(
          titleTextStyle: TextStyle(fontSize: 32.0,
                    fontWeight: FontWeight.w700,
                    color:kGreen
                  ), //tile font size, weight and color
          bodyTextStyle:TextStyle(fontSize: 19.0, color:kGreen),
          //body text size and color
          contentMargin: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
          //decription padding
          imagePadding: EdgeInsets.all(20), //image padding
          boxDecoration:BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  stops: [0.1, 0.5, 0.7, 0.9],
                  colors: [
                    Color.fromARGB(255, 248, 248, 248),
                    Color.fromARGB(255, 255, 255, 255),
                    Color.fromARGB(255, 255, 255, 255),
                    Color.fromARGB(255, 255, 255, 255),
                  ],
            ),
          ), //show linear gradient background of page  
    );

    return IntroductionScreen(
          globalBackgroundColor: kGreen,
          //main background of screen
          pages: [ //set your page view here
            PageViewModel(
              title: "Dispose",
              body: "We help you dispose the trash",
              image: introImage('assets/images/support.png'),
              decoration: pageDecoration,
            ),
            PageViewModel(
              title: "Collect",
              body: "We provide a platform for us to collect the waste.",
              image: introImage('assets/images/man.png'),
              decoration: pageDecoration,
            ),
            PageViewModel(
              title: "Recycle",
              body: "We protect the environment though recycling the trash and maintaining a cleaner world.",
              image: introImage('assets/images/lady.png'),
              decoration: pageDecoration,
            ),

            //add more screen here
          ],

          onDone: () => goHomepage(context), //go to home page on done
          onSkip: () => goHomepage(context), // You can override on skip           showSkipButton: true,
          dotsFlex: 3,
          nextFlex: 0,
          skip: Text('Skip', style: TextStyle(color: Colors.white),),
          next: Icon(Icons.arrow_forward, color: Colors.white,size:30),
          done: Text('Getting Stated', style: TextStyle(
               fontWeight: FontWeight.w800,fontSize: 18, color:Colors.white
              ),),
          dotsDecorator: const DotsDecorator(
            size: Size(10.0, 10.0), //size of dots
            color: Colors.white, //color of dots
            activeSize: Size(22.0, 10.0),
            //activeColor: Colors.white, //color of active dot
            activeShape: RoundedRectangleBorder( //shave of active dot
              borderRadius: BorderRadius.all(Radius.circular(25.0)),
            ),
          ),
        );
  }

  void goHomepage(context){
     Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context){ 
           return Overview();
        }
    ), (Route<dynamic> route) => false);
    //Navigate to home page and remove the intro screen history
    //so that "Back" button wont work.
  }

  Widget introImage(String assetName) {
  //widget to show intro image
    return Align(
      child: Image.asset('$assetName', width: 350.0),
      alignment: Alignment.bottomCenter,
    );
  }
}