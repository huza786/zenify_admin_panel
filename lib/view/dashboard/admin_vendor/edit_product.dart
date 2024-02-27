import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zenify_admin_panel/models/product_model.dart';

import 'dart:async';

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
    _timer = Timer(Duration(seconds: 3), _showNoProductsMessage);
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

  @override
  Widget build(BuildContext context) {
    final List<Product>? productList = Provider.of<List<Product>?>(context);

    if (productList == null) {
      // If productList is null, it means the data is still loading
      return Center(
        child: CircularProgressIndicator(), // Show a loading indicator
      );
    }

    if (productList.isEmpty) {
      // If productList is empty, display no products message after 3 seconds
      return Center(
        child: FutureBuilder(
          future: Future.delayed(Duration(seconds: 3)),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else {
              return Text(
                'No products available.',
                style: TextStyle(fontSize: 18),
              );
            }
          },
        ),
      );
    }

    // If productList contains data, render the list of products
    return Container(
      width: 500,
      child: Column(
        children: [
          Expanded(
            child: Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width / 3,
              ),
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: productList.length,
                itemBuilder: (context, index) {
                  final product = productList[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: 35,
                      width: 250,
                      child: ListTile(
                        title: Text(product.productId),
                        subtitle: Text(product.subTitle),

                        // Display more product details as needed
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
