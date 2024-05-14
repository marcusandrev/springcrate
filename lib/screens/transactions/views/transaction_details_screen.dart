import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:springcrate/blocs/create_transactions/create_transactions_bloc.dart';
import 'package:transactions_repository/transactions_repository.dart';

class TransactionDetailsScreen extends StatelessWidget {
  const TransactionDetailsScreen({Key? key, required this.transaction})
      : super(key: key);

  final Transactions transaction;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CreateTransactionsBloc(
        transactionsRepo: FirebaseTransactionsRepo(),
      ),
      child: _TransactionDetailsScreen(transaction: transaction),
    );
  }
}

class _TransactionDetailsScreen extends StatefulWidget {
  final Transactions transaction;

  const _TransactionDetailsScreen({Key? key, required this.transaction})
      : super(key: key);

  @override
  _TransactionDetailsScreenState createState() =>
      _TransactionDetailsScreenState();
}

class _TransactionDetailsScreenState extends State<_TransactionDetailsScreen> {
  late TextEditingController startTimeController;
  late TextEditingController fulfilledTimeController;
  late DateTime startDate;
  late DateTime endDate;
  late String status;

  @override
  void initState() {
    super.initState();
    startTimeController =
        TextEditingController(text: widget.transaction.startDate);
    fulfilledTimeController =
        TextEditingController(text: widget.transaction.endDate);
    status = widget.transaction.status;
  }

  @override
  void dispose() {
    startTimeController.dispose();
    fulfilledTimeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final transaction = widget.transaction;

    final transactionDetailItems = [
      [
        _buildDetailWidget(context, 'Plate no.', transaction.plateNumber),
        _buildDetailWidget(context, 'Service Type', transaction.serviceName),
        _buildDetailWidget(context, 'Vehicle Type', transaction.vehicleType),
        _buildDetailWidget(context, 'Vehicle Size', transaction.vehicleSize)
      ],
      [
        _buildDetailWidget(context, 'Cost', 'Php ${transaction.cost}'),
        _buildDetailWidget(context, 'Status', status),
        _buildDetailWidget(context, 'Start Date', startTimeController.text),
        _buildDetailWidget(context, 'End Date', fulfilledTimeController.text),
      ]
    ];

    return BlocListener<CreateTransactionsBloc, CreateTransactionsState>(
      listener: (context, state) {
        if (state is UpdateTransactionSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Transaction updated successfully')),
          );
        } else if (state is UpdateTransactionFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to update transaction')),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Transactions > ${transaction.plateNumber}'),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
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
                itemBuilder: (context, index) =>
                    transactionDetailItems[0][index],
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
                itemBuilder: (context, index) =>
                    transactionDetailItems[1][index],
              ),
              const SizedBox(height: 20),
              if (status != 'Completed')
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      if (status == 'Not Started') {
                        status = 'On Going';
                        startTimeController.text = DateTime.now().toString();
                      } else if (status == 'On Going') {
                        status = 'Completed';
                        fulfilledTimeController.text =
                            DateTime.now().toString();
                      }
                      transaction.startDate = startTimeController.text;
                      transaction.endDate = fulfilledTimeController.text;
                      transaction.status = status;
                      context
                          .read<CreateTransactionsBloc>()
                          .add(UpdateTransaction(transaction));
                    });
                  },
                  child: Text('Update Transaction'),
                ),
            ],
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
