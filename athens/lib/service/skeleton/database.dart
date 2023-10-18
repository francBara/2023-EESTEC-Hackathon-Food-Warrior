

import 'package:athens/model/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Database {
  static final FirebaseFirestore _firestoreInstance = FirebaseFirestore.instance;

  static Future<Map<String, dynamic>> get(String collection, String doc) async {
    DocumentSnapshot documentSnapshot = await _firestoreInstance.collection(collection).doc(doc).get();
    if (!documentSnapshot.exists) {
      throw('Document not found');
    }
    Map<String, dynamic> data = documentSnapshot.data()! as Map<String, dynamic>;
    data['id'] = documentSnapshot.id;
    return data;
  }

  static Future<void> post(String collection, String doc, Map<String, dynamic> data) async {
    await _firestoreInstance.collection(collection).doc(doc).set(data);
  }

  static Future<void> update(String collection, String doc, Map<String, dynamic> data) async {
    await _firestoreInstance.collection(collection).doc(doc).update(data);
  }

  static Future<void> delete(String collection, String doc) async {
    await _firestoreInstance.collection(collection).doc(doc).delete();
  }

  static Future<List<Map<String, dynamic>>> getAll(String collection) async {
    final QuerySnapshot snapshot = await _firestoreInstance.collection(collection).get();

    List<Map<String, dynamic>> data = [];
    int i = 0;
    for (DocumentSnapshot document in snapshot.docs) {
      data.add(document.data() as Map<String, dynamic>);
      data[i]['id'] = document.id;
      i++;
    }

    return data;
  }

  static Future<List<Map<String, dynamic>>> getAllGroup(String collection) async {
    final QuerySnapshot snapshot = await _firestoreInstance.collectionGroup(collection).get();

    List<Map<String, dynamic>> data = [];
    int i = 0;
    for (DocumentSnapshot document in snapshot.docs) {
      data.add(document.data() as Map<String, dynamic>);
      data[i]['id'] = document.id;
      i++;
    }

    return data;
  }

  static Future<Map<String, dynamic>> getDailyDoc(String collection) async {
    final QuerySnapshot snapshot = await _firestoreInstance
        .collection(collection)
        .where('isDaily', isEqualTo: true)
        .limit(1)
        .get();
    Map<String, dynamic> data =
        snapshot.docs[0].data()! as Map<String, dynamic>;
    data['id'] = snapshot.docs[0].id;
    return data;
  }

  /*
  static Future<EcoUser> addUser(String id, String fullName, String email) async {
    EcoUser user = EcoUser.manual(email, 0, fullName);
    // add and return user with id
    await _firestoreInstance.collection('users').doc(id).set(user.toMap());
    return user;

  }

  static Future<EcoUser> getUser() async {
    final Map<String, dynamic> data = await get('users', FirebaseAuth.instance.currentUser!.uid);
    return EcoUser(data);
  }
*/

  static Future<List<FoodUser>> getTopUsers() async {
    final QuerySnapshot snapshot =
    await _firestoreInstance.collection('users').orderBy('points', descending: true).limit(30).get();

    List<Map<String, dynamic>> data = [];
    int i = 0;
    for (DocumentSnapshot document in snapshot.docs) {
      data.add(document.data() as Map<String, dynamic>);
      data[i]['id'] = document.id;
      i++;
    }



    return [FoodUser(), ...data.map((e) => FoodUser.fromMap(e)).toList()];
  }

}
