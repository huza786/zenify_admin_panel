import 'package:flutter/material.dart';
import 'package:zenify_admin_panel/main.dart';

class TextFieldTagsCustom extends StatefulWidget {
  TextFieldTagsCustom({super.key});

  @override
  State<TextFieldTagsCustom> createState() => _TextFieldTagsCustomState();
}

class _TextFieldTagsCustomState extends State<TextFieldTagsCustom> {
  List<String> tags = [
    "Tops",
    "Dresses",
    "Bottoms",
    "Outerwear",
    "Activewear",
    "Underwear",
    "Sleepwear",
    "Accessories",
    "Footwear",
  ];

  @override
  Widget build(BuildContext context) {
    TextEditingController textEditingController = TextEditingController();
    return Container(
      width: 400,
      child: Column(
        children: [
          Text('Add Tags'),
          TextFormField(
            controller: textEditingController,
          ),
          Stack(
            children: [
              Wrap(
                children: tags
                    .map(
                      (tag) => Chip(
                        deleteIconColor: MyAppColors.primaryred,
                        deleteIcon: const Icon(
                          Icons.close,
                          color: MyAppColors.primaryred,
                        ),
                        label: Text(
                          tag,
                        ),
                      ),
                    )
                    .toList(),
              ),
              textEditingController.text.isNotEmpty
                  ? ListView.builder(
                      shrinkWrap: true,
                      itemCount: tags
                          .where((element) => textEditingController.text
                              .toLowerCase()
                              .contains(element.toLowerCase()))
                          .length,
                      itemBuilder: (context, index) {
                        return Wrap(
                          children: tags
                              .where((element) => textEditingController.text
                                  .toLowerCase()
                                  .contains(element.toLowerCase()))
                              .map(
                                (tag) => Chip(
                                  deleteIconColor: MyAppColors.primaryred,
                                  deleteIcon: const Icon(
                                    Icons.close,
                                    color: MyAppColors.primaryred,
                                  ),
                                  label: Text(
                                    tag,
                                  ),
                                ),
                              )
                              .toList(),
                        );
                      })
                  : SizedBox(),
            ],
          ),
        ],
      ),
    );
  }
}
