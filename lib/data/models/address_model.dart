import 'package:geocoder_buddy/geocoder_buddy.dart';
import 'package:skywatch_application/domain/interfaces/interfaces.dart';

class AddressModel extends AddressEntity {
  const AddressModel({
    required super.address,
    required super.city,
    required super.country,
    required super.state,
  });
  const AddressModel.empty() : super(address: null, city: null, country: null, state: null);
  AddressModel.fromGBData(GBData response)
      : super(
          address: response.address.iso31662Lvl4,
          country: response.address.country,
          state: response.address.state,
          city: response.address.county,
        );
}
