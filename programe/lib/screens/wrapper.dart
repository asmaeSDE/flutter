import 'package:flutter/material.dart';
import 'package:programe/screens/authenticate/authenticate.dart';
import 'package:provider/provider.dart';
import 'package:programe/models/user.dart';

import 'home/home.dart';


class wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

final user = Provider.of<User>(context);


   if(user == null)
   {
     return authenticate();
   }else 
   {
     return home();
   }
  }
}