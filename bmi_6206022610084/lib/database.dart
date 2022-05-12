import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class Database {
  FirebaseFirestore firestore;
  initiliase() {
    firestore = FirebaseFirestore.instance;
  }

  Future<void> create(String name, String weight, String height, String sex,
      String age, String BMI) async {
    try {
      await firestore.collection("cal").add({
        'name': name,
        'age': age,
        'sex': sex,
        'height': height,
        'weight': weight,
        'BMI': BMI,
        'times': FieldValue.serverTimestamp()
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> delete(String id) async {
    try {
      await firestore.collection("cal").doc(id).delete();
    } catch (e) {
      print(e);
    }
  }

  Future<List> read() async {
    QuerySnapshot querySnapshot;
    List docs = [];
    try {
      querySnapshot =
          await firestore.collection('cal').orderBy('timestamp').get();
      if (querySnapshot.docs.isNotEmpty) {
        for (var doc in querySnapshot.docs.toList()) {
          Map a = {
            "id": doc.id,
            "name": doc['name'],
            "height": doc["height"],
            "weight": doc["weight"],
            "sex": doc["sex"],
            "age": doc["age"],
            "BMI": doc["BMI"]
          };
          docs.add(a);
        }
        return docs;
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> update(String id, String name, String weight, String height,
      String sex, String age, String BMI) async {
    try {
      await firestore.collection("cal").doc(id).update({
        'name': name,
        'weight': weight,
        'height': height,
        'sex': sex,
        'age': age,
        'BMI': BMI,
      });
    } catch (e) {
      print(e);
    }
  }
}
