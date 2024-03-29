import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zenify_admin_panel/firebase_services/firebase_product_provider.dart';
import 'package:zenify_admin_panel/firebase_services/stream_services/stream_services.dart';
import 'package:zenify_admin_panel/main.dart';
import 'package:zenify_admin_panel/models/product_model.dart';

import 'dart:async';

import 'package:zenify_admin_panel/utils/app_routes.dart';
import 'package:zenify_admin_panel/view/dashboard/admin_vendor/components/modifyProduct.dart';

class EditProductPage extends StatefulWidget {
  const EditProductPage({Key? key}) : super(key: key);

  @override
  State<EditProductPage> createState() => _EditProductPageState();
}

class _EditProductPageState extends State<EditProductPage> {
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    // Start the timer when the widget is initialized
    _timer = Timer(const Duration(seconds: 3), _showNoProductsMessage);
  }

  @override
  void dispose() {
    _timer.cancel(); // Cancel the timer when the widget is disposed
    super.dispose();
  }

  void _showNoProductsMessage() {
    setState(() {
      // Set state to show no products message
      _timer.cancel(); // Cancel the timer when showing the message
    });
  }

  ProductStream stream = ProductStream();

  @override
  Widget build(BuildContext context) {
    // final productList = context.watch<List<Product>?>();
    final firebaseProductProv = Provider.of<FirebaseProductProvider>(context);

    return StreamProvider.value(
      value: ProductStream().stream,
      initialData: null,
      child: Consumer<List<Product>?>(
        builder: (context, productList, child) {
          if (productList == null) {
            // If productList is null, it means the data is still loading
            return const Center(
              child: CircularProgressIndicator(), // Show a loading indicator
            );
          }

          if (productList.isEmpty) {
            // If productList is empty, display no products message after 3 seconds
            return Center(
              child: FutureBuilder(
                future: Future.delayed(const Duration(seconds: 3)),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else {
                    return const Text(
                      'No products available.',
                      style: TextStyle(fontSize: 18),
                    );
                  }
                },
              ),
            );
          }

          // If productList contains data, render the list of products
          return SizedBox(
            width: 500,
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width / 3,
                    ),
                    child:
                        //stream of products being shown
                        ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: productList.length,
                      itemBuilder: (context, index) {
                        final product = productList[index];
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: () {
                              //Heading the product to a card where
                              // the vendor can incorporate the changes
                              //in the product and then publish it
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //       builder: (context) =>
                              //           ModifyProducts(id: product.productId)),
                              // );
                              Navigator.pushNamed(
                                  context, AppRoutes.modifyProduct,
                                  arguments: product.productId);
                              firebaseProductProv
                                  .initModificationProcess(product);
                            },
                            child: Container(
                                height: 300,
                                width: 500,
                                decoration: BoxDecoration(
                                    color: MyAppColors.darkBlue,
                                    borderRadius: BorderRadius.circular(16)),
                                child: Stack(
                                  children: [
                                    Positioned(
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(16)),
                                        height: 180,
                                        width: 300,
                                        child: Image.network(
                                          product.productImages[0],
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      top: 190,
                                      left: 10,
                                      child: Text(
                                        product.title,
                                        style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      top: 210,
                                      left: 10,
                                      child: Text(
                                        product.subTitle,
                                      ),
                                    ),
                                    Positioned(
                                      top: 190,
                                      left: 190,
                                      child: Text(
                                        "${product.originalPrice.toString()}\$",
                                      ),
                                    ),
                                  ],
                                )),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
