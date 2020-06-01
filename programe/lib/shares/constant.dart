import 'package:flutter/material.dart';
bool isCollapsed = true;
  double screenWidth, screenHeight;
  final Duration duration = const Duration(milliseconds: 300);
  AnimationController _controller;
  Animation<double> _scaleAnimation;
  Animation<double> _menuScaleAnimation;
  Animation<Offset> _slideAnimation;
final Color backgroundColor = Color(0xFF4A4A58);


 

final emailField =
           InputDecoration(
             
              contentPadding: EdgeInsets.fromLTRB(10.0, 10.0, 20.0,15.0),
              hintText: "Email",
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)));
    
final Nom =
           InputDecoration(
             
              contentPadding: EdgeInsets.fromLTRB(10.0, 10.0, 20.0, 15.0),
              hintText: "Nom",
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)));


         final passwordField = InputDecoration(
              contentPadding: EdgeInsets.fromLTRB(10.0, 15.0, 20.0, 15.0),
              hintText: "mot de passe",
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)));

final ConfirmpasswordField = InputDecoration(
              contentPadding: EdgeInsets.fromLTRB(10.0, 15.0, 20.0, 15.0),
              hintText: "Confirmer mot de passe",
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)));
                  
final Prenom =
           InputDecoration(
             
              contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
              hintText: "Prenom",
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)));
                  

                 
final CIN =
           InputDecoration(
             
              contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
              hintText: "CIN",
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)));

  String validateName(String value) {
    String patttern = r'(^[a-zA-Z ]*$)';
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return "Name is Required";
    } else if (!regExp.hasMatch(value)) {
      return "Name must be a-z and A-Z";
    }
    return null;
  }

  String validateEmail(String value) {
    String pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(pattern);
    if (value.length == 0) {
      return "Email is Required";
    } else if(!regExp.hasMatch(value)){
      return "Invalid Email";
    }else {
      return null;
    }
  }

  Widget _signInButton() {
    return OutlineButton(
      splashColor: Colors.grey,
      onPressed: () {},
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      highlightElevation: 0,
      borderSide: BorderSide(color: Colors.grey),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(image: AssetImage("assets/google_logo.png"), height: 35.0),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                'Sign in with Google',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  