import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddProduct extends StatelessWidget {
  const AddProduct({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController testController = TextEditingController();
    final db = FirebaseFirestore.instance;
    final city = <String, String>{
      "name": "Los Angeles",
      "state": "CA",
      "country": "USA"
    };

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            width: 550,
            child: TextFormField(
              controller: testController,
            ),
          ),
        ),
        ElevatedButton(
            onPressed: () {
              db
                  .collection("cities")
                  .add(city)
                  .then((value) => print("Document added with ID: ${value.id}"))
                  .catchError(
                      (error) => print("Error adding document: $error"));
              //TODO:add firebase post method
            },
            child: Text('Post'))
      ],
    );
  }
}
