
import 'package:flutter/material.dart';
import 'package:programe/services/auth.dart';
import 'package:programe/shares/constant.dart';
import 'package:programe/shares/loading.dart';

class SignIn extends StatefulWidget {
   final Function toggleView;
  SignIn({this.toggleView});

 
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
 final AuthService _auth = AuthService();
 final _formKey = GlobalKey<FormState>();
 bool loading =false;

 String email ='';
 String password ='';
 String error='';
  @override
  Widget build(BuildContext context) {
    return  loading ?  Loading() : Scaffold(
      backgroundColor: Colors.brown[100],

      appBar: AppBar(

backgroundColor: Colors.brown[400],
elevation: 0.0,
title: Text(
'Sign In'
),

actions: <Widget>[
 FlatButton.icon(
   icon: Icon(Icons.person),
   onPressed: () {
      widget.toggleView();
   }, 
   label: Text('Register'),
   ) 
],



      ),
body: Container(
  padding: EdgeInsets.symmetric(vertical:20.0,horizontal:50.0),
  child : Form( 
    key: _formKey,
    child: Column(
children: <Widget>[
  SizedBox(height : 20.0),
 TextFormField(
   decoration: textfield.copyWith(hintText:'Email'),
    validator: (val) => val.isEmpty ? 'Enter an Email' : null,
   onChanged : (val)
   {
setState(() => email = val);
   }
 ),
SizedBox(height: 20.0),
TextFormField(
 decoration: textfield.copyWith(hintText:'password'), 
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
    'Sign In',
     style: TextStyle(color : Colors.white) ,
  ),
  onPressed: () async {
if(_formKey.currentState.validate())
{
  setState(() => loading = loading=true);
  dynamic  result =await _auth.SignInWithEmailandPassword(email, password);
if(result == null){
  setState(() { 
    error = 'could note sign in with those credential';
    loading = false;
});
}

}

}

 
),
],
    ), 
  
  ),

  
),
    );
  }
}