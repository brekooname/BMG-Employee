import '../../../../core/firebase/firebase_firestore_repository.dart';
import '../../../../core/shared/shared.dart';
import '../../../../core/utils/app_strings.dart';
import '../models/attendance_model.dart';

abstract class AttendanceDataSource {
  Future<AttendanceModel?> getPickedAttendance({required String day});
  Future<AttendanceModel> startAttendance(
      {required AttendanceModel attendanceModel});
  Future<void> endAttendance({required AttendanceModel attendanceModel});
}

class AttendanceDataSourceImpl implements AttendanceDataSource {
  final FirebaseRepository firebaseRepository;

  AttendanceDataSourceImpl({required this.firebaseRepository});
  @override
  Future<AttendanceModel?> getPickedAttendance({required String day}) async {
    final response = await firebaseRepository.getDocumentsWhere(
        collection: AppStrings.colAttendance,
        fieldPath: AppStrings.fieldCode,
        isEqualTo: currentUser!.userCode,
        fieldPath2: AppStrings.fieldDate,
        isEqualTo2: day);
    if (response.isEmpty) {
      return null;
    }
    return AttendanceModel.fromJson(response.first.id, response.first.map);
  }

  @override
  Future<AttendanceModel> startAttendance(
      {required AttendanceModel attendanceModel}) async {
    // await firebaseRepository.deleteDocuments(
    //     collection: AppStrings.colAttendance,
    //     fieldPath: AppStrings.fieldCode,
    //     isEqualTo: attendanceModel.userCode,
    //     fieldPath2: AppStrings.fieldDate,
    //     isEqualTo2: attendanceModel.date);
    final res = await firebaseRepository.addDocument(
        collection: AppStrings.colAttendance, json: attendanceModel.toJson());
    return AttendanceModel.fromJson(res.id, res.map);
  }

  @override
  Future<void> endAttendance({required AttendanceModel attendanceModel}) async {
    return await firebaseRepository.updateDocument(
        collection: AppStrings.colAttendance,
        documentId: attendanceModel.id,
        json: attendanceModel.toJson());
  }
}
