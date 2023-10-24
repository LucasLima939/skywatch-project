import 'package:mocktail/mocktail.dart';
import 'package:skywatch_application/domain/interfaces/interfaces.dart';
import 'package:skywatch_application/domain/use_cases/use_cases.dart';
import 'package:dartz/dartz.dart';

class GetCurrentLocationUseCaseMock extends Mock implements GetCurrentLocationUseCase {
  When _mockCall() => when(() => call(any()));
  void mockCall(LocationEntity response) =>
      _mockCall().thenAnswer((_) async => Right<Failure, LocationEntity>(response));
  void mockCallError(Failure failure) => _mockCall().thenAnswer((_) async => Left<Failure, LocationEntity>(failure));
}
