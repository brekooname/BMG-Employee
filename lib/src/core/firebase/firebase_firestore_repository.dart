// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firedart/firedart.dart';

import 'firebase_auth_repo.dart';


class FirebaseRepository extends FirebaseAuthRepo {
  Firestore get fbstore => Firestore.instance;

  Future<List<Map<String, dynamic>>?>? fetchDocuments(
      {required String collectionPath, String? orderBy}) async {
    List<Document> docs;
    if (orderBy != null) {
      docs = await fbstore.collection(collectionPath).orderBy(orderBy).get();
    } else {
      docs = await fbstore.collection(collectionPath).get();
    }

    if (docs.isNotEmpty) {
      return docs.map((e) => e.map).toList();
    }

    return null;
  }

  Future<Map<String, dynamic>?> getDocument(
      {required String documentPath}) async {
    final isExist = await _documentExist(documentPath: documentPath);
    if (isExist) {
      final doc = await fbstore.document(documentPath).get();
      return doc.map;
    }
    return null;
  }

  Future<bool> _documentExist({required String documentPath}) {
    return fbstore.document(documentPath).exists;
  }

  Future<List<Map<String, dynamic>>> getDocumentsWhere(
      {required String collection,
      required String fieldPath,
      required String isEqualTo}) async {
    final List<Document> docs = await fbstore
        .collection(collection)
        .where(fieldPath, isEqualTo: isEqualTo)
        .get();
    if (docs.isNotEmpty) {
      return docs.map((doc) => doc.map).toList();
    }
    return List.empty();
  }

  Future<List<Document>> dummyMethod() async {
    return await fbstore
        .collection("users")
        .where("phoneNumber", isEqualTo: "+201010784145")
        .get();
  }
}
