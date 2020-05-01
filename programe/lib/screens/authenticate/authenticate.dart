import 'package:flutter/material.dart';
import 'package:programe/screens/authenticate/register.dart';
import 'package:programe/services/sign_in.dart';



class authenticate extends StatefulWidget {
  @override
  _authenticateState createState() => _authenticateState();
}

class _authenticateState extends State<authenticate>
    
    {
      bool showSignIn = true;

      void toggleView()
      {
        setState(() => showSignIn = !showSignIn);
      }
  @override
  Widget build(BuildContext context) {
    if(showSignIn)
    {
      return SignIn(toggleView: toggleView);
    }else 
    {
return Register(toggleView: toggleView);
    }
    
    
  }
}