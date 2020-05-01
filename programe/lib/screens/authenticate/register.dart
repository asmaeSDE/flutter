import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:programe/services/auth.dart';
import 'package:programe/shares/constant.dart';
import 'package:programe/shares/loading.dart';
class Register extends StatefulWidget {
  final Function toggleView;
  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register>
   {
     final AuthService _auth = AuthService();
     final _formeKey = GlobalKey<FormState>();

      String email ='';
 String password ='';
 String error ='';
  bool loading =false;

  @override
  Widget build(BuildContext context) {
    return loading ?  Loading() : Scaffold(
      backgroundColor: Colors.brown[100],

      appBar: AppBar(

backgroundColor: Colors.brown[400],
elevation: 0.0,
title: Text(
'Sign Up'
),
actions: <Widget>[
 FlatButton.icon(
   icon: Icon(Icons.person),
   onPressed: () {
     widget.toggleView();
   }, 
   label: Text('Sign In'),
   ) 
],

      ),
body: Container(
  padding: EdgeInsets.symmetric(vertical:20.0,horizontal:50.0),
  child : Form(
    key: _formeKey,
    child: Column(
children: <Widget>[
  SizedBox(height : 20.0),
 TextFormField(
   decoration : textfield.copyWith(hintText:'Email'),

  
    validator: (val) => val.isEmpty ? 'Enter an Email' : null,
   onChanged : (val)
   {
setState(() => email = val);
   }
 ),
SizedBox(height: 20.0),
TextFormField(
  decoration : textfield.copyWith(hintText:'password'),
   
 validator: (val) => val.length <6 ? 'Enter a password 6+ chars Long ' : null,
  obscureText: true,
onChanged: (val)
{
setState(() => password = val);
},
),
SizedBox(height:20.0),
RaisedButton(
  
  color:  Colors.pink[400],
  child: Text(
    'Register',
     style: TextStyle(color : Colors.white) ,
  ),
  onPressed: () async {
if(_formeKey.currentState.validate())
{
   setState(() => loading = loading=true);
dynamic result = await _auth.registerWithEmailandPassword(email, password);
if(result == null)
{
setState(()
  {
error ='please supply a valid email';
loading=false;

});
}
}
  },

 
),
SizedBox(height:10.0),
Text(
error,
style:TextStyle( color:Colors.red, fontSize:14.0),
),
],
    ), 
  
  ),

  
),
    );
  }
}