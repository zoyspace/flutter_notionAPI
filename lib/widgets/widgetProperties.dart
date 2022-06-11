import 'package:flutter/material.dart';

Widget widgetProperties(String name, String type) {
  final myTextController = TextEditingController();

  switchlabelText() {
    switch (type) {
      case 'date':
        return 'date1';

      case 'checkbox':
        return 'checkbox';

      default:
        return 'nothing';
    }
  }

  return Column(children: [
    Row(
      children: [
        Text(
          name,
        ),
        const SizedBox(
          width: 20,
        ),
        Text(type),
      ],
    ),
    TextFormField(
        controller: myTextController,
        decoration: const InputDecoration(
            border: UnderlineInputBorder(),
            // labelText: 'a',
            labelText: 'Enter your type')),
  ]);
}
