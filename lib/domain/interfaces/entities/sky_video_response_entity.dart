import 'package:equatable/equatable.dart';
import 'package:skywatch_application/domain/interfaces/interfaces.dart';

abstract class SkyVideoResponseEntity extends Equatable {
  final List<SkyVideoEntity> entities;
  const SkyVideoResponseEntity({required this.entities});

  @override
  List<Object> get props => [entities];
}