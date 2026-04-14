import 'dart:io';

import 'package:chat_app/model/images.dart';
import 'package:chat_app/services/image/image_service.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePicture extends StatelessWidget {
  ProfilePicture({
    super.key,
    this.imageUrl,
    required this.userId,
    required this.onImageUpload,
  });

  final String? imageUrl;
  final ImageService _imageService = ImageService();
  final String userId;
  final Function(String, String) onImageUpload;

  @override
  Widget build(BuildContext context) {
    if (imageUrl != null) {
      return GestureDetector(
        onTap: uploadImage,
        child: CircleAvatar(
          backgroundImage: NetworkImage(imageUrl!),
          radius: 50,
        ),
      );
    }

    return GestureDetector(
        onTap: uploadImage,
        child: CircleAvatar(radius: 50, child: Icon(Icons.person)));
  }

  void uploadImage() {
    print("Upload image");
    final picker = ImagePicker();
    picker.pickImage(source: ImageSource.gallery).then((image) {
      if (image == null) {
        return;
      }
      uploadImageToFirebase(image.path);
    });
  }

  void uploadImageToFirebase(String imagePath) {
    // Upload the image to Firebase Storage
    _imageService
        .uploadImage(
          LightImageDto(ImageType.userProfile, userId),
          File(imagePath),
        )
        .then((downloadUrl) {
          onImageUpload(userId, downloadUrl);
        });

  }
}
