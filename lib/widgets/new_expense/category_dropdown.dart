import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CategoryDropdown extends StatefulWidget {
  CategoryDropdown({super.key, required this.categoryController});
  Category categoryController = Category.leisure;

  @override
  State<CategoryDropdown> createState() => _CategoryDropdownState();
}

class _CategoryDropdownState extends State<CategoryDropdown> {
  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      value: widget.categoryController,
      items: Category.values
          .map(
            (e) => DropdownMenuItem(
              value: e,
              child: Text(
                e.name.toUpperCase(),
              ),
            ),
          )
          .toList(),
      onChanged: (value) {
        if (value == null) {
          return;
        }
        setState(() {
          widget.categoryController = value;
        });
      },
    );
  }
}
