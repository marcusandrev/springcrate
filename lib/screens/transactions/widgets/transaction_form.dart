import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:services_repository/services_repository.dart';
import 'package:springcrate/blocs/create_transactions/create_transactions_bloc.dart';
import 'package:springcrate/blocs/get_services/get_services_bloc.dart';
import 'package:transactions_repository/transactions_repository.dart';

class TransactionForm extends StatelessWidget {
  const TransactionForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CreateTransactionsBloc(
        transactionsRepo: FirebaseTransactionsRepo(),
      ),
      child: BlocProvider(
        create: (_) =>
            GetServicesBloc(FirebaseServiceRepo())..add(GetServices()),
        child: _TransactionForm(),
      ),
    );
  }
}

class _TransactionForm extends StatefulWidget {
  @override
  _TransactionFormState createState() => _TransactionFormState();
}

class _TransactionFormState extends State<_TransactionForm> {
  final plateNumberController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  String _plateNo = '';
  String _serviceType = '';
  bool creationRequired = false;
  late Transactions transactions;

  @override
  void initState() {
    transactions = Transactions.empty;
    super.initState();
  }

  void _clear() {
    _plateNo = '';
  }

  void _onSubmit() {
    // TODO: Add logic for adding document to firebase
    print('Plate No. $_plateNo\nService: $_serviceType');
    _clear();
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CreateTransactionsBloc, CreateTransactionsState>(
      listener: (context, state) {
        if (state is CreateTransactionsSuccess) {
          setState(() {
            creationRequired = false;
          });
        } else if (state is CreateTransactionsLoading) {
          setState(() {
            creationRequired = true;
          });
        } else if (state is CreateTransactionsFailure) {
          return;
        }
      },
      child: BlocBuilder<GetServicesBloc, GetServicesState>(
        builder: (context, state) {
          if (state is GetServicesLoading) {
            // Handle loading state
            return CircularProgressIndicator();
          } else if (state is GetServicesSuccess) {
            // Use the loaded services to populate the dropdown
            return Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Transaction Details',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    TextFormField(
                      controller: plateNumberController,
                      obscureText: false,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                          border: UnderlineInputBorder(),
                          labelText: 'Enter Plate number'),
                      validator: (val) {
                        if (val!.isEmpty) {
                          return 'Please fill in this field';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16.0),
                    DropdownButtonFormField<String>(
                      decoration: const InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: 'Select a service',
                      ),
                      items: state.services.map((service) {
                        return DropdownMenuItem(
                          value: service.serviceName,
                          child: Row(children: [Text(service.serviceName)]),
                        );
                      }).toList(),
                      onChanged: (value) {
                        final selectedService = state.services.firstWhere(
                            (service) => service.serviceName == value);
                        setState(() {
                          transactions.serviceName = value.toString();
                          transactions.vehicleSize =
                              selectedService.vehicleSize;
                          transactions.vehicleType =
                              selectedService.vehicleType;
                          transactions.cost = selectedService.cost;
                        });
                      },
                    ),

                    const SizedBox(height: 20.0),
                    !creationRequired
                        ? SizedBox(
                            width: double.infinity,
                            child: TextButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    setState(() {
                                      transactions.plateNumber =
                                          plateNumberController.text;
                                    });
                                    print(transactions.toString());
                                    context
                                        .read<CreateTransactionsBloc>()
                                        .add(CreateTransactions(transactions));
                                  }
                                },
                                style: TextButton.styleFrom(
                                    elevation: 3.0,
                                    backgroundColor:
                                        Theme.of(context).colorScheme.primary,
                                    foregroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(60))),
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 25, vertical: 5),
                                  child: Text(
                                    'Add Transaction',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  ),
                                )),
                          )
                        : const CircularProgressIndicator(),
                    // ),
                  ],
                ),
              ),
            );
          } else if (state is GetServicesFailure) {
            // Handle failure state
            return Text('Failed to load services');
          } else {
            // Default return
            return Text('Unknown state');
          }
        },
      ),
    );
  }
}
