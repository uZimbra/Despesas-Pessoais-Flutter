import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:expenses/core/app_colors.core.dart';
import 'package:expenses/core/app_fonts.core.dart';
import 'package:expenses/models/transaction.model.dart';

class TransactionItem extends StatelessWidget {
  final Transaction item;
  final Function(String) onRemove;

  const TransactionItem({
    Key? key,
    required this.item,
    required this.onRemove,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 6),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: AppColors.primary,
          radius: 30,
          child: Padding(
            padding: const EdgeInsets.all(6),
            child: FittedBox(
              child: Text(
                'R\$${item.value.toStringAsFixed(2)}',
                style: TextStyle(
                  color: AppColors.white,
                ),
              ),
            ),
          ),
        ),
        title: Text(
          item.title,
          style: AppFonts.title,
        ),
        subtitle: Text(
          DateFormat('d MMM y').format(item.date),
        ),
        trailing: MediaQuery.of(context).size.width > 480
            ? TextButton.icon(
                onPressed: () => onRemove(item.id),
                icon: const Icon(Icons.delete),
                label: const Text('Excluir'),
                style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.resolveWith(
                    (states) => AppColors.red,
                  ),
                ),
              )
            : IconButton(
                color: AppColors.red,
                icon: const Icon(Icons.delete),
                onPressed: () => onRemove(item.id),
              ),
      ),
    );
  }
}
