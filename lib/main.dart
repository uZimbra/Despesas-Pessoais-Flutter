import 'dart:math';

import 'package:expenses/components/chart.widget.dart';
import 'package:expenses/components/transaction_form.widget.dart';
import 'package:expenses/core/index.dart';
import 'package:expenses/models/transaction.model.dart';
import 'package:flutter/material.dart';

import 'components/transaction_list.widget.dart';

main() => runApp(const ExpensesApp());

class ExpensesApp extends StatelessWidget {
  const ExpensesApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomeWidget(),
    );
  }
}

class HomeWidget extends StatefulWidget {
  const HomeWidget({Key? key}) : super(key: key);

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  final List<Transaction> _transactions = [
    Transaction(
      id: 't0',
      title: 'Conta antiga',
      value: 400,
      date: DateTime.now().subtract(
        const Duration(days: 33),
      ),
    ),
    Transaction(
      id: 't1',
      title: 'Novo Tênis de corrida',
      value: 310.76,
      date: DateTime.now().subtract(
        const Duration(days: 3),
      ),
    ),
    Transaction(
      id: 't2',
      title: 'Conta de luz',
      value: 211.30,
      date: DateTime.now().subtract(
        const Duration(days: 4),
      ),
    ),
  ];

  List<Transaction> get _recentTransactions {
    return _transactions
        .where(
          (element) => element.date.isAfter(
            DateTime.now().subtract(
              const Duration(days: 7),
            ),
          ),
        )
        .toList();
  }

  _addTransaction(String title, double value) {
    var newTransaction = Transaction(
      id: Random().nextDouble().toString(),
      title: title,
      value: value,
      date: DateTime.now(),
    );

    setState(() {
      _transactions.add(newTransaction);
    });

    Navigator.of(context).pop();
  }

  _showTransactionFormModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return TransactionForm(onSubmit: _addTransaction);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Despesas Pessoais',
          style: AppFonts.appBarTitle,
        ),
        actions: [
          IconButton(
            onPressed: () => _showTransactionFormModal(context),
            icon: const Icon(Icons.add),
          )
        ],
        backgroundColor: AppColors.primary,
      ),
      body: SingleChildScrollView(
        physics: const ScrollPhysics(parent: BouncingScrollPhysics()),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ChartWidget(recentTransactions: _recentTransactions),
            TransactionList(transactions: _transactions),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showTransactionFormModal(context),
        child: const Icon(
          Icons.add,
        ),
        backgroundColor: AppColors.secondary,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
