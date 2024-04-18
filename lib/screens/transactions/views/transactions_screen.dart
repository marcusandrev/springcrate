import 'package:flutter/material.dart';
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
            child: Column(
              children: [
                for (var data in transactionsData)
                  _buildTransactionsCard(
                      context,
                      data['plate_no'],
                      data['service'],
                      data['date'],
                      data['time'],
                      data['status']),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionsCard(
    BuildContext context,
    String plate_no,
    String service,
    String date,
    String time,
    String status,
  ) {
    Color primaryColor = Theme.of(context).primaryColor;
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
              "Plate no: $plate_no",
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
                Text("$date, $time"),
                Row(
                  children: [
                    Icon(
                      Icons.chevron_right,
                      color: Colors.red,
                    ),
                    TextButton(
                      onPressed: null, // Add functionality here
                      child: Text(
                        '$status',
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
}
