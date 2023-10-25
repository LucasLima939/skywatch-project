import 'package:dartz/dartz.dart';
import 'package:skywatch_application/domain/interfaces/interfaces.dart';
import 'package:skywatch_application/domain/use_cases/use_cases.dart';

class RemoveLikeVideoUseCase implements UseCaseBase<bool, SkyVideoEntity> {
  final VideosRepository repository;
  const RemoveLikeVideoUseCase(this.repository);

  @override
  Future<Either<Failure, bool>> call(SkyVideoEntity params) async {
    try {
      return Right(await repository.removeLikeVideo(params));
    } catch (e) {
      return Left(GenericFailure(e));
    }
  }
}
