import 'package:dartz/dartz.dart';
import 'package:skywatch_application/domain/interfaces/interfaces.dart';
import 'package:skywatch_application/domain/use_cases/use_cases.dart';

class GetCurrentLocationUseCase implements UseCaseBase<LocationEntity, NoParams> {
  final WeatherRepository repository;
  const GetCurrentLocationUseCase(this.repository);

  @override
  Future<Either<Failure, LocationEntity>> call(NoParams params) async {
    try {
      return Right(await repository.getCurrentLocation());
    } catch (e) {
      return Left(GenericFailure(e));
    }
  }
}
