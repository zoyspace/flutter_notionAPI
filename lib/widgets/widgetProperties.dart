import 'package:flutter/material.dart';
import '../GlobalData.dart';

Widget widgetProperties(int devi) {
  // dbUpValueList[i] = '';
  return Column(children: [
    Row(
      children: [
        Text(
          dbNameList[devi],
        ),
        const SizedBox(
          width: 20,
        ),
        Text(dbTypeList[devi]),
      ],
    ),
    TextFormField(
        controller: myTextController[devi],
        // onChanged: (value) => {dbUpValueList[i] = value},
        decoration: const InputDecoration(
            border: UnderlineInputBorder(),

            // labelText: 'a',
            labelText: 'Enter upload value')),
  ]);
}
