import 'package:firebase_auth/firebase_auth.dart';
import 'package:programe/models/user.dart';
import 'database.dart';

class AuthService{

final FirebaseAuth  _auth = FirebaseAuth.instance;



 // private method to create `User` from `FirebaseUser`
User _userFromFireBaseUser(FirebaseUser user)
{
  return user != null ? User(uid:user.uid): null;
}

Stream<User> get user {
// map all `FirebaseUser` objects to `User`, using the `_userFromFirebaseUser` method
  return _auth.onAuthStateChanged
  .map((FirebaseUser user ) => _userFromFireBaseUser(user));

}

Future signInAnon() async {

try{

AuthResult result = await _auth.signInAnonymously();
FirebaseUser user = result.user;
return  _userFromFireBaseUser(user);
}
catch(e){
print(e.toString());
return null;
}
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

Future registerWithEmailandPassword(String email , String password)
async {
  try {
    AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
    FirebaseUser user = result.user;
return _userFromFireBaseUser(user);

  } catch (e) {
    print(e.toString());
    return null;
      }
}

Future SignInWithEmailandPassword(String email , String password)
async {
  try {
    AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
    FirebaseUser user = result.user;

    await DatabaseService(uid:user.uid).updateUserData('Assmae','HM',22);
    
return _userFromFireBaseUser(user);

  } catch (e) {
    print(e.toString());
    return null;
      }
}


}