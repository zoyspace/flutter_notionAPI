import 'package:flutter/material.dart';
import '../GlobalData.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class PropertyStateful extends StatefulWidget {
  const PropertyStateful({
    Key? key,
  }) : super(key: key);

  @override
  State<PropertyStateful> createState() => _PropertyStatefulState();
}

class _PropertyStatefulState extends State<PropertyStateful> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Row(
        children: [
          Text(
            dbNameList[numberOfPage],
          ),
          const SizedBox(
            width: 20,
          ),
          Text(dbTypeList[numberOfPage]),
        ],
      ),
      TextFormField(
          onChanged: (value) => {dbUpValueList[numberOfPage] = value},
          decoration: const InputDecoration(
              border: UnderlineInputBorder(),

              // labelText: 'a',
              labelText: 'Enter upload value')),
    ]);
  }
}
