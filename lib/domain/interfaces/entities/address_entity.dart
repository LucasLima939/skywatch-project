import 'package:equatable/equatable.dart';

abstract class AddressEntity extends Equatable {
  final String? address;
  final String? city;
  final String? state;
  final String? country;
  final String? stateAbbreviation;
  const AddressEntity({
    required this.address,
    required this.city,
    required this.country,
    required this.state,
    required this.stateAbbreviation,
  });

  @override
  List<Object?> get props => [
        address,
        city,
        state,
        country,
        stateAbbreviation,
      ];
}
