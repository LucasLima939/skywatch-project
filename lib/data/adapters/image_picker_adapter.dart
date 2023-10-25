import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:skywatch_application/domain/interfaces/drivers/drivers.dart';

class ImagePickerAdapter implements FilePickerDrive {
  final ImagePicker imagePicker;
  const ImagePickerAdapter(this.imagePicker);

  @override
  Future<File?> getFile({bool fromCamera = false, int maxMinutes = 1}) async {
    final file = await imagePicker.pickVideo(
        source: fromCamera ? ImageSource.camera : ImageSource.gallery,
        preferredCameraDevice: CameraDevice.front,
        maxDuration: Duration(minutes: maxMinutes));
    return file != null ? File(file.path) : null;
  }
}
