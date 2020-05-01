import 'package:flutter/material.dart';
import 'package:programe/models/test.dart';

class TestTile extends StatelessWidget {
  final Test test ; 
  TestTile({this.test});


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top:8.0),
      child: Card(
        margin:EdgeInsets.fromLTRB(20.0,6.0,20.0,0.0),
        child: ListTile(
          leading:  CircleAvatar(
            radius: 25.0,
            backgroundColor: Colors.brown[200],


          ),
title: Text(test.name),
subtitle: Text('Takes ${test.lastName} sugars(s)'),
        ),
      ),
    );
  }
}