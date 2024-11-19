import 'package:flutter/material.dart';

class CustomDropdown extends StatefulWidget {
  const CustomDropdown({super.key, required this.printerName,});
  final String printerName;

  @override
  State<CustomDropdown> createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
      height: 40,
      margin: EdgeInsets.only(top: 10),
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(color: Colors.grey),
        ),
      ),
      child: DropdownButton<String>(
        underline: const SizedBox(),
        iconSize: 20,
        borderRadius: BorderRadius.circular(8),
        value: widget.printerName,
        items: <String>[widget.printerName]
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Container(
              width: 300,
              padding: EdgeInsets.only(left: 10),
              child: Text(
                value,
                style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.w300),
              ),
            ),
          );
        }).toList(),
        onChanged: (String? value) {
          //debugPrint(value);
        },
      )
    );
  }
}