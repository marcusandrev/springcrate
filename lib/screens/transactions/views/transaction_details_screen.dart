import 'package:flutter/material.dart';
import 'package:transactions_repository/transactions_repository.dart';

class TransactionDetailsScreen extends StatefulWidget {
  const TransactionDetailsScreen({super.key, required this.transaction});

  final Transactions transaction;

  @override
  _TransactionDetailsScreenState createState() =>
      _TransactionDetailsScreenState();
}

class _TransactionDetailsScreenState extends State<TransactionDetailsScreen> {
  late Transactions transaction;
  late TextEditingController startTimeController;
  late TextEditingController fulfilledTimeController;

  @override
  void initState() {
    super.initState();
    transaction = widget.transaction;
    startTimeController = TextEditingController();
    fulfilledTimeController = TextEditingController();
  }

  @override
  void dispose() {
    startTimeController.dispose();
    fulfilledTimeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final transactionDetailItems = [
      [
        _buildDetailWidget(context, 'Plate no.', transaction.plateNumber),
        _buildDetailWidget(context, 'Service Type', transaction.serviceName),
        _buildDetailWidget(context, 'Vehicle Type', transaction.vehicleType),
        _buildDetailWidget(context, 'Vehicle Size', transaction.vehicleSize)
      ],
      [
        _buildDetailWidget(context, 'Status', transaction.status),
        _buildDetailWidget(context, 'Start Date', transaction.startDate),
        _buildDetailWidget(context, 'Cost', 'Php ${transaction.cost}'),
        _buildDetailWidget(context, 'Fulfilled', transaction.endDate)
      ]
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text('Transactions > ${transaction.plateNumber}'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildDetailWidget(
                    context, 'Transaction ID', transaction.transactionId),
                const SizedBox(height: 20),
                GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, childAspectRatio: 3.5),
                  itemCount: transactionDetailItems[0].length,
                  itemBuilder: ((context, index) =>
                      transactionDetailItems[0][index]),
                ),
                const SizedBox(height: 16),
                const Divider(height: 4, thickness: 1, color: Colors.grey),
                const SizedBox(height: 20),
                GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, childAspectRatio: 3.5),
                  itemCount: transactionDetailItems[1].length,
                  itemBuilder: ((context, index) =>
                      transactionDetailItems[1][index]),
                )
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        height: 90,
        surfaceTintColor: Colors.grey.shade100,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextButton(
            onPressed: () {
              if (transaction.status == 'Not Started') {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Change Transaction Status?'),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                              'Do you want to change the status to "On Going"?'),
                          TextField(
                            controller: startTimeController,
                            decoration:
                                InputDecoration(labelText: 'Start Time'),
                          ),
                        ],
                      ),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('No'),
                        ),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              transaction.status = 'On Going';
                              transaction.startDate =
                                  startTimeController.text;
                            });
                            // Add logic to update status in your repository or bloc
                            Navigator.of(context).pop();
                          },
                          child: Text('Yes'),
                        ),
                      ],
                    );
                  },
                );
              } else if (transaction.status == 'On Going') {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Complete Transaction?'),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                              'Are you sure you want to complete this transaction?'),
                          TextField(
                            controller: fulfilledTimeController,
                            decoration: InputDecoration(
                                labelText: 'Fulfilled Time'),
                          ),
                        ],
                      ),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('No'),
                        ),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              transaction.status = 'Complete';
                              transaction.endDate =
                                  fulfilledTimeController.text;
                            });
                            // Add logic to update status in your repository or bloc
                            Navigator.of(context).pop();
                          },
                          child: Text('Yes'),
                        ),
                      ],
                    );
                  },
                );
              }
            },
            child: Text(
              transaction.status == 'On Going'
                  ? 'On Going'
                  : (transaction.status == 'Not Started'
                      ? 'Not Started'
                      : 'Complete'),
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(
                transaction.status == 'On Going'
                    ? Colors.orange
                    : (transaction.status == 'Not Started'
                        ? Colors.red
                        : Colors.green),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDetailWidget(BuildContext context, String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
              color: Colors.grey[800],
              fontSize: 16,
              fontWeight: FontWeight.bold),
        ),
        Text(
          value,
          style: TextStyle(color: Colors.grey[800], fontSize: 14),
        )
      ],
    );
  }
}
