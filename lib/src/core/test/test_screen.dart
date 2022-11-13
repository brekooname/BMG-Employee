
import 'package:flutter/material.dart';
import 'package:project_template/src/injector_container.dart' as di;

import '../firebase/firebase_firestore_repository.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({super.key});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  FirebaseRepository firebaseRepository =di.getIt<FirebaseRepository>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Column(
        children: const[

        ],
      )
      //  Center(
      //   child: FutureBuilder(
      //     future: getter(),
      //     builder: (context,AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
      //       return Text(snapshot.data!.docs.first.get("code").toString());
      //     }
      //   ),
      // ),
    );
  }

  //  Future<QuerySnapshot<Map<String, dynamic>>> getter() async {
  //    return await firebaseRepository.fbstore
  //       .collection("users").get();
  // }
}
