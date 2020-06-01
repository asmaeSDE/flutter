import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class Questions extends StatelessWidget {
  final String idForm ;


Widget _buildCard(DocumentSnapshot document)

{
 return Card(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        ListTile(
          leading: Icon(Icons.album, size: 50),
          title: Text(document.data['question']),
          subtitle: Text('TWICE'),
        ),
      ],
    ),
  );
}
Questions({Key key, this.idForm}) : super(key: key);
  @override

   Future  getForms() async{
        var firestore = Firestore.instance;
       
       QuerySnapshot query = await  firestore.collection('card').where('idForm',isEqualTo:idForm).getDocuments();
             return query.documents;
  
   }
  Widget build(BuildContext context) {
    return Scaffold(
  
      resizeToAvoidBottomPadding: false ,
      backgroundColor: Colors.green[255],

      appBar: AppBar(

backgroundColor: Colors.green,
elevation: 0.0,
title: Text(
'Inscription'
),
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
                 
               return _buildCard(snapshot.data[index]);
              },
            );
          }
          return list;
              }
          ),
    );
}
}