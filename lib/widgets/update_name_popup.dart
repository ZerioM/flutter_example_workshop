import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UpdateNamePopup extends StatelessWidget {

  int index = -1;
  String itemTitle = "";
  final Function updateElement;

  final TextEditingController textController = TextEditingController();

  UpdateNamePopup({required this.index, required this.itemTitle, required this.updateElement});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Update " + itemTitle),
      content:
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: textController,
              decoration: InputDecoration(hintText: itemTitle),
              onSubmitted: (String value) => closePopup(value, context),
            )
          ],
        ),
      actions: [
        TextButton(
          onPressed: () => closePopup(textController.text, context),
          child: const Text("Save")
        )
      ]
    );
  }

  closePopup(newTitle, context) {
    updateElement(index, newTitle);
    Navigator.of(context).pop();
  }

}