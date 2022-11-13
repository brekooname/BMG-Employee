import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/useCases/usecase.dart';
import '../../domain/usecases/get_version_use_case.dart';

part 'get_version_state.dart';

class GetVersionCubit extends Cubit<GetVersionState> {
  final GetVersionUseCaseImpl getVersionUseCaseImpl;
  GetVersionCubit({required this.getVersionUseCaseImpl})
      : super(SplashWithGetVersionInitial());
  bool _gotUpdate = false;
  bool get gotUpdate {
    return _gotUpdate;
  }

  shouldUpdate() async {
    emit(GetVersionLoading());
    final Either<Failure, bool> response =
        await getVersionUseCaseImpl.call(NoParams());
    response.fold((failure) => emit(GetVersionFailed()), (shouldUpdate) {
      if (shouldUpdate) {
        _gotUpdate = true;
        emit(VersionIsUpToDate());
      } else {
        emit(VersionIsFine());
      }
    });
  }
}
