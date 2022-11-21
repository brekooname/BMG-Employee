// import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firedart/firedart.dart';
import 'package:flutter/cupertino.dart';

import 'firebase_auth_repo.dart';

class FirebaseRepository extends FirebaseAuthRepo {
  Firestore get fbstore => Firestore.instance;

  Future<List<Document>?>? fetchDocuments(
      {required String collectionPath, String? orderBy}) async {
    List<Document> docs;
    if (orderBy != null) {
      docs = await fbstore.collection(collectionPath).orderBy(orderBy).get();
    } else {
      docs = await fbstore.collection(collectionPath).get();
    }

    if (docs.isNotEmpty) {
      return docs;
    }

    return null;
  }

  Future<Document?>? getDocument({required String documentPath}) async {
    final isExist = await _documentExist(documentPath: documentPath);
    if (isExist) {
      final doc = await fbstore.document(documentPath).get();
      return doc;
    }
    return null;
  }

  Future<bool> _documentExist({required String documentPath}) {
    return fbstore.document(documentPath).exists;
  }

  Future<Document> addDocument(
      {required String collection, required Map<String, dynamic> json}) async {
    final res = await fbstore.collection(collection).add(json);
    return res;
  }

  Future<void> updateDocument(
      {required String collection,
      required String documentId,
      required Map<String, dynamic> json}) async {
    final res =
        await fbstore.collection(collection).document(documentId).update(json);
    return res;
  }

  Future<void> deleteDocument(
      {required String collection, required String documentId}) async {
    return await fbstore.collection(collection).document(documentId).delete();
  }

  Future<List<Document>> getDocumentsWhere({
    required String collection,
    required String fieldPath,
    required String isEqualTo,
    String? fieldPath2,
    String? isEqualTo2,
  }) async {
    late List<Document> docs;
    docs = await _getwhere(
        collection: collection,
        fieldPath: fieldPath,
        isEqualTo: isEqualTo,
        fieldPath2: fieldPath2,
        isEqualTo2: isEqualTo2);

    if (docs.isNotEmpty) {
      return docs;
    }
    return List<Document>.empty();
  }

  Future<void> deleteDocuments({
    required String collection,
    required String fieldPath,
    required String isEqualTo,
    String? fieldPath2,
    String? isEqualTo2,
  }) async {
    late List<Document> docs;
    docs = await _getwhere(
        collection: collection,
        fieldPath: fieldPath,
        isEqualTo: isEqualTo,
        fieldPath2: fieldPath2,
        isEqualTo2: isEqualTo2);

    if (docs.isNotEmpty) {
      for (var doc in docs) {
        return await fbstore.collection(collection).document(doc.id).delete();
      }
    }
  }

  Future<List<Document>> _getwhere({
    required String collection,
    required String fieldPath,
    required String isEqualTo,
    String? fieldPath2,
    String? isEqualTo2,
  }) async {
    if (fieldPath2 != null && isEqualTo2 != null) {
      return await fbstore
          .collection(collection)
          .where(fieldPath, isEqualTo: isEqualTo)
          .where(fieldPath2, isEqualTo: isEqualTo2)
          .get();
    } else {
      return await fbstore
          .collection(collection)
          .where(fieldPath, isEqualTo: isEqualTo)
          .get();
    }
  }

  dummyMethod() async {
    final res = await fbstore
        .collection("attendance")
        .where("date", isEqualTo: "Friday, November 18, 2022")
        // .where("date",isEqualTo: "Friday, November 18")
        // .orderBy("start")
        .get();
    debugPrint(res.toString());
    return res;
  }
}
