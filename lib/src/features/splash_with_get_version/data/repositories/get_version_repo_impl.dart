
import 'package:dartz/dartz.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/utils/app_strings.dart';
import '../../domain/repositories/get_version_repo.dart';
import '../datasources/get_version_data_source.dart';

class GetVersionRepoImpl implements GetVersionRepo {
  final GetVersionDataSourceImpl getVersionDataSourceImpl;

  GetVersionRepoImpl({required this.getVersionDataSourceImpl});
  @override
  Future<Either<Failure, bool>> shouldUpdate() async {
    final int? currentVersion = await getVersionDataSourceImpl.shouldUpdate();
    if (currentVersion != null) {
      final deviceCurrentVersion = int.parse(dotenv.env["CURRENT_VERSION"]!);
      if (currentVersion == deviceCurrentVersion) {
        return right(false);
      }
      return right(true);
    }
    return left(ServerFailure(message: AppStrings.serverFailure));
  }
}
