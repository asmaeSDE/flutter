import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:programe/services/auth.dart';
import 'package:progress_dialog/progress_dialog.dart';

class EditProfile extends StatefulWidget {
    
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {

 


      AuthService authService = AuthService();
 final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
      void _showScaffold(String message) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(message),
    ));
  }
  Widget _buildEditProfile(BuildContext context,DocumentSnapshot document)
  {
   TextEditingController emailController = TextEditingController(text:document.data['email']);
  TextEditingController nameController = TextEditingController(text:document.data['nom']);
  TextEditingController prenomController = TextEditingController(text:document.data['prenom']);
  TextEditingController cinController = TextEditingController(text:document.data['cin']);

      String email =document.data['email'];
      String nom =document.data['nom'];
      String prenom=document.data['prenom'];
      String cin=document.data['cin'];

     

     final _formeKey = GlobalKey<FormState>();
 return Form(
key: _formeKey,
    child: new Column(
    children: <Widget>[
       SizedBox(height:20.0),    
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
        ? NetworkImage(document.data['image'])
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
   SizedBox(height:50.0),      
      new ListTile(
        leading: const Icon(
          Icons.person,
         
        ),
        title: new TextFormField(
          decoration: new InputDecoration(
            hintText: document.data['nom'],
            
          ),

          controller: nameController,
          

    
       ),
        subtitle: const Text('Nom '),

        
      ),
new ListTile(
        leading: const Icon(
          Icons.person,
         
        ),
        title: new TextFormField(
          decoration: new InputDecoration(
            hintText: document.data['prenom'],
            
          ),
          controller: prenomController,
        
  
        ),
        subtitle: const Text('Prenom '),

        
      ),
    
      SizedBox(height:20.0),
      new ListTile(
        leading: const Icon(FontAwesomeIcons.idCard,
        ),
        title: new TextFormField(
          decoration: new InputDecoration(
            hintText: document.data['cin'],

          ),
           controller: cinController,
           
           
             onSaved : (val)
   {
 cin = val;
   }
        ),
        subtitle: const Text('CINE'),
      ),
       SizedBox(height:20.0),
      new ListTile(
        leading: const Icon(Icons.email,
        ),
        title: new TextFormField(
          decoration: new InputDecoration(
            hintText: document.data['email'],
          ),
          controller:  emailController,
         
        
        ),
         subtitle: const Text('Email'),
      ),
       SizedBox(height:20.0),
      const Divider(
        height: 1.0,
      ),
     
      SizedBox(height:20.0), 

      RaisedButton(
        padding: const
        EdgeInsets.all(12.0),
 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
color:  Colors.orange,
onPressed: () async {
if (_formeKey.currentState.validate()) {
  
String filename=basename(_image.path);
StorageReference firebaseStorageRef = FirebaseStorage.instance.ref().child(filename);
StorageUploadTask uploadTasck = firebaseStorageRef.putFile(_image);
StorageTaskSnapshot taskSnapshot = await uploadTasck.onComplete;
var url = await taskSnapshot.ref.getDownloadURL();
authService.updateDateUser(document.data['ID_user'],nameController.text, prenomController.text, cinController.text, emailController.text,url);
   pr.show();
         Future.delayed(Duration(seconds: 3)).then((value) {
              pr.hide().whenComplete(() {
                
                  _showScaffold("Your Profile Has updated") ;
              });
 });
 
    }
},
elevation: 10.0,
splashColor: Colors.black,
child: Text(
  'Save',
  style: TextStyle(
color:Colors.white,
fontSize: 16.0
  ),
  

),

),
    ],
  ),

  
  );

  }
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  FirebaseDatabase _auth = FirebaseDatabase.instance;
  
  
String title='';
String url='';

 bool loading=false;
 final globalKey = GlobalKey<ScaffoldState>();

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

  
  
  
var ID='';
     getData() async {

    String userId = (await FirebaseAuth.instance.currentUser()).uid;
    ID = userId;
  }

Future  getForms() async{
        var firestore = Firestore.instance;
        getData();
       QuerySnapshot query = await  firestore.collection('user').where('ID_user',isEqualTo:ID).getDocuments();
             return query.documents;
  
   }
ProgressDialog pr;
  @override
  Widget build(BuildContext context)  {
    
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
    return new Scaffold(
      key: _scaffoldKey,
   appBar: AppBar(
      

backgroundColor: Colors.green,
elevation: 0.0,
title: Text(
'Edit profile '
),
centerTitle: true,
actions: <Widget>[

   
],

      ),
  
  body:  FutureBuilder(
           
         future: getForms(),
          builder:
              (_,snapshot) {
 Widget list=Column(children: <Widget>[],);
           if(snapshot.connectionState == ConnectionState.waiting){

              list = Center(child: Text('Loading ... '),);
            
          }
          else {
            list= ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (_,index) {
                 
               return  _buildEditProfile(context,snapshot.data[index]);
              },
            );
          }
          return list;
              }
          ),
  
 
  
  
);
  }
}
