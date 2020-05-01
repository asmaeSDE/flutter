import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:programe/models/test.dart';

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