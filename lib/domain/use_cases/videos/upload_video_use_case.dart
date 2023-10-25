import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:skywatch_application/domain/interfaces/interfaces.dart';
import 'package:skywatch_application/domain/use_cases/use_cases.dart';

class UploadVideoUseCase implements UseCaseBase<String, UploadVideoParam> {
  final VideosRepository repository;
  const UploadVideoUseCase(this.repository);

  @override
  Future<Either<Failure, String>> call(UploadVideoParam params) async {
    try {
      return Right(await repository.uploadVideo(params.file, params.fileName));
    } catch (e) {
      return Left(GenericFailure(e));
    }
  }
}

class UploadVideoParam {
  final File file;
  final String fileName;
  const UploadVideoParam({
    required this.file,
    required this.fileName,
  });
}
