import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseRepository {
  FirebaseFirestore get fbstore => FirebaseFirestore.instance;

  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>?> fetch(
      {required String data, String? orderBy}) async {
    Query<Map<String, dynamic>> collenctionRef;
    List<QueryDocumentSnapshot<Map<String, dynamic>>> doc;
    if (orderBy != null) {
      collenctionRef = fbstore.collection(data).orderBy(orderBy);
    } else {
      collenctionRef = fbstore.collection(data);
    }
    QuerySnapshot<Map<String, dynamic>> res = await collenctionRef.get();
    if (res.docs.isNotEmpty) {
      return res.docs;
    }

    return null;
  }
}
