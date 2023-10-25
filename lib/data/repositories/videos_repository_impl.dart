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
  String? ownerId;

  @override
  Future<String?> getUserAnonymousId() async => ownerId ??= await firebaseDrive.signInAnonymously();

  @override
  Future<File?> getVideo({bool shouldRecord = false, int maxMinutes = 1}) async =>
      await filePickerDrive.getFile(fromCamera: shouldRecord, maxMinutes: maxMinutes);

  @override
  Future<SkyVideoResponseEntity> readEntities() async =>
      await firebaseDrive.readAllData(FirebaseRefs.videos).then((data) => SkyVideoResponseModel.fromJson(data));

  @override
  Future<bool> writeEntity(SkyVideoEntity entity) async {
    if (ownerId == null) await getUserAnonymousId();
    return await firebaseDrive.writeData(entity.toJson(ownerId!), FirebaseRefs.videos, entity.uid, false);
  }

  @override
  Future<String> uploadVideo(File file, String fileName) async {
    if (ownerId == null) await getUserAnonymousId();
    return await firebaseDrive.uploadVideo(file, "$ownerId/$fileName");
  }

  @override
  Future<bool> likeVideo(SkyVideoEntity entity) async {
    if (entity.ownerUid == null) return false;
    if (ownerId == null) await getUserAnonymousId();
    return await firebaseDrive.updateList('likes', ownerId!, FirebaseRefs.videos, entity.ownerUid!,
        shouldRemoveElement: true);
  }

  @override
  Future<bool> removeLikeVideo(SkyVideoEntity entity) async {
    if (entity.ownerUid == null) return false;
    if (ownerId == null) await getUserAnonymousId();
    return await firebaseDrive.updateList('likes', ownerId!, FirebaseRefs.videos, entity.ownerUid!,
        shouldRemoveElement: false);
  }
}
