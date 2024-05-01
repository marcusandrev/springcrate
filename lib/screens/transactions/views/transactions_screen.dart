import 'package:flutter/material.dart';
import 'package:springcrate/screens/transactions/class_def/transaction.dart';
import 'package:springcrate/screens/transactions/views/transaction_details_screen.dart';
import 'package:springcrate/widgets/searchbar.dart';
import 'package:springcrate/data/data.dart';

class TransactionsScreen extends StatelessWidget {
  const TransactionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 20),
          Searchbar(
            borderColor: Theme.of(context).colorScheme.primary,
            iconColor: Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(height: 20),
          SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                for (var data in transactionsData)
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, _createRoute(context, data));
                    },
                    child: _buildTransactionsCard(context, data),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionsCard(
    BuildContext context,
    Transaction transactionItem,
  ) {
    Color primaryColor = Theme.of(context).primaryColor;
    final plateNo = transactionItem.plateNo;
    final service = transactionItem.service;
    final start = transactionItem.startDate;
    final status = transactionItem.status;

    return Card(
      elevation: 4,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Plate no: $plateNo",
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: primaryColor),
            ),
            SizedBox(height: 4.0),
            Text(
              "Service: $service",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 4.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(start),
                Row(
                  children: [
                    Icon(
                      Icons.chevron_right,
                      color: Colors.red,
                    ),
                    TextButton(
                      onPressed: null, // Add functionality here
                      child: Text(
                        status,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Route _createRoute(BuildContext context, Transaction transaction) {
    return PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            TransactionDetailsScreen(transaction: transaction),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0);
          const end = Offset.zero;
          const curve = Curves.ease;

          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        });
  }
}
