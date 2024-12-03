import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Picker extends StatefulWidget {
  final String placeholder;
  final List data;
  final void Function(int) selectOption;

  const Picker(
      {super.key,
      required this.placeholder,
      required this.data,
      required this.selectOption});

  @override
  State<Picker> createState() => _PickerState();
}

class _PickerState extends State<Picker> {
  int selectedWidget = 0;

  void _showPicker() {
    showCupertinoModalPopup(
      context: context,
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.4,
          color: CupertinoColors.systemBackground,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Done'),
              ),
              Expanded(
                child: CupertinoPicker(
                  itemExtent: 50,
                  onSelectedItemChanged: (value) => {
                    widget.selectOption(value),
                    setState(() {
                      selectedWidget = widget.data[value]['value'];
                    })
                  },
                  children: widget.data.map<Widget>((item) {
                    return Center(
                      child: Text(
                        item['value'].toString(),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoTextFormFieldRow(
      placeholder: widget.placeholder,
      readOnly: true,
      onTap: _showPicker,
      controller: TextEditingController(
          text: selectedWidget == 0 ? '' : selectedWidget.toString()),
    );
  }
}
