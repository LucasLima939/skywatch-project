import 'dart:io';

abstract class FilePickerDrive {
  Future<File?> getFile({bool fromCamera = false, int maxMinutes = 1});
}