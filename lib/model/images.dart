import 'package:cloud_firestore/cloud_firestore.dart';

class ImageDetails {
  final String downloadUrl;
  final ImageType imageType;
  final Timestamp uploadDate;
  final String uid;

  ImageDetails({
    required this.downloadUrl,
    required this.imageType,
    required this.uploadDate,
    required this.uid,
  });
}

class LightImageDto {
  final String id;
  final ImageType type;
  final String userId;

  LightImageDto(this.id, this.type, this.userId);
}

enum ImageType { userProfile, userBackground }
