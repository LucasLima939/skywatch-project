import 'package:mocktail/mocktail.dart';
import 'package:skywatch_application/domain/interfaces/interfaces.dart';
import 'package:skywatch_application/domain/use_cases/use_cases.dart';
import 'package:dartz/dartz.dart';

class GetCurrentAddressUseCaseMock extends Mock implements GetCurrentAddressUseCase {
  When _mockCall(LocationEntity params) => when(() => call(params));
  void mockCall(LocationEntity params, AddressEntity response) =>
      _mockCall(params).thenAnswer((_) async => Right<Failure, AddressEntity>(response));
  void mockCallError(LocationEntity params, Failure failure) =>
      _mockCall(params).thenAnswer((_) async => Left<Failure, AddressEntity>(failure));
}
