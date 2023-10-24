import 'package:skywatch_application/domain/interfaces/interfaces.dart';

class AddressModel extends AddressEntity {
  const AddressModel({
    required super.address,
    required super.city,
    required super.country,
    required super.state,
    required super.stateAbbreviation,
  });
  const AddressModel.empty()
      : super(
          address: null,
          city: null,
          country: null,
          state: null,
          stateAbbreviation: null,
        );
  AddressModel.fromJson(Map<String, dynamic> json)
      : super(
          address: json['road'],
          city: json['city'],
          state: json['state'],
          country: json['country'],
          stateAbbreviation: json['ISO3166-2-lvl4'],
        );
}
