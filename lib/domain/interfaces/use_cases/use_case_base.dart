import 'package:equatable/equatable.dart';
import 'package:skywatch_application/domain/interfaces/use_cases/use_cases.dart';
import 'package:dartz/dartz.dart';

abstract class UseCaseBase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

class NoParams extends Equatable {
  @override
  List<Object> get props => [];
}
