import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zenify_admin_panel/firebase_services/firebase_product_provider.dart';
import 'package:zenify_admin_panel/main.dart';

class TextFieldTagsCustom extends StatefulWidget {
  TextFieldTagsCustom({super.key});

  @override
  State<TextFieldTagsCustom> createState() => _TextFieldTagsCustomState();
}

class _TextFieldTagsCustomState extends State<TextFieldTagsCustom> {
  @override
  Widget build(BuildContext context) {
    final firebaseProductProv = Provider.of<FirebaseProductProvider>(context);

    print('Entered text: ${firebaseProductProv.textEditingController.text}');

    print('Filtered tags: ${firebaseProductProv.returnSuggestions()}');
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
              color: MyAppColors.primaryred,
              width: 2,
              style: BorderStyle.solid)),
      width: 400,
      child: Column(
        children: [
          const Text('Add Tags'),
          TextFormField(
            decoration: const InputDecoration(
              border: InputBorder.none,
              hintText: "Enter Here",
            ),
            controller: firebaseProductProv.textEditingController,
            onChanged: (_) => firebaseProductProv.changed(),
            onFieldSubmitted: (value) {
              firebaseProductProv.addSelectedtag(value);
            },
          ),
          Stack(
            children: [
              //selected tags
              Wrap(
                children: firebaseProductProv.selectedTags
                    .map(
                      (tag) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Chip(
                          onDeleted: () {
                            firebaseProductProv.removeSelectedtag(tag);
                            print("deleted tag:$tag");
                            print(firebaseProductProv.selectedTags);
                          },
                          deleteIconColor: MyAppColors.primaryred,
                          deleteIcon: const Icon(
                            Icons.close,
                            color: MyAppColors.primaryred,
                          ),
                          label: Text(
                            tag,
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
              //simple container to hide below wigdet
              firebaseProductProv.textEditingController.text.isEmpty
                  ? Container(
                      width: 200,
                      color: Colors.black,
                    )
                  : const SizedBox.shrink(),

              firebaseProductProv.textEditingController.text.isNotEmpty
                  ? Wrap(
                      children: firebaseProductProv
                          .returnSuggestions()
                          .map(
                            (tag) => GestureDetector(
                              onTap: () {
                                //Search bar below
                                firebaseProductProv.addSelectedtag(tag);
                                print("added tag:$tag");
                                print(firebaseProductProv.selectedTags);

                                firebaseProductProv.clearSearchBar();
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Chip(
                                  // onDeleted: () {},
                                  // deleteIconColor: MyAppColors.primaryred,
                                  // deleteIcon: const Icon(
                                  //   Icons.close,
                                  //   color: MyAppColors.primaryred,
                                  // ),
                                  label: Text(
                                    tag,
                                  ),
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    )
                  : const SizedBox.shrink(),
            ],
          ),
        ],
      ),
    );
  }
}
