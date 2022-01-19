import 'package:expenses/components/transaction_item.widget.dart';
import 'package:expenses/core/index.dart';
import 'package:expenses/models/transaction.model.dart';
import 'package:flutter/material.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final void Function(String) onRemove;

  const TransactionList({
    Key? key,
    required this.transactions,
    required this.onRemove,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? LayoutBuilder(
            builder: (context, constrains) => Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'Nenhuma transação cadastrada!',
                  style: AppFonts.title,
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: constrains.maxHeight * 0.6,
                  child: Image.asset(
                    AppImages.waiting,
                    fit: BoxFit.cover,
                  ),
                )
              ],
            ),
          )
        : ListView.builder(
            physics: const ScrollPhysics(
              parent: BouncingScrollPhysics(),
            ),
            itemCount: transactions.length,
            itemBuilder: (ctx, index) {
              final item = transactions[index];
              return TransactionItem(
                item: item,
                onRemove: onRemove,
              );
            },
          );
  }
}
