import 'dart:math';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:zenify_admin_panel/models/product_model.dart';

class FirebaseProductProvider with ChangeNotifier {
  TextEditingController titleController = TextEditingController();
  TextEditingController subtitleController = TextEditingController();
  TextEditingController originalPriceController = TextEditingController();
  TextEditingController companyNameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController salepriceController = TextEditingController();
  List<Uint8List>? fromPicker;
  Future<void> selectImage() async {
    fromPicker = await ImagePickerWeb.getMultiImagesAsBytes();
    // ignore: avoid_print
    print(fromPicker!.length.toString());
    notifyListeners();
  }

  //this function will allow you to get all info of selected product in
  ////product card so that vendor can modify it  later on
  void initModificationProcess(Product product) {
    titleController.text = product.title;
    descriptionController.text = product.description;
    subtitleController.text = product.subTitle;
    // selectedCategory = product.category;
    // // await getSubcategoriesForCategory(selectedCategory);
    // selectedSubCat = product.subCategories;
    originalPriceController.text = product.originalPrice.toString();
    if (product.salePrice != 0) {
      salepriceController.text = product.salePrice.toString();
    }
    companyNameController.text = product.companyName;
    selectedTags.clear();
    selectedTags.addAll(product.tags);
    downloadUrls.clear();
    downloadUrls.addAll(product.productImages);
    //TODO:show selected pics
  }

  //https://stackoverflow.com/questions/57559489/flutter-provider-in-initstate
  //why can i not call provider in init state is solved by using its constructor
  //constructor of this class
  FirebaseProductProvider() {
    getCategory();
  }
  List<String> downloadUrls = [];
  void removedownloadURL(String downloadurl) {
    downloadUrls.remove(downloadurl);
    notifyListeners();
  }

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
    availibleSubCategory = [];
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
    // getSubcategoriesForCategory(category);
    notifyListeners();
  }

  String selectedSubCat = 'Sub Category';
  void selectSubCategoryItem(String Subcategory) {
    selectedSubCat = Subcategory;
    notifyListeners();
  }
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
    if (imagesList!.isNotEmpty) {
      // Use asMap to iterate over the list with indices
      await Future.wait(imagesList
          .asMap()
          .entries
          .skip(1)
          .map((entry) => uploadSingleImage(entry.value)));
      print(downloadUrls.toString());
    }
  }

//hovering on image will show select image or no image selected
  bool _onHover = false;

  bool get onHover => _onHover;

  set onHover(bool value) {
    _onHover = value;
    notifyListeners();
  }

  //tags customselect
  TextEditingController textEditingController = TextEditingController();
//it will give suggestions based on the people entered in search bar
  List<String> tagsSuggestions = [];
  List<String> returnSuggestions() {
    return tags
        .where((tag) => tag
            .toLowerCase()
            .contains(textEditingController.text.toLowerCase()))
        .toList();
  }

//List of avalible tags
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
  List<String> selectedTags = [];
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

  Future<void> uploadproduct(BuildContext context) async {
    final ref = await FirebaseFirestore.instance.collection('Products');
    String docId = ref.doc().id;
    // String orgPrice= originalPriceController.text;
    if (fromPicker == null) {
      const snackbar = SnackBar(content: Text('Please select images'));
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
      return;
    } else {
      await uploadListImages(fromPicker);
    }

    Product product = Product(
        productId: docId,
        productImages: downloadUrls,
        tags: selectedTags,
        category: selectedCategory,
        subCategories: selectedSubCat,
        title: titleController.text,
        subTitle: subtitleController.text,
        originalPrice: int.tryParse(originalPriceController.text)!.toDouble(),
        salePrice: 0,
        companyName: companyNameController.text,
        description: descriptionController.text);

    if (product.productId.isEmpty) {
      const snackbar = SnackBar(content: Text('Product ID is required'));
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
      return;
    }

    if (product.productImages.isEmpty) {
      const snackbar = SnackBar(content: Text('Product image is required'));
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
      return;
    }

    if (product.tags.isEmpty) {
      const snackbar = SnackBar(content: Text('Tags are required'));
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
      return;
    }

    if (product.category.isEmpty) {
      const snackbar = SnackBar(content: Text('Category is required'));
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
      return;
    }

    if (product.subCategories.isEmpty) {
      const snackbar = SnackBar(content: Text('Subcategories are required'));
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
      return;
    }

    if (product.title.isEmpty) {
      const snackbar = SnackBar(content: Text('Title is required'));
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
      return;
    }

    if (product.subTitle.isEmpty) {
      const snackbar = SnackBar(content: Text('Subtitle is required'));
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
      return;
    }

    if (product.companyName.isEmpty) {
      const snackbar = SnackBar(content: Text('Company name is required'));
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
      return;
    }

    if (product.description.isEmpty) {
      const snackbar = SnackBar(content: Text('Description is required'));
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
      return;
    }
//https://stackoverflow.com/questions/74664205/anyway-to-save-doc-id-as-a-string-in-firebase-for-specific-user
// If all fields are filled, proceed with adding the product
    try {
      ref.doc(docId).set(product.toMap());
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            e.toString(),
          ),
        ),
      );
    }

    // Map<String, dynamic> mappedProduct = product.toMap();
    // print(mappedProduct.toString());
  }
}
