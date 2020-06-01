import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:programe/models/user.dart';
import 'package:programe/services/auth.dart';


class DatabaseService 
{

final String uid;

 final AuthService _auth = AuthService();
DatabaseService({this.uid});

  final CollectionReference _userCollection = Firestore.instance.collection("user");

Future createUserData(User user)
async {
 try {
      await _userCollection.document(user.uid).setData(user.toJson());
    } catch (e) {
      return e.message;
    }


}


}





