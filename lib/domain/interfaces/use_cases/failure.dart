import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String? message;
  final dynamic error;
  const Failure(
    this.error, {
    this.message,
  });

  @override
  List<Object?> get props => [
        message,
        error,
      ];
}
