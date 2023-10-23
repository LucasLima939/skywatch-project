import 'package:skywatch_application/domain/interfaces/interfaces.dart';

abstract class AddressDrive {
  Future<AddressEntity> getAddress(double lat, double lng);
}