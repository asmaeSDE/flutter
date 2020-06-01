import 'package:flutter/material.dart';
import 'package:programe/screens/authenticate/authenticate.dart';
import 'package:provider/provider.dart';
import 'package:programe/models/user.dart';
import 'package:programe/services/auth.dart';

import 'home/home.dart';


class wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

  
    //it will return the nearest variable of type T found (or throw if nothing is found).
    //to retrieve an instance of User 
final user = Provider.of<User>(context);

//var hasLoggedInUser = await _auth.
 
   if(user == null)
   {
     return authenticate();
   }else 
   {
     return home();
   }
  }
}