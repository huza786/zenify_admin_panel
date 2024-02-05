import 'package:zenify_admin_panel/models/review_model.dart';

enum ProductState { newProduct, saleProduct, nullProduct, outOfStock }

class Product {
  String productId = ''; // New field for product ID
  List<String> productImages = [];
  List<String> tags = [];
  String category = '';
  List<String> subCategories = [];
  String title = '';
  String subTitle = '';
  double originalPrice = 0;
  double salePrice = 0;
  bool favoriteOrNot = false;
  ProductState productStatus = ProductState.nullProduct;
  double initRating = 0;
  String companyName = '';
  String description = '';

  Product({
    required this.productId,
    required this.productImages,
    required this.tags,
    required this.category,
    required this.subCategories,
    required this.title,
    required this.subTitle,
    required this.originalPrice,
    required this.salePrice,
    required this.favoriteOrNot,
    required this.productStatus,
    required this.initRating,
    required this.companyName,
    required this.description,
  });

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      productId: map['productId'],
      productImages: List<String>.from(map['productImages']),
      tags: List<String>.from(map['tags']),
      category: map['category'],
      subCategories: List<String>.from(map['subCategories']),
      title: map['title'],
      subTitle: map['subTitle'],
      originalPrice: map['originalPrice'],
      salePrice: map['salePrice'],
      favoriteOrNot: map['favoriteOrNot'],
      productStatus: _parseProductState(map['newOrNot']),
      initRating: map['initRating'],
      companyName: map['companyName'],
      description: map['description'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'productId': productId,
      'productImages': productImages,
      'tags': tags,
      'category': category,
      'subCategories': subCategories,
      'title': title,
      'subTitle': subTitle,
      'originalPrice': originalPrice,
      'salePrice': salePrice,
      'favoriteOrNot': favoriteOrNot,
      'newOrNot': _serializeProductState(productStatus),
      'initRating': initRating,
      'companyName': companyName,
      'description': description,
    };
  }

  static String _serializeProductState(ProductState state) {
    return state.toString().split('.').last;
  }

  static ProductState _parseProductState(String? stateString) {
    if (stateString == 'newProduct') {
      return ProductState.newProduct;
    } else if (stateString == 'saleProduct') {
      return ProductState.saleProduct;
    } else if (stateString == 'outOfStock') {
      return ProductState.outOfStock;
    } else {
      return ProductState.nullProduct;
    }
  }
}
//
