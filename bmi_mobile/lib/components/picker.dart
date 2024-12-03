import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Picker extends StatefulWidget {
  const Picker({super.key});

  @override
  State<Picker> createState() => _PickerState();
}

class _PickerState extends State<Picker> {
  String selectedFruit = 'Apple';

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
                  itemExtent: 50, // Wysokość pojedynczego elementu
                  onSelectedItemChanged: (value) => print(value),
                  children: List.generate(100, (index) {
                    return Center(
                      child: Text('${index + 135}'),
                    );
                  }),
                  // children: _fruitNames.map((fruit) {
                  //   return Center(
                  //     child: Text(
                  //       fruit,
                  //     ),
                  //   );
                  // }).toList(),
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
      placeholder: 'Select Fruit',
      readOnly: true,
      onTap: _showPicker, // Wywołanie metody pokazującej picker
      controller: TextEditingController(text: selectedFruit),
    );
  }
}
