import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:programe/models/user.dart';
import 'database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';





class AuthService{

final FirebaseAuth  _auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();




User _userFromFireBaseUser(FirebaseUser user)
{
  return user != null ? User(uid:user.uid): null;
}



Stream<User> get user {

  return _auth.onAuthStateChanged
  .map((FirebaseUser user ) => _userFromFireBaseUser(user));

}





Future signUpWithEmail(

      String email,
     String nom,
     String prenom,
    String cine,
     String password,

  ) async {
    try {
        User user;
      var authResult = await _auth.createUserWithEmailAndPassword(
        email: user.email,
        password: password,
      );

      // TODO: Create firestore user here and keep it locally.
 await  DatabaseService(uid:user.uid).createUserData(User(
       uid: authResult.user.uid,
        email: email,
        nom: nom,
        prenom: prenom,

        cine: cine,
      ));

      return authResult.user != null;
    } catch (e) {
      return e.message;
    }
  }

 // private method to create `User` from `FirebaseUser`

 getCurrentUser() async
{
  FirebaseUser user =  await _auth.currentUser();

  return user;

}


Future signOut() async
{
  try {
    return await _auth.signOut();
  } catch (e) {
    print(e.toString());
    return null;
  }
}

//regster with email and password 


Future<bool> isUserLoggedIn() async {

  var user = await _auth.currentUser();
  return user !=null;
}

Future<void> sendPasswordResetMail(String email) async{
    await _auth.sendPasswordResetEmail(email: email.trim());
    return null;
  }

  Future<bool> isEmailVerified() async {
	    FirebaseUser user = await _auth.currentUser();
	    return user.isEmailVerified;
	  }


  Future<FirebaseUser> getUser() {
    return _auth.currentUser();
  }

 Future<void> sendEmailVerification() async {
	    FirebaseUser user = await _auth.currentUser();
	    user.sendEmailVerification();
	  }

    void updateDateUser(String uid , String nom , String prenom , String cine , String email,String image)
   async {
        await Firestore.instance.collection('user').document(uid)
        .updateData({'nom': nom ,'prenom':prenom,'cin':cine,'email':email ,'image':image});

    }


}