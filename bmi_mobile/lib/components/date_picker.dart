import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DatePicker extends StatefulWidget {
  const DatePicker({super.key});

  @override
  State<DatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  DateTime? selectedDate;
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  void _showDatePicker() {
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
                child: CupertinoDatePicker(
                  mode: CupertinoDatePickerMode.date,
                  initialDateTime: selectedDate ?? DateTime.now(),
                  maximumDate: DateTime.now(),
                  onDateTimeChanged: (DateTime newDateTime) {
                    setState(() {
                      selectedDate = newDateTime;
                      _controller.text =
                          '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}';
                    });
                  },
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
      placeholder: 'Date',
      onTap: _showDatePicker,
      readOnly: true,
      controller: _controller,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
