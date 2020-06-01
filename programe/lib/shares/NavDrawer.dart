import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:programe/screens/home/profile.dart';
import 'package:programe/services/auth.dart';
import 'package:programe/services/sign_in.dart';
import 'package:progress_dialog/progress_dialog.dart';


class NavDrawer extends StatelessWidget {
 NavDrawer({Key key, this.user}) : super(key: key);
  final FirebaseUser user;
  @override
  ProgressDialog pr;
  AuthService _auth = AuthService();

 
  FirebaseUser currentUser;


  Widget build(BuildContext context) {
   
FirebaseAuth.instance.currentUser().then((FirebaseUser user) {
  // call setState to rebuild the view
     this.currentUser = user;
   
});
String _email() {
    if (currentUser != null) {
      return currentUser.email;
    } else {
      return "no current user";
    }
}
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
  
 

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
       
         UserAccountsDrawerHeader(

            decoration: BoxDecoration(
        color: Colors.green[200],
    ),
           arrowColor: Colors.green[100],
  accountEmail: Text(_email(),
  
  style: TextStyle(
    fontFamily: 'forte',
    fontSize: 20,
  ),
  ),
  
  currentAccountPicture: CircleAvatar(
    
    backgroundColor:
            Colors.white,
            foregroundColor: Colors.green,
    child: Image.asset('images/logo.png',
    width: 100,
    height: 100,
    
    ),
  ),
),
          SizedBox(height:20.0),
          ListTile(
            leading: Icon(Icons.input),
            title: Text('Welcome'),
            onTap: () => {},
          ),
          ListTile(
            leading: Icon(Icons.verified_user),
            title: Text('Profile'),
            onTap: () => {
         
         Future.delayed(Duration(seconds: 3)).then((value) {
              pr.hide().whenComplete(() {
                Navigator.of(context).push(CupertinoPageRoute(
                    builder: (BuildContext context) => profile()));
              });
 }),
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: Icon(Icons.notification_important),
            title: Text('notifications'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: Icon(Icons.forum),
            title: Text('Forms'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: () => {
               Future.delayed(Duration(seconds: 3)).then((value) {
              pr.hide().whenComplete(() {
                _auth.signOut();
                Navigator.of(context).push(CupertinoPageRoute(
                    builder: (BuildContext context) => SignIn()));
              });
 }),
     
            },
          ),
        ],
      ),
    );
  }
}