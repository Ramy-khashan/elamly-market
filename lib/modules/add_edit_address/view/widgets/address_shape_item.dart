import 'package:flutter/material.dart';

class AddressShapeDataItem extends StatelessWidget {
  const AddressShapeDataItem(
      {super.key, required this.title, required this.value});
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: AlignmentDirectional.topStart,
        child: Card(
          margin: EdgeInsets.fromLTRB(20, 10, 0, 3),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "$title : " + value,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
            ),
          ),
        ));
  }
}
