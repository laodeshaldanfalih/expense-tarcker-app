import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/new_expense/amount_textfield.dart';
import 'package:expense_tracker/widgets/new_expense/category_dropdown.dart';
import 'package:expense_tracker/widgets/new_expense/date_picker.dart';
import 'package:expense_tracker/widgets/new_expense/title_texfield.dart';
import 'package:flutter/material.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.onSubmitExpense});

  final void Function(Expense expense) onSubmitExpense;

  @override
  State<StatefulWidget> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  Category _categoryController = Category.leisure;

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: firstDate,
      lastDate: now,
    );

    setState(() {
      _selectedDate = pickedDate;
    });
  }

  void _submitExpenseData() {
    final submittedAmount = double.tryParse(_amountController.text);
    final amountIsInvalid = submittedAmount == null || submittedAmount <= 0;

    if (_titleController.text.trim().isEmpty ||
        amountIsInvalid ||
        _selectedDate == null) {
      // execute error
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Invalid Input'),
          content: const Text(
              'Please make sure a valid title, amount, date and category was entered'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: const Text("Okay"),
            ),
          ],
        ),
      );
    } else {
      widget.onSubmitExpense(
        Expense(
          title: _titleController.text,
          amount: submittedAmount,
          date: _selectedDate!,
          category: _categoryController,
        ),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final bottomOverflowWidth = MediaQuery.of(context).viewInsets.bottom;
    return LayoutBuilder(
      builder: ((context, constraints) {
        return SizedBox(
          height: double.infinity,
          child: SingleChildScrollView(
            child: Padding(
              padding:
                  EdgeInsets.fromLTRB(16, 48, 16, bottomOverflowWidth + 16),
              child: Column(
                children: [
                  if (constraints.maxWidth > 600)
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: TitleTextField(
                            titleController: _titleController,
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: AmountTextField(
                            amountController: _amountController,
                          ),
                        ),
                      ],
                    )
                  else
                    TitleTextField(
                      titleController: _titleController,
                    ),
                  if (constraints.maxWidth > 600)
                    Row(
                      children: [
                        CategoryDropdown(
                            categoryController: _categoryController),
                        const SizedBox(width: 20),
                        Expanded(
                          child: DatePicker(
                            selecDate: _selectedDate,
                            presentDatePicker: _presentDatePicker,
                          ),
                        ),
                      ],
                    )
                  else
                    Row(
                      children: [
                        Expanded(
                          child: AmountTextField(
                            amountController: _amountController,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: DatePicker(
                            selecDate: _selectedDate,
                            presentDatePicker: _presentDatePicker,
                          ),
                        ),
                      ],
                    ),
                  const SizedBox(height: 16),
                  if (constraints.maxWidth > 600)
                    Row(
                      children: [
                        const Spacer(),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('Cancel'),
                        ),
                        ElevatedButton(
                          onPressed: _submitExpenseData,
                          child: const Text('save Expense'),
                        )
                      ],
                    )
                  else
                    Row(
                      children: [
                        CategoryDropdown(
                            categoryController: _categoryController),
                        const Spacer(),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('Cancel'),
                        ),
                        ElevatedButton(
                          onPressed: _submitExpenseData,
                          child: const Text('save Expense'),
                        )
                      ],
                    ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
