import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:springcrate/blocs/get_my_users/get_my_users_bloc.dart';

import 'package:springcrate/blocs/get_transactions_by_userId/get_transactions_by_user_id_bloc.dart';
import 'package:transactions_repository/transactions_repository.dart';
import 'package:user_repository/user_repository.dart';

class EmployeeDetailsScreen extends StatelessWidget {
  const EmployeeDetailsScreen({super.key, required this.myUsers});

  final MyUser myUsers;

@override
Widget build(BuildContext context) {
  return BlocProvider(
    create: (_) => GetTransactionsByUserIdBloc(FirebaseTransactionsRepo())
      ..add(GetTransactionsByUserId(myUsers.userId)),
    child: BlocProvider(
      create: (_) => GetMyUsersBloc(FirebaseUserRepo())
        ..add(GetMyUsersByUserId(myUsers.userId)),
              
      child: _EmployeeDetailsScreen(myUsers: myUsers),
    ),
  );
}
}

class _EmployeeDetailsScreen extends StatelessWidget {
  const _EmployeeDetailsScreen({super.key, required this.myUsers});

  final MyUser myUsers;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Employees > ${myUsers.userId}')),
      body: BlocBuilder<GetMyUsersBloc, GetMyUsersState>(
        builder: (context, userState) {
          if (userState is GetMyUsersLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (userState is GetMyUsersFailure) {
            return const Center(child: Text('Error fetching user details'));
          } else if (userState is GetMyUsersSuccess) {
            final users = userState.myUsers
                .where((user) => user.userId == myUsers.userId)
                .toList();

            if (users.isNotEmpty) {
              final user = users.first;
              return BlocBuilder<GetTransactionsByUserIdBloc,
                  GetTransactionsByUserIdState>(
                builder: (context, transactionState) {
                  if (transactionState is GetTransactionsByUserIdInitial ||
                      transactionState is GetTransactionsByUserIdLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (transactionState
                      is GetTransactionsByUserIdSuccess) {
                    final transactions = transactionState.transactions;
                    return _buildEmployeeDetails(context, user, transactions);
                  } else if (transactionState
                      is GetTransactionsByUserIdFailure) {
                    return const Center(
                        child: Text('Error fetching transactions'));
                  } else {
                    return const Text('Unexpected state');
                  }
                },
              );
            } else {
              return const Center(child: Text('User not found'));
            }
          } else {
            return const Text('Unexpected state');
          }
        },
      ),
    );
  }

  Widget _buildEmployeeDetails(
      BuildContext context, MyUser user, List<Transactions> transactions) {
    final employeeDetailItems = [
      [
        _buildDetailWidget(context, 'Employee Name', user.name),
        _buildDetailWidget(context, 'Employee Rate', user.rate),
        _buildDetailWidget(context, 'Contact Number', user.contactNumber),
        _buildDetailWidget(context, 'Address', user.address),
      ]
    ];

    return SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            if (user.rate.isEmpty) // Add Rate button if rate is empty
              ElevatedButton(
                onPressed: () => _showAddRateDialog(context, user),
                child: const Text('Add Rate'),
              ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, childAspectRatio: 3.5),
                  itemCount: employeeDetailItems[0].length,
                  itemBuilder: ((context, index) =>
                      employeeDetailItems[0][index]),
                ),
                SizedBox(height: 20),
                Text(
                  'Recent Transactions',
                  style: TextStyle(
                      color: Colors.grey[800],
                      fontSize: 24,
                      fontWeight: FontWeight.bold),
                ),
                _buildTransactionsList(context, transactions),
              ],
            )
          ],
        ));
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

  Widget _buildTransactionsList(
    BuildContext context,
    List<Transactions> transactions,
  ) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ListView.builder(
            shrinkWrap: true,
            itemCount: transactions.length,
            itemBuilder: (context, index) {
              final transaction = transactions[index];

              String formattedEndDate = '-';
              if (transaction.endDate != '0000-00-00T00:00:00.000000') {
                try {
                  DateTime endDate = DateTime.parse(transaction.endDate);
                  formattedEndDate =
                      DateFormat('MM/dd/yyyy hh:mm a').format(endDate);
                } catch (e) {
                  print('Error parsing end date: $e');
                }
              }

              return SingleChildScrollView(
                  child: Card(
                elevation: 0,
                color: const Color(0x00000000),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Plate no: ${transaction.plateNumber}',
                          style: TextStyle(
                            color: Colors.grey[800],
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text('Service: ${transaction.serviceName}'),
                        Text('Cost: Php ${transaction.cost}'),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SizedBox(height: 10),
                        Text(formattedEndDate),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 16, bottom: 16),
                      child: const Divider(
                        height: 4,
                        thickness: 1,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ));
            },
          )
        ],
      ),
    );
  }

  void _showAddRateDialog(BuildContext context, MyUser user) {
    final _formKey = GlobalKey<FormState>();
    final TextEditingController _rateController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add Rate'),
          content: Form(
            key: _formKey,
            child: TextFormField(
              controller: _rateController,
              decoration: const InputDecoration(labelText: 'Rate'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a rate';
                }
                return null;
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (_formKey.currentState?.validate() ?? false) {
                  context.read<GetMyUsersBloc>().add(UpdateUser(user.copyWith(rate: _rateController.text)));
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

