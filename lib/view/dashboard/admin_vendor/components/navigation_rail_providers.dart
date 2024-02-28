import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:zenify_admin_panel/models/product_model.dart';

class NavigationRailProvider with ChangeNotifier {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  int _selectedIndex = 1;
  get selectedIndex => _selectedIndex;
  void selectindex(int index) {
    _selectedIndex = index;
    notifyListeners();
  }

  Stream<List<Product>> get productStream {
    //stream provider provides data inside app at the root widget level
    //and help to manage data easily through app
    //the below code provides a list of products from  firebase using stream builder
    return firestore.collection('Products').snapshots().map(
          (snapshot) => snapshot.docs
              .map(
                (doc) => Product.fromMap(
                  doc.data(),
                ),
              )
              .toList(),
        );
  }
}
