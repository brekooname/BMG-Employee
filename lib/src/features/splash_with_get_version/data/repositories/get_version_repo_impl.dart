import 'package:dartz/dartz.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:project_template/src/core/error/exceptions.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../../../core/utils/app_strings.dart';
import '../../domain/repositories/get_version_repo.dart';
import '../datasources/get_version_data_source.dart';

class GetVersionRepoImpl implements GetVersionRepo {
  final GetVersionDataSourceImpl getVersionDataSourceImpl;
  final NetworkInfo networkInfo;

  GetVersionRepoImpl({
    required this.getVersionDataSourceImpl,
    required this.networkInfo,
  });
  @override
  Future<Either<Failure, bool>> shouldUpdate() async {
    if (await networkInfo.isConnected) {
      try {
        final int? currentVersion =
            await getVersionDataSourceImpl.shouldUpdate();
        if (currentVersion != null) {
          final deviceCurrentVersion =
              int.parse(dotenv.env["CURRENT_VERSION"]!);
          if (currentVersion == deviceCurrentVersion) {
            return right(false);
          }
          return right(true);
        }
      } catch(exception) {
        return left(ServerFailure(message:exception.toString()));
      }
    }
    return left(ServerFailure(message: AppStrings.serverFailure));
  }
}
