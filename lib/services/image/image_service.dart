import 'dart:io';

import 'package:chat_app/model/images.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

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
      File file,) async {

    isUploading = true;
    notifyListeners();
    //
    // final ImagePicker picker = ImagePicker();
    // final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    //
    // if (image == null) throw Exception();
    //
    // File file = File(image.path);

    try {
      String filePath = generateImageRef(imageDto.id, imageDto.type);
      await _firebaseStorage.ref(filePath).putFile(file);

      var downloadUrl = await _firebaseStorage.ref(filePath).getDownloadURL();
      notifyListeners();
      return downloadUrl;
    } catch (e) {
      throw Exception("Error while uploading image $e");
    }
  }

  String generateImageRef(String id, ImageType type) {
    return "$UPLOAD_IMAGE_REF/$type/$id.png";
  }
}
