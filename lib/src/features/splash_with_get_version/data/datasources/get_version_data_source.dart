
import 'package:firedart/firestore/models.dart';

import '../../../../core/firebase/firebase_firestore_repository.dart';
import '../../../../core/utils/app_strings.dart';

abstract class GetVersionDataSource {
  Future<int?> shouldUpdate();
}

class GetVersionDataSourceImpl implements GetVersionDataSource {
  final FirebaseRepository firebaseRepository;

  GetVersionDataSourceImpl({required this.firebaseRepository});
  @override
  Future<int?> shouldUpdate() async {
    final  List<Document>? data =
        await firebaseRepository.fetchDocuments(collectionPath: AppStrings.colVersionControl);
    if (data == null) return null;
    return data.first.map[AppStrings.varCurrentVersion];
  }
}
