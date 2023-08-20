import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';

class DatePicker extends StatelessWidget {
  const DatePicker({
    super.key,
    required this.presentDatePicker,
    required this.selecDate,
  });

  final DateTime? selecDate;
  final void Function() presentDatePicker;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          selecDate == null ? 'Select Date' : formatter.format(selecDate!),
        ),
        IconButton(
          onPressed: presentDatePicker,
          icon: const Icon(
            Icons.calendar_month,
          ),
        ),
      ],
    );
  }
}
