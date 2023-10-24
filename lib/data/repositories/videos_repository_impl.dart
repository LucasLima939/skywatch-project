import 'dart:io';
import 'package:skywatch_application/data/constants/constants.dart';
import 'package:skywatch_application/data/models/models.dart';
import 'package:skywatch_application/domain/interfaces/drivers/drivers.dart';
import 'package:skywatch_application/domain/interfaces/interfaces.dart';

class VideosRepositoryImpl implements VideosRepository {
  final FirebaseDrive firebaseDrive;
  final FilePickerDrive filePickerDrive;
  VideosRepositoryImpl({
    required this.firebaseDrive,
    required this.filePickerDrive,
  });
  String? uid;

  @override
  Future<String?> getUserAnonymousId() async => uid ??= await firebaseDrive.signInAnonymously();

  @override
  Future<File?> getVideo({bool shouldRecord = false, int maxMinutes = 1}) async =>
      await filePickerDrive.getFile(fromCamera: shouldRecord, maxMinutes: maxMinutes);

  @override
  Future<SkyVideoResponseEntity> readEntities() async =>
      await firebaseDrive.readAllData(FirebaseRefs.videos).then((data) => SkyVideoResponseModel.fromJson(data));

  @override
  Future<bool> writeEntity(SkyVideoEntity entity) async {
    if (uid == null) await getUserAnonymousId();
    return await firebaseDrive.writeData(entity.toJson(uid!), FirebaseRefs.videos, uid!);
  }

  @override
  Future<String> uploadVideo(File file, String fileName) async =>
      await firebaseDrive.uploadVideo(file, "$uid/$fileName");

  @override
  Future<bool> likeVideo(SkyVideoEntity entity) async {
    if(entity.uid == null) return false;
    if (uid == null) await getUserAnonymousId();
    return await firebaseDrive.updateList('likes', uid!, FirebaseRefs.videos, entity.uid!);
  }
}
