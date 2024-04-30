import 'package:flutter/material.dart';
import 'package:springcrate/screens/transactions/class_def/transaction.dart';

class TransactionDetailsScreen extends StatelessWidget {
  const TransactionDetailsScreen({super.key, required this.transaction});

  final Transaction transaction;

  @override
  Widget build(BuildContext context) {
    final test = transaction.plateNo;
    return Scaffold(
      appBar: AppBar(
        title: Text('Transactions > $test'),
      ),
      body: const Padding(
        padding: EdgeInsets.all(16),
        child: Text('Hello world!'),
      ),
    );
  }
}
