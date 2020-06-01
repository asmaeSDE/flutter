import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:programe/screens/home/EditProfile.dart';
import 'package:programe/services/auth.dart';

class profile extends StatefulWidget {
    profile({Key key}) : super(key: key);
 

      
  @override
  _profileState createState() => _profileState();
 
}
 String ID = '';

  getData() async {

    String userId = (await FirebaseAuth.instance.currentUser()).uid;
    ID = userId;
  }
 
 

class _profileState extends State<profile> {

  IconData verificationOK=Icons.verified_user;
  IconData verificationNo=FontAwesomeIcons.home;
  Color colorRed= Colors.red;
   Color colorGreen= Colors.green;
  AuthService authService = AuthService();
 


 Widget _buildListItem(DocumentSnapshot document ){

return SafeArea(
  
                child: Column(
      mainAxisAlignment: MainAxisAlignment.center,

         children: <Widget>[
            SizedBox(height:50.0),
           CircleAvatar(
                radius: 80.0,
            backgroundImage:   
        NetworkImage(document.data['image']),
       
           ),
           SizedBox(height:20.0),
   Align(
  
   child:Text(
    'Personal Details',
  style:TextStyle(
   color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 30.0,
                        fontFamily: 'Quicksand',
  ),
  ),
   
   ),
  
   SizedBox(height:20.0),
  
  
           
           SizedBox(
           height: 20.0,
           width: 190.0,
  
           child: Divider(
                 color: Colors.orange,
                 
           ) ,
           ),
  
           Card (
                       color : Colors.white,
                       margin: EdgeInsets.symmetric( vertical: 10.0 , horizontal: 25.0),
                  child: ListTile(
   leading: Icon(Icons.person,
                      color : Colors.orange,
  
                    ),
                    title:
                    Text(
 document.data['nom'],
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 15.0,
                      ),
  
                    ),
                    
                      ),
                    
                 
                  
           ),
           Card (
                       color : Colors.white,
                       margin: EdgeInsets.symmetric( vertical: 10.0 , horizontal: 25.0),
                  child: ListTile(
   leading: Icon(Icons.person,
                      color : Colors.orange,
  
                    ),
                    title:
                    Text(
 document.data['prenom'],
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 15.0,
                      ),
  
                    ),
                    
                      ),
                    
                 
                  
           ),
  Card (
                       color : Colors.white,
                       margin: EdgeInsets.symmetric( vertical: 10.0 , horizontal: 25.0),
                  child:  ListTile(
                     leading: Icon(
                       FontAwesomeIcons.idCard,
                     
                      color : Colors.orange,
  
                    ),
                    title:
                    Text(
                     document.data['cin'],
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Source',
                        fontSize: 15.0,
                        
                      ),
  
                    ),
                  ),
           ),
  
  Card (
                       color : Colors.white,
                       margin: EdgeInsets.symmetric( vertical: 10.0 , horizontal: 25.0),
                  child:  ListTile(
                     leading: Icon(Icons.mail,
                      color : Colors.orange,
  
                    ),
                    title:
                    Text(
                document.data['email'],
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'forte',
                        fontSize: 15.0,
                      ),
  
                    ),
                  ),
           ),
  
                 Card (
  
                       color : Colors.white,
                       margin: EdgeInsets.symmetric( vertical: 10.0 , horizontal: 25.0),
                       child: ListTile(
 
                         leading: Icon  (
                           verificationOK,
                           color : colorGreen,
  
                         ),
                        title :
                        Text(
                          'Account verification ',
                          style: TextStyle(
                            color: Colors.black,
                           
                            fontSize: 15.0,
                          ),
  
                        ),
  subtitle:  Text('You account is verficated by Administration , You can now answer forms ')
                       ),
  
                 ),
  
                 SizedBox(height:50.0),
  Row(
     mainAxisAlignment: MainAxisAlignment.center,
  children :<Widget>
  [
    
  RaisedButton(
   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
  color:  Colors.orange,
  onPressed: (){
  
  },
  elevation: 4.0,
  splashColor: Colors.black,
  child: Text(
    'Cancel',
    style: TextStyle(
  color:Colors.white,
  fontSize: 16.0
    ),
    
  
  ),
  
  ),
  SizedBox(width: 25.0),
  RaisedButton(
   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
  color:  Colors.orange,
  onPressed: () async{
  
  Navigator.of(context).push(CupertinoPageRoute(
                    builder: (BuildContext context) => EditProfile()));
   
  },
  elevation: 4.0,
  splashColor: Colors.black,
  child: Text(
    'Edit',
    style: TextStyle(
  color:Colors.white,
  fontSize: 16.0
    ),
    
  
  ),
  
  ),

  ],
                ),
  
    ],
  
                ),


            );
}

 Future  getForms() async{
        var firestore = Firestore.instance;
        getData();
       QuerySnapshot query = await  firestore.collection('user').where('ID_user',isEqualTo:ID).getDocuments();
             return query.documents;
  
   }

final globalKey = GlobalKey<ScaffoldState>();   
 

    Widget build(BuildContext context)  {
      
    return    Scaffold(
        key: globalKey,
        resizeToAvoidBottomPadding: false ,
        backgroundColor: Colors.green[255],
  
        appBar: AppBar(
        
  
  backgroundColor: Colors.green,
  elevation: 0.0,
  title: Text(
  'Profile'
  ),
  centerTitle: true,
  actions: <Widget>[
   FlatButton.icon(
      label: Text(''),
     icon: Icon(
       Icons.person,
       //color: Colors.orange,
     
     ),
     onPressed: () {
      
     }, 
    
   ),

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
                 
               return _buildListItem(snapshot.data[index]);
              },
            );
          }
          return list;
              }
          ),

      
          
    ); 
        
        
  
      
    
         
    }
  
}

 