import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:programe/models/test.dart';
import 'package:programe/models/user.dart';

class DatabaseService 
{

final String uid;

DatabaseService({this.uid});

  final CollectionReference TestCollection = Firestore.instance.collection("Test");

Future updateUserData(String name ,String lastName , int age)
async {
 return await TestCollection.document(uid).setData({
   'name' : name,
   'lastName' : lastName,
   'age' : age
 });

}

UserData _userDataFromSnapshot(DocumentSnapshot snapshot)
{
  return UserData(
    uid: uid,
    name: snapshot.data['name'],
    lastName : snapshot.data['lastName'],
    age : snapshot.data['age'],

  );
}
Stream<UserData> get userData{
  return TestCollection.document(uid).snapshots().map(_userDataFromSnapshot);
}

// get list stream



List<Test> _testListFromSnapShot(QuerySnapshot snapshot)
{
  return snapshot.documents.map((doc) {
return Test(
  name: doc.data['name'] ??'',
  lastName: doc.data['lastName'] ?? '',
  age: doc.data['age'] ?? 0
);

  }).toList();
}

Stream<List<Test>> get test 
{
  return TestCollection.snapshots()
  .map(_testListFromSnapShot);
}



}