import 'package:dartz/dartz.dart';
import 'package:skywatch_application/domain/interfaces/interfaces.dart';
import 'package:skywatch_application/domain/use_cases/use_cases.dart';

class WriteEntityUseCase implements UseCaseBase<bool, SkyVideoEntity> {
  final VideosRepository repository;
  const WriteEntityUseCase(this.repository);

  @override
  Future<Either<Failure, bool>> call(SkyVideoEntity params) async {
    try {
      return Right(await repository.writeEntity(params));
    } catch (e) {
      return Left(GenericFailure(e));
    }
  }
}
