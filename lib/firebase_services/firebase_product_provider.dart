import 'dart:math';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class FirebaseProductProvider with ChangeNotifier {
  //https://stackoverflow.com/questions/57559489/flutter-provider-in-initstate
  //why can i not call provider in init state
  //constructor of this class
  FirebaseProductProvider() {
    getCategory();
  }
  List<String> downloadUrls = [];
  final List<String> _categoryList = [];
  List<String> get categoryList => _categoryList;

  //method to get category
  void getCategory() async {
    try {
      final db = FirebaseFirestore.instance.collection('utils');
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await db.get();
      List<String> categories =
          querySnapshot.docs.map((doc) => doc.id).toList();

      // Check if the default value 'Category' is already present
      if (!categories.contains('Category')) {
        categories.insert(0, 'Category'); // Insert 'Category' at the beginning
      }

      _categoryList.addAll(categories);
      print(categories);
    } catch (error) {
      print('Error fetching categories: $error');
    }
    notifyListeners();
  }

  // Other properties and methods...

  List<String> availibleSubCategory = [];
  // Method to get subcategories for a category
  Future<List<String>> getSubcategoriesForCategory(String categoryName) async {
    try {
      final categoryRef =
          FirebaseFirestore.instance.collection('utils').doc(categoryName);

      DocumentSnapshot<Map<String, dynamic>> categorySnapshot =
          await categoryRef.get();

      if (categorySnapshot.exists) {
        List<dynamic> subCategories =
            categorySnapshot.data()?['subCategory'] ?? [];
        if (!availibleSubCategory.contains('Sub Category')) {
          availibleSubCategory.insert(0, 'Sub Category');
        }
        availibleSubCategory.addAll(List<String>.from(subCategories));
        notifyListeners();
        print(availibleSubCategory);

        return List<String>.from(subCategories);
      } else {
        // Handle case when category document doesn't exist
        print('Category document does not exist');
        return [];
      }
    } catch (error) {
      print('Error fetching subcategories for $categoryName: $error');
      return [];
    }
  }

//it is the method that changes selected category in dropdown
  String selectedCategory = 'Category';
  void selectCategoryItem(String category) {
    selectedCategory = category;
    notifyListeners();
  }

  String selectedSubCat = 'Sub Category';
  void selectSubCategoryItem(String Subcategory) {
    selectedSubCat = Subcategory;
    notifyListeners();
  }
  //TODO: make logic to save sub categories
  // void selectCategoryItem(String category) {
  //   selectedCategory = category;
  //   notifyListeners();
  // }
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

  //tags customselect
  TextEditingController textEditingController = TextEditingController();

  List<String> returnSuggestions() {
    return tags
        .where((tag) => tag
            .toLowerCase()
            .contains(textEditingController.text.toLowerCase()))
        .toList();
  }

  List<String> tags = [
    "Tops",
    "Dresses",
    "Bottoms",
    "Outerwear",
    "Activewear",
    "Underwear",
    "Sleepwear",
    "Accessories",
    "Footwear",
  ];
  List selectedTags = [];
  addSelectedtag(String tag) {
    selectedTags.add(tag);
    notifyListeners();
  }

  removeSelectedtag(String tag) {
    selectedTags.remove(tag);
    notifyListeners();
  }

  clearSearchBar() {
    textEditingController.clear();
    notifyListeners();
  }

  changed() {
    notifyListeners();
  }
}
