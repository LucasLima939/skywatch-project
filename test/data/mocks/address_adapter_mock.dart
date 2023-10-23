import 'package:mocktail/mocktail.dart';
import 'package:skywatch_application/domain/interfaces/drivers/drivers.dart';
import 'package:skywatch_application/domain/interfaces/interfaces.dart';

class AddressAdapterMock extends Mock implements AddressDrive {
  When _getAddress(double lat, double lng) => when(() => getAddress(lat, lng));
  void getAddressStub(double lat, double lng, AddressEntity response) => _getAddress(lat, lng).thenAnswer((_) async => response);
  void getAddressStubError(double lat, double lng, exception) => _getAddress(lat, lng).thenThrow(exception);
}