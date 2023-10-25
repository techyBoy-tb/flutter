import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/models/Brew.dart';
import 'package:firebase/models/CustomUser.dart';

class DatabaseService {
  final String uid;
  DatabaseService({required this.uid});

  final CollectionReference brewCollection =
      FirebaseFirestore.instance.collection('brews');

  Future<void> updateUserData(String sugars, String name, int strength) async {
    return await brewCollection
        .doc(uid)
        .set({'sugars': sugars, 'name': name, 'strength': strength});
  }

  List<Brew> _brewListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      Map data = jsonDecode(jsonEncode(doc.data()));

      Brew brew = Brew(
          name: data['name'] ?? '',
          sugars: data['sugars'] ?? '',
          strength: data['strength'] ?? 0);
      return brew;
    }).toList();
  }

  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    Map data = jsonDecode(jsonEncode(snapshot.data()));

    return UserData(
        uid: uid,
        name: data['name'] ?? '',
        sugars: data['sugars'] ?? '',
        strength: data['strength'] ?? 0);
  }

  Stream<List<Brew>>? get brews {
    return brewCollection.snapshots().map(_brewListFromSnapshot);
  }

  Stream<UserData> get userData {
    return brewCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
  }
}
