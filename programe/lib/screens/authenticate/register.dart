
import 'dart:io';

import 'package:email_validator/email_validator.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:programe/screens/home/home.dart';
import 'package:programe/services/auth.dart';
import 'package:programe/services/sign_in.dart';
import 'package:programe/shares/constant.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:programe/services/signInmethod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:path/path.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register>
   {
final _authe = FirebaseAuth.instance;
FirebaseUser loggedInUser;


     void initState()
     {
getCurrentUser();
super.initState();
     }
     
     final AuthService _auth = AuthService();
     final _formeKey = GlobalKey<FormState>();
final FirebaseAuth  _authentification = FirebaseAuth.instance;

      String email ;
      String nom ='';
      String prenom='';
      String cin='';
      String password ='';
      String comfirmpassword ='';
      String error ='';
      bool loading =false;

      //---------------------------------------
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
  
  final   UserCollection = Firestore.instance.collection("user");
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController prenomController = TextEditingController();
  TextEditingController cinController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
 
//Widget Alert styling 

 AnimationType animationType;
 Duration animationDuration;
 ShapeBorder alertBorder;
 bool isCloseButton;
 bool isOverlayTapDismiss;
 Color overlayColor;
 TextStyle titleStyle;
 TextStyle descStyle;
 EdgeInsets buttonAreaPadding;  


//-------------------------------------
File _image;
Future getImage() async{
  var image = await ImagePicker.pickImage(source: ImageSource.gallery);

  setState(()
  {
    _image =image;
    print('Image path $_image');

  });
  return image;
  } 
final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
  
   
      return Scaffold(
 key: _scaffoldKey,
      resizeToAvoidBottomPadding: false ,
      backgroundColor: Colors.green[255],

      appBar: AppBar(

backgroundColor: Colors.green,
elevation: 0.0,
title: Text(
'Inscription'
),
actions: <Widget>[
 FlatButton.icon(
   icon: Icon(
     Icons.person,
     //color: Colors.orange,
   
   ),
   onPressed: () {
     widget.toggleView();
   }, 
   label: Text('Connexion')

   ,
   ) 
],

      ),
body: Container(
  padding: EdgeInsets.symmetric(vertical:20.0,horizontal:50.0),
  child : Form(
    key: _formeKey,
   child:SingleChildScrollView(
    child: Column(
children: <Widget>[
 
 
 Container(
  height: 160,
  width: 150,
  
  decoration: BoxDecoration(
   
    boxShadow: [
      BoxShadow(
        color:Colors.black,
        blurRadius :5.0,
      )
    ],
    borderRadius: BorderRadius.all(Radius.circular(100)),
    
   image : DecorationImage(
     
    image: _image == null
        ? AssetImage('images/icon.png')
        : FileImage(_image),
     fit: BoxFit.cover,
   ) 
  ),
alignment: Alignment.bottomRight,
//child:(_image!=null)?Image.file(_image,fit:BoxFit.fill),
child: IconButton(
  icon: Icon(
    FontAwesomeIcons.camera,
    size: 23.0,
    color:Colors.black54,
  ),
   onPressed: (){
getImage();
   }),

),
 SizedBox(height: 10.0),

//nom
TextFormField(
   decoration : Nom,
  controller: nameController,

    validator: (val) => val.isEmpty ? 'name can\'t be empty' : null,
   onChanged : (val)
   {
setState(() => nom = val);
   }
 

  
 ),
 

 SizedBox(height: 20.0),

 //prenom
 TextFormField(
   decoration : Prenom,
   controller: prenomController,
    validator: (val) => val.isEmpty ? 'LastName can\'t be empty' : null,
   onChanged : (val)
   {
setState(() => prenom = val);
   }
 ),
 SizedBox(height: 20.0),
 //EMAIL
 TextFormField(
   decoration : emailField,
  controller:  emailController,
    validator:(value) {
      if (!EmailValidator.validate(value)) {
        return 'Please enter a valid email';
      }
    },
   onChanged : (val)
   {
setState(() => email = val);
   }
 ),
SizedBox(height: 20.0),

//CIN
TextFormField(
   decoration : CIN,
  controller: cinController,
    validator: (value) {
              if(value.length < 2){
                return 'Name not long enough';
              }
            },
   onChanged : (val)
   {
setState(() =>cin = val);
   }
 ),

SizedBox(height: 20.0),

//password
TextFormField(
  decoration : passwordField,
  controller: passwordController,
 validator: (val) => val.length <6 ? 'Enter a password 6+ chars Long ' : null,
  obscureText: true,
onChanged: (val)
{
setState(() => password = val);
},
),
SizedBox(height: 20.0),
//comfirm password


SizedBox(height:20.0),


 RaisedButton(

   
   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32.0)),
      highlightElevation: 0,
       color:  Colors.orange,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
            
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                'Inscription',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontFamily: 'Montserrat' ,
                  
                  fontWeight: FontWeight.bold
                ),
              ),
            )
          ],
        ),
      ),
                 onPressed: ()  async {

bool access=false;
  
  if (_formeKey.currentState.validate()) {
    String filename=basename(_image.path);
StorageReference firebaseStorageRef = FirebaseStorage.instance.ref().child(filename);
StorageUploadTask uploadTasck = firebaseStorageRef.putFile(_image);
StorageTaskSnapshot taskSnapshot = await uploadTasck.onComplete;
var url = await taskSnapshot.ref.getDownloadURL();
       _authentification.createUserWithEmailAndPassword(
            email: emailController.text, password: passwordController.text)
        .then((result) {
      UserCollection.document(result.user.uid).setData({
        'email': emailController.text,
        'nom': nameController.text,
        'prenom':prenomController.text,
        'cin': cinController.text,
        'ID_user' : result.user.uid,
        'image': url,
        'access':access,
    
        
      }).catchError((err) {
      
      print(err);
    });
  

      if (result.user != null){
  result.user.sendEmailVerification();
       _showScaffold("GOOD"); 
print('ok');
   
}else
{
  print('ono');
}



   });
  

      //    Navigator.of(context).push(
      //   MaterialPageRoute(
      //     builder: (context) {
      //       return  SignIn();
      //     },
      //   ),
      // );
    
    }
  

}
 ),
SizedBox(height:20.0),




],
    ), 
   ),
  ),

  
),
    );

   
    }
  

  
 


void _showScaffold(String message) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(message),
    ));
}
  Widget  _signInButton(BuildContext context) {

    return OutlineButton(
      splashColor: Colors.black,
      onPressed: (){

    signInWithGoogle().whenComplete(() {
     // _ackAlert(context);
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) {
            return home();
          },
        ),
      );
    });
  },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      highlightElevation: 0,
      borderSide: BorderSide(color: Colors.green),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
          Image(image: AssetImage("images/google_logo.png"), height: 35.0),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                'Sign in with Google',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.green,
                ),
              ),
            )
          ],
        ),
      ),
    );

  }
   
 
 
}

