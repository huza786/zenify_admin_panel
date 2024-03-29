enum ProductState { newProduct, saleProduct, nullProduct, outOfStock }

class Product {
  String productId = ''; // New field for product ID
  List<String> productImages = [];
  List<String> tags = [];
  String category = '';
  String subCategories = '';
  String title = '';
  String subTitle = '';
  double originalPrice = 0;
  double salePrice = 0;
  bool favoriteOrNot = false;
  ProductState productStatus = ProductState.nullProduct;
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
    this.favoriteOrNot = false,
    this.productStatus = ProductState.newProduct,
    required this.companyName,
    required this.description,
  });

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      productId: map['productId'],
      productImages: List<String>.from(map['productImages']),
      tags: List<String>.from(map['tags']),
      category: map['category'],
      subCategories: map['subCategories'],
      title: map['title'],
      subTitle: map['subTitle'],
      originalPrice: map['originalPrice'],
      salePrice: map['salePrice'],
      favoriteOrNot: map['favoriteOrNot'],
      productStatus: _parseProductState(map['newOrNot']),
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
//instead of storing reviews list in the product model 
//we will store reviews in databse doc 
//when reviews will be added ie when it will be purchased and saved to database
