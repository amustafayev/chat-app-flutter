import 'dart:io';

import 'package:chat_app/model/images.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

/*
Different services will use this service to upload and download images
 */

class ImageService with ChangeNotifier {
  static String UPLOAD_IMAGE_REF = "uploaded_images";

  //Firebase storage
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  // loading status
  bool isLoading = false;

  //uploading status
  bool isUploading = false;

  Future<String> uploadImage(
      LightImageDto imageDto,
      File file,
      ) async {
    isUploading = true;
    notifyListeners();

    try {
      final filePath = generateImageRef(imageDto.userId, imageDto.type);
      final ref = _firebaseStorage.ref().child(filePath);

      print("Uploading to: $filePath");
      print("Bucket: ${_firebaseStorage.bucket}");

      final snapshot = await ref.putFile(file);
      final downloadUrl = await snapshot.ref.getDownloadURL();

      return downloadUrl;
    } on FirebaseException catch (e) {
      print("Firebase upload error: code=${e.code}, message=${e.message}");
      throw Exception("Error while uploading image: ${e.code} ${e.message}");
    } finally {
      isUploading = false;
      notifyListeners();
    }
  }

  String generateImageRef(String userId, ImageType type) {
    final id = const Uuid().v4();
    return "$UPLOAD_IMAGE_REF/$userId/${type.name}/$id.png";
  }

}
