import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:zenify_admin_panel/models/product_model.dart';

class ProductStream {
  Stream<List<Product>?> get stream {
    final db = FirebaseFirestore.instance.collection('Products');
    final stream = db.snapshots().map(
          (snapshot) => snapshot.docs
              .map(
                (doc) => Product.fromMap(
                  doc.data(),
                ),
              )
              .toList(),
        );
    print(stream.first.toString());
    return stream;
  }

  Stream<Product> singleStream(id) {
    final db = FirebaseFirestore.instance.collection('Products');
    final stream = db
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .where((element) => element.data()['productId'] == id)
              .single,
        )
        .map((event) => Product.fromMap(event.data()));
    print(stream.first.toString());
    return stream;
  }
}
