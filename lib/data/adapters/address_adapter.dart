import 'package:geocoder_buddy/geocoder_buddy.dart';
import 'package:skywatch_application/data/models/address_model.dart';
import 'package:skywatch_application/domain/interfaces/drivers/drivers.dart';
import 'package:skywatch_application/domain/interfaces/entities/address_entity.dart';

class AddressAdapter extends AddressDrive {
  @override
  Future<AddressEntity> getAddress(double lat, double lng) async {
    GBLatLng position = GBLatLng(lat: lat, lng: lng);
    final data = await GeocoderBuddy.findDetails(position);
    return AddressModel.fromGBData(data);
  }
}
