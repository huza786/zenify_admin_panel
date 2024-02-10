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

  TextEditingController textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    print('Entered text: ${textEditingController.text}');
    final filteredTags = tags
        .where((tag) => tag
            .toLowerCase()
            .contains(textEditingController.text.toLowerCase()))
        .toList();
    print('Filtered tags: $filteredTags');
    return Container(
      width: 400,
      child: Column(
        children: [
          Text('Add Tags'),
          TextFormField(
            controller: textEditingController,
            onChanged: (_) => setState(() {}),
          ),
          Stack(
            children: [
              // Wrap(
              //   children: tags
              //       .map(
              //         (tag) => Chip(
              //           deleteIconColor: MyAppColors.primaryred,
              //           deleteIcon: const Icon(
              //             Icons.close,
              //             color: MyAppColors.primaryred,
              //           ),
              //           label: Text(
              //             tag,
              //           ),
              //         ),
              //       )
              //       .toList(),
              // ),
              textEditingController.text.isNotEmpty
                  ? Wrap(
                      children: filteredTags
                          .map(
                            (tag) => Chip(
                              onDeleted: () {},
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
                    )
                  : SizedBox.shrink(),
            ],
          ),
        ],
      ),
    );
  }
}
