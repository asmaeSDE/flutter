
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:programe/models/user.dart';
import 'package:programe/screens/forgotPassword.dart';
import 'package:programe/screens/home/home.dart';
import 'package:programe/services/auth.dart';
import 'package:programe/services/signInmethod.dart';
import 'package:programe/shares/constant.dart';
import 'package:programe/shares/loading.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:progress_dialog/progress_dialog.dart';

class ForgotPassword extends StatefulWidget {
   final Function toggleView;
  ForgotPassword({this.toggleView});

 
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {

 final AuthService _auth = AuthService();
final _authe = FirebaseAuth.instance;
FirebaseUser loggedInUser;
 final _formKey = GlobalKey<FormState>();


void initState() 
{
  getCurrentUser();
  super.initState();
}


 void getCurrentUser() async{
  try{
    final user = await _authe.currentUser() ;
    if(user!=null)
    {
      loggedInUser =user;
      print(loggedInUser.email);
    }
  }catch(e)
  {
    print(e);
  }
}
  
 bool loading =false;
 String email ='';
 String password ='';
 String error='';
ProgressDialog pr;
AuthService auth = AuthService();
  @override
  Widget build(BuildContext context) {
 pr = new ProgressDialog(context);
    pr = new ProgressDialog(context,type: ProgressDialogType.Normal, isDismissible: true, showLogs: true);
pr.style(

  borderRadius: 10.0,
  backgroundColor: Colors.white,
  progressWidget: CircularProgressIndicator(),
  elevation: 10.0,
  insetAnimCurve: Curves.easeInOut,
  progress: 0.0,
  maxProgress: 100.0,
  progressTextStyle: TextStyle(
     color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w400),
  messageTextStyle: TextStyle(
     color: Colors.black, fontSize: 19.0, fontWeight: FontWeight.w600)
  );
    return  Scaffold(
      resizeToAvoidBottomPadding: false ,
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

 

  padding: EdgeInsets.symmetric(vertical:10.0,horizontal:50.0),
  child : Form( 
    key: _formKey,
    child: Column(
children: <Widget>[
  SizedBox(
                      height: 255.0,
                      child: Image.asset(
                        "images/lock.png",
                        fit: BoxFit.contain,
                      ),
                    ),
 SizedBox(height:50.0),
 TextFormField(
   decoration: emailField,
    validator: (val) => val.isEmpty ? 'Enter an Email' : null,
   onChanged : (val)
   {
setState(() => email = val.trim());
   }
 ),


SizedBox(height:50.0),
Material(
 borderRadius: BorderRadius.circular(32.0),
  color:  Colors.orange,
  child : MaterialButton(
child: Text(
    'Reset',
    
     style: TextStyle(color : Colors.white , fontFamily: 'Montserrat' ,fontWeight: FontWeight.bold) ,
  ),
  minWidth: MediaQuery.of(context).size.width,
            padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            onPressed: () async {

              try{
if(_formKey.currentState.validate())
{ 
 
_auth.sendPasswordResetMail(email);
print('ok');
 _showDialog();             
}
              }catch(e)
              {
                print(e);
              }

}
            
  ),

  
  
  

 
),
SizedBox(height:50.0),




],
    ), 
  
  ),

  
),
    );
  }

void _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("reset Password"),
          content: new Text("Go to your Email to Reset your password account please "),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop(context);
              },
            ),
          ],
        );
      },
    );
  }  
}

