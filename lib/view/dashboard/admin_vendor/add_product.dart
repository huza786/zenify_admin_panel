import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zenify_admin_panel/firebase_services/firebase_product_provider.dart';
import 'package:zenify_admin_panel/main.dart';
import 'package:zenify_admin_panel/view/dashboard/admin_vendor/components/tags_field_custom.dart';
import 'package:zenify_admin_panel/view/dashboard/admin_vendor/components/textform_custom.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({Key? key}) : super(key: key);

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    final firebaseProductProv = Provider.of<FirebaseProductProvider>(context);
    return Expanded(
      child: SingleChildScrollView(
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          const Text(
            "Add New Product",
            style: TextStyle(fontSize: 40, fontWeight: FontWeight.w600),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      //title
                      CustomTextForm(
                          hint: 'Title',
                          controller: firebaseProductProv.titleController),
                      //Subtitle
                      CustomTextForm(
                          hint: 'Subtitle',
                          controller: firebaseProductProv.subtitleController),
                    ],
                  ),
                  Row(
                    children: [
                      //selected category dropdown
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0),
                            border: Border.all(
                              width: 1.0,
                              color: MyAppColors
                                  .primaryred, // Customize border color as needed
                            ),
                          ),
                          height: 60,
                          width: 138,
                          child: Center(
                            child: DropdownButtonFormField(
                              decoration: const InputDecoration(
                                hintText:
                                    '', // Set empty hintText to hide default text in dropdown
                                border:
                                    InputBorder.none, // Remove default border
                                contentPadding:
                                    EdgeInsets.zero, // Adjust content padding
                                isDense:
                                    true, // Reduce the height of the input field
                                alignLabelWithHint:
                                    true, // Align the label with the hint text
                              ),
                              value: firebaseProductProv.selectedCategory,
                              items: firebaseProductProv.categoryList
                                  .map(
                                    (size) => DropdownMenuItem<String>(
                                      value: size,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 4, bottom: 4),
                                        child: Text(
                                          size,
                                          style: const TextStyle(fontSize: 14),
                                        ),
                                      ),
                                    ),
                                  )
                                  .toList(),
                              onChanged: (size) {
                                firebaseProductProv
                                    .selectCategoryItem(size.toString());
                                firebaseProductProv
                                    .getSubcategoriesForCategory(size!);
                              },
                            ),
                          ),
                        ),
                      ),
                      //Selected Subcategory dropdown
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0),
                            border: Border.all(
                              width: 1.0,
                              color: MyAppColors
                                  .primaryred, // Customize border color as needed
                            ),
                          ),
                          height: 60,
                          width: 138,
                          child: Center(
                            child: DropdownButtonFormField(
                              decoration: const InputDecoration(
                                hintText:
                                    'Sub Category', // Set empty hintText to hide default text in dropdown
                                border:
                                    InputBorder.none, // Remove default border
                                contentPadding:
                                    EdgeInsets.zero, // Adjust content padding
                                isDense:
                                    true, // Reduce the height of the input field
                                alignLabelWithHint:
                                    true, // Align the label with the hint text
                              ),
                              value: firebaseProductProv.selectedSubCat,
                              items: firebaseProductProv.availibleSubCategory
                                  .map(
                                    (size) => DropdownMenuItem<String>(
                                      value: size,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 4, bottom: 4),
                                        child: Text(
                                          size,
                                          style: const TextStyle(fontSize: 14),
                                        ),
                                      ),
                                    ),
                                  )
                                  .toList(),
                              onChanged: (size) {
                                firebaseProductProv
                                    .selectSubCategoryItem(size.toString());
                              },
                            ),
                          ),
                        ),
                      ),
                      //Price
                      CustomTextForm(
                          hint: 'Price',
                          controller:
                              firebaseProductProv.originalPriceController),
                    ],
                  ),
                  //Description field
                  Row(
                    children: [
                      //description
                      CustomTextForm(
                          hint: 'Description',
                          controller:
                              firebaseProductProv.descriptionController),

                      //companyname
                      CustomTextForm(
                          hint: 'companyname',
                          controller:
                              firebaseProductProv.companyNameController),
                    ],
                  ),
                  //Tags widget
                  TextFieldTagsCustom(),
                ],
              ),
              //Image Picker/Select
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onHover: (onHover) {
                    firebaseProductProv.onHover = onHover;
                  },
                  onTap: () async {
                    firebaseProductProv.selectImage();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: MyAppColors.primaryred,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(8)),
                    width: MediaQuery.of(context).size.width / 3,
                    height: 300,
                    child: Container(
                      color: MyAppColors.darkBlue,
                      child: firebaseProductProv.fromPicker != null
                          ? Wrap(
                              children: firebaseProductProv.fromPicker!
                                  .map((e) => SizedBox(
                                      height: 240,
                                      width: 240,
                                      child: Image.memory(e)))
                                  .toList(),
                            )
                          : Center(
                              child: Text(
                              firebaseProductProv.onHover
                                  ? "Select Image"
                                  : "No image selected",
                              style: const TextStyle(fontSize: 24),
                            )),
                    ),
                  ),
                ),
              ),
            ],
          ),

          //Upload Product button
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                  MyAppColors.primaryred,
                ),
              ),
              onPressed: () {
                firebaseProductProv.uploadproduct(context);
                firebaseProductProv
                    .uploadListImages(firebaseProductProv.fromPicker);
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
              child: const Text(
                'Upload Product',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ]),
      ),
    );
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