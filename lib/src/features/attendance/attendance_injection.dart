
import '../../injector_container.dart';
import 'data/datasources/attendance_data_source.dart';
import 'data/repositories/attendance_repo_impl.dart';
import 'domain/repositories/attendance_repo.dart';
import 'domain/usecases/attendance_use_case.dart';
import 'domain/usecases/attendance_use_case_impl.dart';
import 'presentation/cubit/attendance_cubit.dart';


void initAttendanceInjection()  {
  ///Blocs
  getIt.registerFactory<AttendanceCubit>(() => AttendanceCubit(attendanceUseCase: getIt()));

  ///usecases
  getIt.registerLazySingleton<AttendanceUseCase>(() => AttendanceUseCaseImpl(attendanceRepo: getIt()));

  ///Repositories
  getIt.registerLazySingleton<AttendanceRepo>(() => AttendanceRepoImpl(
        attendanceDataSourceImpl: getIt(),
        networkInfo: getIt(),
      ));

  ///DataSources
  getIt.registerLazySingleton<AttendanceDataSourceImpl>(() => AttendanceDataSourceImpl(firebaseRepository: getIt()));

}
