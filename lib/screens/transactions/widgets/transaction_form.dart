import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:services_repository/services_repository.dart';
import 'package:springcrate/blocs/create_transactions/create_transactions_bloc.dart';
import 'package:springcrate/blocs/get_my_users/get_my_users_bloc.dart';
import 'package:springcrate/blocs/get_services/get_services_bloc.dart';
import 'package:transactions_repository/transactions_repository.dart';
import 'package:user_repository/user_repository.dart';

class TransactionForm extends StatelessWidget {
  const TransactionForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider.value(
        value: BlocProvider.of<CreateTransactionsBloc>(context),
      ),
      BlocProvider(
          create: (_) =>
              GetServicesBloc(FirebaseServiceRepo())..add(GetServices())),
      BlocProvider(
          create: (_) => GetMyUsersBloc(FirebaseUserRepo())..add(GetMyUsers()))
    ], child: _TransactionForm());
  }
}

class _TransactionForm extends StatefulWidget {
  @override
  _TransactionFormState createState() => _TransactionFormState();
}

class _TransactionFormState extends State<_TransactionForm> {
  final plateNumberController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool creationRequired = false;
  late Transactions transactions;

  @override
  void initState() {
    transactions = Transactions.empty;
    super.initState();
  }

  void _clear() {}

  Widget _buildUserDropdown() {
    return BlocBuilder<GetMyUsersBloc, GetMyUsersState>(
      builder: (context, state) {
        if (state is GetMyUsersLoading) {
          return const CircularProgressIndicator();
        } else if (state is GetMyUsersSuccess) {
          // var users = state.myUsers;
          return DropdownButtonFormField<String>(
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Select an employee',
            ),
            items: state.myUsers.map((myUser) {
              return DropdownMenuItem(
                value: myUser.name,
                child: Row(children: [Text(myUser.name)]),
              );
            }).toList(),
            onChanged: (value) {
              final selectedUser =
                  state.myUsers.firstWhere((myUser) => myUser.name == value);
              setState(() {
                transactions.name = value.toString();
                transactions.userId = selectedUser.userId;
              });
            },
          );
        } else if (state is GetMyUsersFailure) {
          return Text('Failed to load users');
        } else {
          return Text('Unknown state');
        }
      },
    );
  }

  Widget _buildServiceDropdown() {
    return BlocBuilder<GetServicesBloc, GetServicesState>(
      builder: (context, state) {
        if (state is GetServicesLoading) {
          return const CircularProgressIndicator();
        }
        if (state is GetServicesSuccess) {
          return DropdownButtonFormField<String>(
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
              final selectedService = state.services
                  .firstWhere((service) => service.serviceName == value);
              setState(() {
                transactions.serviceName = value.toString();
                transactions.vehicleSize = selectedService.vehicleSize;
                transactions.vehicleType = selectedService.vehicleType;
                transactions.cost = selectedService.cost;
              });
            },
          );
        } else if (state is GetServicesFailure) {
          return Text('Failed to load services');
        } else {
          return Text('Unknown state');
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CreateTransactionsBloc, CreateTransactionsState>(
        listener: (context, state) {
          if (state is CreateTransactionsSuccess) {
            setState(() {
              creationRequired = false;
            });
            Navigator.pop(context, true);
          } else if (state is CreateTransactionsLoading) {
            setState(() {
              creationRequired = true;
            });
          } else if (state is CreateTransactionsFailure) {
            return;
          }
        },
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Transaction Details',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
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

                _buildServiceDropdown(),
                const SizedBox(height: 16.0),
                _buildUserDropdown(),

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
                                    borderRadius: BorderRadius.circular(60))),
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
        ));
  }
}
