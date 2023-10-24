import 'package:dartz/dartz.dart';
import 'package:skywatch_application/domain/interfaces/interfaces.dart';
import 'package:skywatch_application/domain/use_cases/use_cases.dart';

class GetCurrentAddressUseCase implements UseCaseBase<AddressEntity, LocationEntity> {
  final WeatherRepository repository;
  const GetCurrentAddressUseCase(this.repository);

  @override
  Future<Either<Failure, AddressEntity>> call(LocationEntity params) async {
    try {
      return Right(await repository.getCurrentAddress(params));
    } catch (e) {
      return Left(GenericFailure(e));
    }
  }
}
