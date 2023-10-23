import 'package:mocktail/mocktail.dart';
import 'package:skywatch_application/domain/interfaces/drivers/drivers.dart';
import 'package:skywatch_application/domain/interfaces/interfaces.dart';

class LocationAdapterMock extends Mock implements LocationDrive {
  When _requestPermission() => when(() => requestPermission());
  void requestPermissionStub([bool response = true]) => _requestPermission().thenAnswer((_) async => response);

  When _getLocation() => when(() => getLocation());
  void getLocationStub(LocationEntity response) => _getLocation().thenAnswer((_) async => response);
  void getLocationStubError(exception) => _getLocation().thenThrow(exception);
}
