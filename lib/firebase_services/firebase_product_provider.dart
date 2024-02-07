import 'dart:math';
import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class FirebaseProductProvider with ChangeNotifier {
  List<String> downloadUrls = [];

  //TODO make a list of images to upload by getting a list of images that may be unit8list or other then upload them by making a function of
  //upload images by .map to the upload function to get the url too

  // Future<List<String>> uploadListimages(
  //     List<Uint8List>? fromPicker, String imgName) async {
  //   for (var i = 0; i < fromPicker!.length; i++) {
  //     uploadSingleImage(fromPicker[i], imgName, i);
  //   }
  // }

  // Future<String> uploadSingleImage(
  //     Uint8List image, String imgName, int index) async {
  //   try {
  //     final storageReference = FirebaseStorage.instance
  //         .ref()
  //         .child('productsImages/$imgName/$index');
  //   var ref=await  storageReference.putData(
  //       image,
  //     ).whenComplete(() => null);
  //     return ref.getDow
  //   } catch (e) {}
  // }
  Future<void> uploadSingleImage(Uint8List? image) async {
    var int2 = Random().nextInt(4294967295) + 3294967296;
    String url;
    try {
      final storageRef = FirebaseStorage.instance.ref().child(
            'ProductImage/$int2.jpg',
          );
      if (image != null) {
        await storageRef.putData(
          image,
          SettableMetadata(contentType: 'image/jpeg'),
        );
      }
      url = await storageRef.getDownloadURL();
      downloadUrls.add(url);
    } catch (e) {
      print(e);
    }
  }

  Future<void> uploadListImages(List<Uint8List>? imagesList) async {
    if (imagesList != null) {
      await Future.wait(imagesList.map((_image) => uploadSingleImage(_image)));
      print(downloadUrls.toString());
    }
  }
}
