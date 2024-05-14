import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
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
  DateTime? startDate;
  DateTime? endDate;
  late String status;

  final DateFormat _dateFormat = DateFormat('dd MMM yyyy hh:mm a');

  @override
  void initState() {
    super.initState();
    startDate = _parseDate(widget.transaction.startDate);
    endDate = _parseDate(widget.transaction.endDate);
    startTimeController = TextEditingController(
      text: startDate != null ? _dateFormat.format(startDate!) : '',
    );
    fulfilledTimeController = TextEditingController(
      text: endDate != null ? _dateFormat.format(endDate!) : '',
    );
    status = widget.transaction.status;
  }

  DateTime? _parseDate(String dateString) {
    try {
      return DateTime.parse(dateString);
    } catch (e) {
      print("Invalid date format: $dateString");
      return null;
    }
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
        _buildDetailWidget(
            context,
            'Start Date',
            startTimeController.text.isNotEmpty
                ? startTimeController.text
                : 'N/A'),
        _buildDetailWidget(
            context,
            'End Date',
            fulfilledTimeController.text.isNotEmpty
                ? fulfilledTimeController.text
                : 'N/A'),
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
                        startDate = DateTime.now();
                        startTimeController.text =
                            _dateFormat.format(startDate!);
                      } else if (status == 'On Going') {
                        status = 'Completed';
                        endDate = DateTime.now();
                        fulfilledTimeController.text =
                            _dateFormat.format(endDate!);
                      }
                      transaction.startDate =
                          startDate?.toIso8601String() ?? '';
                      transaction.endDate = endDate?.toIso8601String() ?? '';
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
