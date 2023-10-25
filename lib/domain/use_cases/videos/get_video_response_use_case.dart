import 'package:dartz/dartz.dart';
import 'package:skywatch_application/domain/interfaces/interfaces.dart';
import 'package:skywatch_application/domain/use_cases/use_cases.dart';

class GetVideoResponseUseCase implements UseCaseBase<SkyVideoResponseEntity, NoParams> {
  final VideosRepository repository;
  const GetVideoResponseUseCase(this.repository);

  @override
  Future<Either<Failure, SkyVideoResponseEntity>> call(NoParams params) async {
    try {
      return Right(await repository.readEntities());
    } catch (e) {
      return Left(GenericFailure(e));
    }
  }
}
