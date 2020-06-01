 import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:programe/screens/home/Questions.dart';
import 'package:programe/services/auth.dart';
import 'package:programe/shares/NavDrawer.dart';
import 'package:programe/shares/constant.dart';



class home extends StatefulWidget {
 final String idForm ;

home({Key key, this.idForm}) : super(key: key);

  @override
  _homeState createState() => _homeState();
}

class _homeState extends State<home> {
final _authe = FirebaseAuth.instance;
AuthService auth = AuthService();

FirebaseUser loggedInUser;

 final _formKey = GlobalKey<FormState>();

 


@override
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

Widget _buildList(BuildContext context, DocumentSnapshot document) {
    return Container(
        padding: EdgeInsets.all(10.0),
        child: Center(
          child: Column(
            children: <Widget>[
              Card(
                color: Colors.green[50],
                child: Container(
                   padding: EdgeInsets.all(10),
                   child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
 ClipRRect(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10.0),
                                        topRight: Radius.circular(10.0),
                                      ),
                    child: Image.network( document.data['image'],
                      fit:BoxFit.fill,
                     ),
                     ) ,
                      SizedBox(height: 10.0), 
                       Text(
                   document['title'],
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 20,
                       
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Poppins',
                          color: Colors.green[300],
                        ),
                      ),
                       SizedBox(height: 10.0),
                       Text( 
                        document.data['Description'],
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black45,
                          fontFamily: 'Poppins',
                         
                        ),
                      ),
                       ButtonTheme.bar(
                          child: ButtonBar(
                            children: <Widget>[
                           FlatButton(
                            child: const Text('More Details',
                            
                            style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Poppins',
                          color: Colors.orange,
                          
                        ),
                            )
                            
                            ,
                            onPressed: () { 

String idForm = document['idForm'];

 Navigator.of(context).push(CupertinoPageRoute(
                    builder: (BuildContext context) => Questions(idForm:idForm)));

                             },
                          ),
                          FlatButton(
                            child: const Text('SHARE',
                             style: TextStyle(
                          fontSize: 14,
                          fontFamily: 'Poppins',
                          color: Colors.orange,
                          fontWeight: FontWeight.bold
                        ),
                            ),
                            onPressed: () { /* ... */ },
                          ),
                            ],
                           )
                       )
                    ]
                   ),
                ),
             ),
            ],
          ),
        ),
       );
   
     
  }
 
  @override
  Widget build(BuildContext context) {
    return   Scaffold(
      resizeToAvoidBottomPadding: false ,
      backgroundColor: Colors.green[255],

      appBar: AppBar(

backgroundColor: Colors.green,
elevation: 0.0,
title: Text(
'Questionaire'
),
centerTitle: true,
actions: <Widget>[
 
],

      ),
      drawer:NavDrawer(),

      body: StreamBuilder(
        stream: Firestore.instance.collection('Formulaire').snapshots(),
        builder: (context,  snapshot)
        {
          if(!snapshot.hasData)
          {
            return Text('loading');
          }
          return  ListView.builder(
            itemCount: snapshot.data.documents.length,
            itemBuilder: (context,index)
            {
            

return _buildList(context, snapshot.data.documents[index]);

            });
          
          
        })
        
 
    );
  }
}