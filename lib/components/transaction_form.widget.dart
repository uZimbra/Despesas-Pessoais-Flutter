import 'package:expenses/core/app_colors.core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionForm extends StatefulWidget {
  final void Function(String, double) onSubmit;

  const TransactionForm({
    Key? key,
    required this.onSubmit,
  }) : super(key: key);

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final _titleController = TextEditingController();
  final _valueController = TextEditingController();
  late DateTime _selectedDate;
  bool _hasSelectedDate = false;

  _onSubmit() {
    final title = _titleController.text;
    final value = double.tryParse(_valueController.text) ?? 0.0;

    if (title.isEmpty || value <= 0) return;

    widget.onSubmit(title, value);
  }

  _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
      builder: (context, child) => Theme(
        data: ThemeData().copyWith(
          colorScheme: ColorScheme.light(
            primary: AppColors.primary,
          ),
        ),
        child: child as Widget,
      ),
    ).then((value) {
      if (value != null) {
        setState(() {
          _selectedDate = value;
          _hasSelectedDate = true;
        });
      }
      return;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              onSubmitted: (_) => _onSubmit(),
              decoration: const InputDecoration(
                labelText: 'Título',
              ),
            ),
            TextField(
              controller: _valueController,
              onSubmitted: (_) => _onSubmit(),
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                labelText: 'Valor (R\$)',
              ),
            ),
            SizedBox(
              height: 70,
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      _hasSelectedDate
                          ? 'Data selecionada: ${DateFormat('dd/MM/yy').format(_selectedDate)}'
                          : 'Nenhuma data selecionada!',
                    ),
                  ),
                  TextButton(
                    onPressed: _showDatePicker,
                    child: Text(
                      'Selecionar Data',
                      style: TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                      AppColors.primary,
                    ),
                  ),
                  onPressed: _onSubmit,
                  child: Text(
                    'Nova transação',
                    style: TextStyle(
                      color: AppColors.white,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
