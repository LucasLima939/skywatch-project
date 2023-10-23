import 'package:skywatch_application/domain/interfaces/use_cases/use_cases.dart';

class GenericFailure extends Failure {
  const GenericFailure(super.error, {super.message});
}
