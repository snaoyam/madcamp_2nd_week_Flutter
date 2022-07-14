import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class CSelectInput extends StatefulWidget {
  CSelectInput({Key? key, required this.list, required this.controller, this.title, required this.placeholder, }) : super(key: key);
  final List<String> list;
  TextEditingController controller;
  String? title;
  final String placeholder;

  @override
  State<CSelectInput> createState() => _CSelectInputState();
}

class _CSelectInputState extends State<CSelectInput> {
  _CSelectInputState();

  @override
  Widget build(BuildContext context) {
    if(widget.controller == null) widget.controller = TextEditingController(text: widget.list.first);
    return Column(
      children: [
        if(widget.title != null) Align(
          alignment: Alignment.centerLeft,
          child: Text(widget.title!, style: const TextStyle(fontSize: 16, color: Color.fromARGB(255, 105, 105, 105)), ),
        ),
        DropdownButtonHideUnderline(
          child: DropdownButton2(
            isExpanded: true,
            items: widget.list.map((item) => DropdownMenuItem<String>(
              value: item,
              child: Text(
                item,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            )).toList(),
            value: widget.controller.text,
            onChanged: (value) {
              setState(() {
                widget.controller.text = value as String;
              });
            },
            icon: const Icon(
              Icons.arrow_forward_ios_outlined,
            ),
            iconSize: 14,
            iconEnabledColor: Colors.black,
            iconDisabledColor: Colors.black,
            buttonHeight: 44,
            buttonPadding: const EdgeInsets.all(12),
            buttonDecoration: BoxDecoration(
              border: Border.all(
                color: Color.fromARGB(255, 80, 80, 80), //Colors.black26
                width: 1,
              ),
              borderRadius: BorderRadius.circular(6),
            ),
            buttonElevation: 0,
            //itemHeight: 40,
            //itemPadding: const EdgeInsets.only(left: 14, right: 14),
            dropdownMaxHeight: 200,
            dropdownPadding: null,
            dropdownDecoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: Colors.white,
            ),
            dropdownElevation: 3,
            scrollbarRadius: const Radius.circular(6),
            scrollbarThickness: 4,
            scrollbarAlwaysShow: false,
            offset: const Offset(0, 0),
          ),
        ),
        const SizedBox(height: 8,),
      ]
    );
  }
}