// ignore_for_file: unused_import, deprecated_member_use

import "package:flutter/material.dart";
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:email_validator/email_validator.dart';
import '../build/social.dart';
import '../screen/constants/constants.dart';
import 'auth.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _isValid = false;
  bool loading = false;
  final email = TextEditingController();
  final password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            Stack(
              children: [
                ClipPath(
                  clipper: MyClipper(),
                  child: Container(
                      height: size.height * 0.3,
                      width: size.width,
                      decoration: BoxDecoration(
                        color: kGreen,
                      )),
                ),
                Positioned(
                  top: size.height * 0.23,
                  right: size.width * 0.1,
                  child: Text("Login",
                      style: GoogleFonts.roboto(
                          fontSize: 30,
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontWeight: FontWeight.w500)),
                ),
                // Positioned(
                //   bottom: 1,
                //   right:20,
                //   child:Image.asset('assets/images/walking.png',height:size.height * 0.26),
                // )
              ],
              // Positioned(
              //   child: ,
              // ),
            ),
            SizedBox(height: size.height * 0.01),
            SvgPicture.asset('assets/images/login.svg',
                height: size.height * 0.2),
            SizedBox(height: size.height * 0.01),
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 1, 30, 0),
              child: TextFormField(
                obscureText: false,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    // icon: Icon(Icons.mail,size:30,color: Colors.black),
                    filled: true,
                    hintStyle: TextStyle(color: Colors.grey[800]),
                    hoverColor: Colors.red,
                    hintText: "Email",
                    prefixIcon: Icon(Icons.mail, color: Colors.blueGrey[900]),
                    fillColor: Colors.grey[200]),
                controller: email,
              ),
            ),
            SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 1, 30, 0),
              child: TextFormField(
                obscureText: true,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    // icon: Icon(Icons.mail,size:30,color: Colors.black),
                    filled: true,
                    hintStyle: TextStyle(color: Colors.grey[800]),
                    hoverColor: Colors.red,
                    hintText: "password",
                    prefixIcon: Icon(Icons.lock, color: Colors.blueGrey[900]),
                    fillColor: Colors.grey[200]),
                controller: password,
              ),
            ),
            SizedBox(height: 10),
            loading
                ? CircularProgressIndicator()
                : Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Card(
                      shadowColor: Colors.green[900],
                      color: Colors.white,
                      // elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: FlatButton(
                          onPressed: () async {
                            setState(() {
                              loading = true;
                            });
                            _isValid = EmailValidator.validate(email.text);
                            if (_isValid) {
                              Fluttertoast.showToast(
                                  msg: "Valid Email",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.TOP,
                                  timeInSecForIosWeb: 1,
                                  fontSize: 16.0);
                            } else if (email.text.isEmpty) {
                              Fluttertoast.showToast(
                                  msg: 'Enter Email',
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.TOP,
                                  timeInSecForIosWeb: 1,
                                  fontSize: 16.0);
                            } else {
                              Fluttertoast.showToast(
                                  msg: 'Enter a Valid Email',
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.TOP,
                                  timeInSecForIosWeb: 1,
                                  fontSize: 16.0);
                            }
                            if (email.text == "") {
                              Fluttertoast.showToast(
                                  msg: 'Email required ',
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.TOP,
                                  timeInSecForIosWeb: 1,
                                  fontSize: 16.0);
                            } else if (password.text == "") {
                              Fluttertoast.showToast(
                                  msg: 'Password required',
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.TOP,
                                  timeInSecForIosWeb: 1,
                                  fontSize: 16.0);
                            } else {
                              var result = await AuthService()
                                  .login(email.text, password.text, context);
                              if (result != null) {
                                Fluttertoast.showToast(
                                  msg: 'Success',
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.TOP,
                                  timeInSecForIosWeb: 1,
                                  fontSize: 16.0);
                                print("success");
                                print(result.email);
                              }
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text("Signed in "),
                                backgroundColor: Colors.blue[900],
                                duration: Duration(milliseconds: 500),
                              ));
                            }
                            setState(() {
                              loading = false;
                            });
                            // setState(() {
                            //   Navigator.of(context).pushReplacement(
                            //       MaterialPageRoute(
                            //           builder: (context) => Accounts()));
                            // });
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          // icon: Icon(
                          //   Icons.create,
                          //   size: 24,
                          //   color: Colors.black,
                          // ),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                            child: Text("Login",
                                style: GoogleFonts.robotoCondensed(
                                    fontSize: 15,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold)),
                          )),
                    ),
                  ),
            Row(children: [
              Expanded(
                // ignore: unnecessary_new
                child: Container(
                    margin: const EdgeInsets.only(left: 10.0, right: 30.0),
                    child: Divider(
                      color: kGreen,
                      height: 90,
                    )),
              ),
              Text("OR"),
              Expanded(
                child: Container(
                    margin: const EdgeInsets.only(left: 30.0, right: 10.0),
                    child: Divider(
                      color: kGreen,
                      height: 50,
                    )),
              ),
            ]),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SocalIcon(
                  iconSrc: "assets/images/facebook.svg",
                  press: () {},
                ),
                SocalIcon(
                  iconSrc: "assets/images/twitter.svg",
                  press: () {},
                ),
                SocalIcon(
                  iconSrc: "assets/images/google.svg",
                  press: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 80);
    var controllPoint = Offset(50, size.height);
    var endPoint = Offset(size.width / 2, size.height);
    path.quadraticBezierTo(
        controllPoint.dx, controllPoint.dy, endPoint.dx, endPoint.dy);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}