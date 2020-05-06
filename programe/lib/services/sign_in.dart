
import 'package:flutter/material.dart';
import 'package:programe/services/auth.dart';
import 'package:programe/shares/constant.dart';
import 'package:programe/shares/loading.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';

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
      backgroundColor: Colors.green[255],

      appBar: AppBar(

backgroundColor: Colors.green,
elevation: 0.0,


actions: <Widget>[
 FlatButton.icon(
   icon: Icon(Icons.person),
   onPressed: () {
      widget.toggleView();
   }, 
   label: Text('Inscrire'),
   ) 
],



      ),
body: Container(

 

  padding: EdgeInsets.symmetric(vertical:20.0,horizontal:50.0),
  child : Form( 
    key: _formKey,
    child: Column(
children: <Widget>[
  SizedBox(
                      height: 255.0,
                      child: Image.asset(
                        "images/logo.png",
                        fit: BoxFit.contain,
                      ),
                    ),
 
 TextFormField(
   decoration: emailField,
    validator: (val) => val.isEmpty ? 'Enter an Email' : null,
   onChanged : (val)
   {
setState(() => email = val);
   }
 ),
SizedBox(height: 20.0),
TextFormField(
 decoration: passwordField,
   validator: (val) => val.length <6 ? 'Enter a password 6+ chars Long ' : null,
  obscureText: true,
onChanged: (val)
{
setState(() => password = val);
},
),
SizedBox(height:50.0),
Material(
 borderRadius: BorderRadius.circular(32.0),
  color:  Colors.orange,
  child : MaterialButton(
child: Text(
    'Connecter',
    
     style: TextStyle(color : Colors.white , fontFamily: 'Montserrat' ,fontWeight: FontWeight.bold) ,
  ),
  minWidth: MediaQuery.of(context).size.width,
            padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
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

  
  
  

 
),
SizedBox(height:50.0),
GoogleSignInButton(
  onPressed: () {/* ... */}, 
  darkMode: true, // default: false
),

FacebookSignInButton(onPressed: () {
  // call authentication logic
})
],
    ), 
  
  ),

  
),
    );
  }
}