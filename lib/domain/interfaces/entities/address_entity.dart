import 'package:equatable/equatable.dart';

abstract class AddressEntity extends Equatable {
  final String? address;
  final String? city;
  final String? state;
  final String? country;
  const AddressEntity({
    required this.address,
    required this.city,
    required this.country,
    required this.state,
  });

  @override
  List<Object?> get props => [
    address, 
    city,
    state,
    country,
  ];
}
