import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:programe/models/user.dart';

import 'package:programe/services/auth.dart';
import 'package:programe/services/database.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'TestList.dart';
import 'package:programe/models/test.dart';
import 'package:provider/provider.dart';
class home extends StatelessWidget {

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    


void _showSettingPanel()
{
  showModalBottomSheet(context: context, builder: (context)
  {
    return Container(
padding: EdgeInsets.symmetric(vertical:20.0,horizontal:60.0),
//child:  SettingsForm(),
    );
  } );
}

    return StreamProvider<List<Test>>.value(
      value: DatabaseService().test,
      child: Scaffold(
     backgroundColor: Colors.green,
      appBar: AppBar(
        title: Text('Home'),
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        actions : <Widget>[
          FlatButton.icon(
            onPressed: () async{
await _auth.signOut();

            },
             icon: Icon(Icons.person),
              label: Text('logout'),
              ),
       FlatButton.icon(

            onPressed: () => _showSettingPanel(),

            
             icon: Icon(Icons.settings),
              label: Text('settings'),
              ),
        ],
      ),

      body: TestList(),
      ),
    );
  }
}