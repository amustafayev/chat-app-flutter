import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class UserImageStorage {
  //Firebase storage
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  // loading status
  bool isLoading = false;

  //uploading status
  bool isUploading = false;

  //GETTERS

  //Read Images

  Future<void> fetchImage() async {
    //start loading
    isLoading = true;
  }

  //Delete images

  //Delete

  //Upload images
}
