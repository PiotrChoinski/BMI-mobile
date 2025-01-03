import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DatePicker extends StatefulWidget {
  final String placeholder;
  final void Function(DateTime) selectOption;

  const DatePicker({
    super.key,
    required this.placeholder,
    required this.selectOption,
  });

  @override
  State<DatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  DateTime? selectedDate;

  String handleDate() {
    final String day = '${selectedDate!.day}'.length > 1
        ? selectedDate!.day.toString()
        : '0${selectedDate!.day}';

    final String month = '${selectedDate!.month}'.length > 1
        ? selectedDate!.month.toString()
        : '0${selectedDate!.month}';

    final int howOld = DateTime.now().difference(selectedDate!).inDays ~/ 365;

    return '$day/$month/${selectedDate!.year} ($howOld y.o.)';
  }

  void handleOpenDatePicker() {
    if (selectedDate == null) {
      setState(() => selectedDate = DateTime(DateTime.now().year - 1));
      widget.selectOption(DateTime(DateTime.now().year - 1));
    }
    _showDatePicker();
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
                    widget.selectOption(newDateTime);
                    setState(() => selectedDate = newDateTime);
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
        placeholder: widget.placeholder,
        onTap: handleOpenDatePicker,
        readOnly: true,
        controller: TextEditingController(
            text: selectedDate != null ? handleDate() : ''));
  }
}
