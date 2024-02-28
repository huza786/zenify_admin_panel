import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zenify_admin_panel/firebase_services/firebase_product_provider.dart';
import 'package:zenify_admin_panel/firebase_services/stream_services/stream_services.dart';
import 'package:zenify_admin_panel/main.dart';
import 'package:zenify_admin_panel/models/product_model.dart';
import 'package:zenify_admin_panel/view/dashboard/admin_vendor/components/tags_field_custom.dart';
import 'package:zenify_admin_panel/view/dashboard/admin_vendor/components/textform_custom.dart';

class ModifyProducts extends StatefulWidget {
  final String id;
  const ModifyProducts({super.key, required this.id});

  @override
  State<ModifyProducts> createState() => _ModifyProductsState();
}

class _ModifyProductsState extends State<ModifyProducts> {
  // String? id;
  // late Product product;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // setid();
    // product = ModalRoute.of(context)!.settings.arguments as Product;
  }

  // setid() {
  //   id = ModalRoute.of(context)!.settings.arguments as String?;
  //   print(id);
  //   setState(() {});
  // }

  final db = FirebaseFirestore.instance;
  bool singleInit = true;

  @override
  Widget build(BuildContext context) {
    final firebaseProductProv = Provider.of<FirebaseProductProvider>(context);

    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
              // firebaseProductProv.dispose();
            },
            child: Icon(Icons.arrow_back_ios_new)),
        title: const Text(
          "Edit Product",
          style: TextStyle(fontSize: 40, fontWeight: FontWeight.w600),
        ),
      ),
      body: widget.id == null
          ? Center(child: CircularProgressIndicator())
          : StreamProvider.value(
              value: ProductStream().singleStream(widget.id),
              initialData: null,
              catchError: (context, error) => null,
              child: Consumer<Product?>(builder: (context, product, b) {
                if (product == null) {
                  return Center(child: CircularProgressIndicator());
                }
                if (singleInit) {
                  singleInit = false;
                }
                return SingleChildScrollView(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
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
                                        isNumberKeyboard: false,
                                        hint: 'Title',
                                        controller: firebaseProductProv
                                            .titleController),
                                    //Subtitle
                                    CustomTextForm(
                                        isNumberKeyboard: false,
                                        hint: 'Subtitle',
                                        controller: firebaseProductProv
                                            .subtitleController),
                                  ],
                                ),
                                Row(
                                  children: [
                                    //selected category dropdown
                                    Column(
                                      children: [
                                        Text("Previously Selected:" +
                                            product.category +
                                            "+" +
                                            product.subCategories),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5.0),
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
                                                decoration:
                                                    const InputDecoration(
                                                  hintText:
                                                      '', // Set empty hintText to hide default text in dropdown
                                                  border: InputBorder
                                                      .none, // Remove default border
                                                  contentPadding: EdgeInsets
                                                      .zero, // Adjust content padding
                                                  isDense:
                                                      true, // Reduce the height of the input field
                                                  alignLabelWithHint:
                                                      true, // Align the label with the hint text
                                                ),
                                                value: firebaseProductProv
                                                    .selectedCategory,
                                                items: firebaseProductProv
                                                    .categoryList
                                                    .map(
                                                      (size) =>
                                                          DropdownMenuItem<
                                                              String>(
                                                        value: size,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  left: 4,
                                                                  bottom: 4),
                                                          child: Text(
                                                            size,
                                                            style:
                                                                const TextStyle(
                                                                    fontSize:
                                                                        14),
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                    .toList(),
                                                onChanged: (size) {
                                                  firebaseProductProv
                                                      .selectCategoryItem(
                                                          size.toString());
                                                  if (firebaseProductProv
                                                          .selectedCategory !=
                                                      'Category') {
                                                    firebaseProductProv
                                                        .getSubcategoriesForCategory(
                                                            size!);
                                                  }
                                                },
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    //Selected Subcategory dropdown
                                    Padding(
                                      padding: const EdgeInsets.all(16),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5.0),
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
                                              border: InputBorder
                                                  .none, // Remove default border
                                              contentPadding: EdgeInsets
                                                  .zero, // Adjust content padding
                                              isDense:
                                                  true, // Reduce the height of the input field
                                              alignLabelWithHint:
                                                  true, // Align the label with the hint text
                                            ),
                                            value: firebaseProductProv
                                                .selectedSubCat,
                                            items: firebaseProductProv
                                                .availibleSubCategory
                                                .map(
                                                  (size) =>
                                                      DropdownMenuItem<String>(
                                                    value: size,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 4,
                                                              bottom: 4),
                                                      child: Text(
                                                        size,
                                                        style: const TextStyle(
                                                            fontSize: 14),
                                                      ),
                                                    ),
                                                  ),
                                                )
                                                .toList(),
                                            onChanged: (size) {
                                              firebaseProductProv
                                                  .selectSubCategoryItem(
                                                      size.toString());
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                    //Price
                                    CustomTextForm(
                                        isNumberKeyboard: true,
                                        hint: 'Price',
                                        controller: firebaseProductProv
                                            .originalPriceController),
                                  ],
                                ),
                                //Description field
                                Row(
                                  children: [
                                    //description
                                    CustomTextForm(
                                        isNumberKeyboard: false,
                                        hint: 'Description',
                                        controller: firebaseProductProv
                                            .descriptionController),

                                    //companyname
                                    CustomTextForm(
                                        isNumberKeyboard: false,
                                        hint: 'companyname',
                                        controller: firebaseProductProv
                                            .companyNameController),
                                  ],
                                ),
                                //Tags widget
                                TextFieldTagsCustom(),
                              ],
                            ),
                            // selectedimage
                            Padding(
                              padding: const EdgeInsets.all(8.0),
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
                                    child: Wrap(
                                      children: firebaseProductProv.downloadUrls
                                          .map((e) => Stack(
                                                children: [
                                                  Positioned(
                                                    left: 220,
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        firebaseProductProv
                                                            .removedownloadURL(
                                                                e);
                                                      },
                                                      child: Icon(
                                                        Icons.close,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                      height: 240,
                                                      width: 240,
                                                      child: Image.network(e)),
                                                ],
                                              ))
                                          .toList(),
                                    )),
                              ),
                            ),
                            // //Image Picker/Select
                            // Padding(
                            //   padding: const EdgeInsets.all(8.0),
                            //   child: InkWell(
                            //     onHover: (onHover) {
                            //       firebaseProductProv.onHover = onHover;
                            //     },
                            //     onTap: () async {
                            //       firebaseProductProv.selectImage();
                            //     },
                            //     child: Container(
                            //       decoration: BoxDecoration(
                            //           border: Border.all(
                            //             color: MyAppColors.primaryred,
                            //             width: 2,
                            //           ),
                            //           borderRadius: BorderRadius.circular(8)),
                            //       width: MediaQuery.of(context).size.width / 3,
                            //       height: 300,
                            //       child: Container(
                            //         color: MyAppColors.darkBlue,
                            //         child: firebaseProductProv.fromPicker != null
                            //             ? Wrap(
                            //                 children: firebaseProductProv.fromPicker!
                            //                     .map((e) => SizedBox(
                            //                         height: 240,
                            //                         width: 240,
                            //                         child: Image.memory(e)))
                            //                     .toList(),
                            //               )
                            //             : Center(
                            //                 child: Text(
                            //                   firebaseProductProv.onHover
                            //                       ? "Select Image"
                            //                       : "No image selected",
                            //                   style: const TextStyle(fontSize: 24),
                            //                 ),
                            //               ),
                            //       ),
                            //     ),
                            //   ),
                            // ),
                          ],
                        ),

                        //changes Product button
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                MyAppColors.primaryred,
                              ),
                            ),
                            onPressed: () {
                              firebaseProductProv.dispose();

                              ///TODO: create a function to save changes
                              // firebaseProductProv.uploadproduct(context);
                              // firebaseProductProv
                              //     .uploadListImages(firebaseProductProv.fromPicker);
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
                              'Save Changes',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ]),
                );
              }),
            ),
    );
  }
}
