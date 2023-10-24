import 'package:dartz/dartz.dart';
import 'package:skywatch_application/domain/interfaces/interfaces.dart';
import 'package:skywatch_application/domain/use_cases/use_cases.dart';

class LikeVideoUseCase implements UseCaseBase<bool, SkyVideoEntity> {
  final VideosRepository repository;
  const LikeVideoUseCase(this.repository);

  @override
  Future<Either<Failure, bool>> call(SkyVideoEntity params) async {
    try {
      return Right(await repository.likeVideo(params));
    } catch (e) {
      return Left(GenericFailure(e));
    }
  }
}
