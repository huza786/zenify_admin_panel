import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:provider/provider.dart';
import 'package:zenify_admin_panel/firebase_services/firebase_product_provider.dart';
import 'package:zenify_admin_panel/main.dart';
import 'package:zenify_admin_panel/view/dashboard/admin_vendor/components/textform_custom.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({Key? key}) : super(key: key);

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  List<Uint8List>? fromPicker;
  TextEditingController titleController = TextEditingController();
  TextEditingController subtitleController = TextEditingController();
  TextEditingController originalPriceController = TextEditingController();
  TextEditingController companyNameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  final db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    final firebaseProductProv = Provider.of<FirebaseProductProvider>(context);
    return Column(children: [
      Text(
        "Add New Product",
        style: TextStyle(fontSize: 40, fontWeight: FontWeight.w600),
      ),
      Row(
        children: [
          //title
          CustomTextForm(hint: 'Title', controller: titleController),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.0),
              border: Border.all(
                width: 1.0,
                color:
                    MyAppColors.primaryred, // Customize border color as needed
              ),
            ),
            height: 40,
            width: 138,
            child: Center(
              child: DropdownButtonFormField(
                decoration: const InputDecoration(
                  hintText:
                      '', // Set empty hintText to hide default text in dropdown
                  border: InputBorder.none, // Remove default border
                  contentPadding: EdgeInsets.zero, // Adjust content padding
                  isDense: true, // Reduce the height of the input field
                  alignLabelWithHint:
                      true, // Align the label with the hint text
                ),
                value: firebaseProductProv.selectedCategory,
                items: firebaseProductProv.categoryList
                    .map(
                      (size) => DropdownMenuItem<String>(
                        value: size,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 4, bottom: 4),
                          child: Text(
                            size,
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                      ),
                    )
                    .toList(),
                onChanged: (size) {
                  firebaseProductProv.selectCategoryItem(size.toString());
                },
              ),
            ),
          ),
          //Subtitle
        ],
      )
    ]);
  }
}

/** [
        //Title
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
                  ? Wrap(
                      children: fromPicker!
                          .map((e) => SizedBox(
                              height: 240, width: 240, child: Image.memory(e)))
                          .toList(),
                    )
                  : Center(child: Text("No image selected")),
            ),
          ),
        ),
        ElevatedButton(
          onPressed: () async {
            fromPicker = await ImagePickerWeb.getMultiImagesAsBytes();
            setState(() {});
          },
          child: Text('Select image'),
        ),
        ElevatedButton(
          onPressed: () async {
            firebaseProductProv.uploadListImages(fromPicker);
            // final imageRef = storageRef.child('images/');
            // try {
            //   await imageRef.putData(
            //     Uint8List.fromList(fromPicker!),
            //     SettableMetadata(contentType: 'image/jpeg'),
            //   );
            //   final url = await imageRef.getDownloadURL();
            //   print(url.toString());
            // } catch (e) {
            //   print(e);
            // }
          },
          child: Text('upload image'),
        )
      ],* */
      


//Category Firebase addition code
    // final catRef = db.collection('utils');

    //           for (var i = 0; i < categories.length; i++) {
    //             var categoryValue = categories[i]['category'];
    //             if (categoryValue != null) {
    //               String categoryName = categoryValue as String;
    //               db.collection('utils').doc(categoryName).set(categories[i]);
    //             }
    //           }