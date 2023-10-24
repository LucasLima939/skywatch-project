import 'package:dartz/dartz.dart';
import 'package:skywatch_application/domain/interfaces/interfaces.dart';
import 'package:skywatch_application/domain/use_cases/use_cases.dart';

class GetWeeklyForecastUseCase implements UseCaseBase<ForecastEntity, LocationEntity> {
  final WeatherRepository repository;
  const GetWeeklyForecastUseCase(this.repository);

  @override
  Future<Either<Failure, ForecastEntity>> call(LocationEntity params) async {
    try {
      return Right(await repository.getWeeklyForecast(params));
    } catch (e) {
      return Left(GenericFailure(e));
    }
  }
}
