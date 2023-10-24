import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:skywatch_application/domain/interfaces/interfaces.dart';
import 'package:skywatch_application/domain/use_cases/use_cases.dart';

class GetVideoUseCase implements UseCaseBase<File?, bool> {
  final VideosRepository repository;
  const GetVideoUseCase(this.repository);

  @override
  Future<Either<Failure, File?>> call(bool shouldRecord) async {
    try {
      return Right(await repository.getVideo(shouldRecord: shouldRecord));
    } catch (e) {
      return Left(GenericFailure(e));
    }
  }
}
