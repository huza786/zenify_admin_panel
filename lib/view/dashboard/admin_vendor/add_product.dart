import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:zenify_admin_panel/main.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({Key? key}) : super(key: key);

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  Uint8List? fromPicker;
  TextEditingController testController = TextEditingController();
  final db = FirebaseFirestore.instance;
  final storageRef = FirebaseStorage.instance.ref();
  final city = <String, String>{
    "name": "Los Angeles",
    "state": "CA",
    "country": "USA",
  };

  @override
  Widget build(BuildContext context) {
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
                .catchError((error) => print("Error adding document: $error"));
            // TODO: add firebase post method
          },
          child: Text('Post'),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            width: 550,
            height: 550,
            child: Container(
              color: MyAppColors.darkBlue,
              child: fromPicker != null
                  ? Image.memory(fromPicker!)
                  : Center(child: Text("No image selected")),
            ),
          ),
        ),
        ElevatedButton(
          onPressed: () async {
            fromPicker = await ImagePickerWeb.getImageAsBytes();
            setState(() {});
          },
          child: Text('Select image'),
        ),
        ElevatedButton(
          onPressed: () async {
            final imageRef = storageRef.child('images/');
            try {
              await imageRef.putData(
                Uint8List.fromList(fromPicker!),
                SettableMetadata(contentType: 'image/jpeg'),
              );
              final url = imageRef.getDownloadURL();
              print(url.toString());
            } catch (e) {
              print(e);
            }
          },
          child: Text('upload image'),
        )
      ],
    );
  }
}
