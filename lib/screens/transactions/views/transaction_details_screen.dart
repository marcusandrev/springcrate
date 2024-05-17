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
    return BlocProvider.value(
      value: BlocProvider.of<CreateTransactionsBloc>(context),
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
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: () => _showEditServiceDialog(context),
                  child: const Text('Edit Transaction'),
                ),
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

  void _showEditServiceDialog(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final transaction = widget.transaction;
    final TextEditingController _plateNumberController =
        TextEditingController(text: transaction.plateNumber);
    final TextEditingController _serviceTypeController =
        TextEditingController(text: transaction.serviceName);
    final TextEditingController _transactionCostController =
        TextEditingController(text: transaction.cost.toString());
    String _selectedVehicleType = transaction.vehicleType;
    String _selectedVehicleSize = transaction.vehicleSize;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Transaction'),
          content: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: _plateNumberController,
                    decoration:
                        const InputDecoration(labelText: 'Plate Number'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the plate number';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _serviceTypeController,
                    decoration:
                        const InputDecoration(labelText: 'Service Type'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the service type';
                      }
                      return null;
                    },
                  ),
                  DropdownButtonFormField<String>(
                    value: _selectedVehicleType,
                    decoration:
                        const InputDecoration(labelText: 'Vehicle Type'),
                    items: ['sedan', 'suv', 'van', 'pickup', 'motorcycle']
                        .map((type) => DropdownMenuItem(
                              value: type,
                              child: Text(type),
                            ))
                        .toList(),
                    onChanged: (value) {
                      if (value != null) {
                        _selectedVehicleType = value;
                      }
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select a vehicle type';
                      }
                      return null;
                    },
                  ),
                  DropdownButtonFormField<String>(
                    value: _selectedVehicleSize,
                    decoration:
                        const InputDecoration(labelText: 'Vehicle Size'),
                    items: ['small', 'medium', 'large']
                        .map((size) => DropdownMenuItem(
                              value: size,
                              child: Text(size),
                            ))
                        .toList(),
                    onChanged: (value) {
                      if (value != null) {
                        _selectedVehicleSize = value;
                      }
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select a vehicle size';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _transactionCostController,
                    decoration:
                        const InputDecoration(labelText: 'Service Cost'),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a service cost';
                      }
                      if (double.tryParse(value) == null) {
                        return 'Please enter a valid number';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  final newTransaction = transaction.copyWith(
                    plateNumber: _plateNumberController.text,
                    serviceName: _serviceTypeController.text,
                    vehicleType: _selectedVehicleType,
                    vehicleSize: _selectedVehicleSize,
                    cost: int.parse(_transactionCostController.text),
                  );
                  context
                      .read<CreateTransactionsBloc>()
                      .add(UpdateTransaction(newTransaction));
                  Navigator.of(context).pop();
                }
              },
              child: const Text('Submit'),
            ),
          ],
        );
      },
    );
  }
}
