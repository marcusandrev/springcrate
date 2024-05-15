import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:springcrate/blocs/get_transactions/get_transactions_bloc.dart';
import 'package:springcrate/screens/transactions/views/transaction_details_screen.dart';
import 'package:springcrate/widgets/searchbar.dart';
import 'package:transactions_repository/transactions_repository.dart';

class TransactionsScreen extends StatelessWidget {
  const TransactionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetTransactionsBloc(FirebaseTransactionsRepo())
        ..add(GetTransactions()),
      child: const _TransactionsScreen(),
    );
  }
}

class _TransactionsScreen extends StatelessWidget {
  const _TransactionsScreen({super.key});

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
            child: _buildTransactionsCard(context),
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionsCard(BuildContext context) {
    Color primaryColor = Theme.of(context).primaryColor;
    final DateFormat _dateFormat = DateFormat('dd MMM yyyy hh:mm a');

    return BlocBuilder<GetTransactionsBloc, GetTransactionsState>(
      builder: (context, state) {
        if (state is GetTransactionsLoading) {
          return const CircularProgressIndicator();
        } else if (state is GetTransactionsSuccess) {
          print('Number of cards created: ${state.transactions.length}');

          return Column(
            children: state.transactions.map((transaction) {
              String formattedStartDate = '';
              try {
                final DateTime parsedStartDate =
                    DateTime.parse(transaction.startDate);
                formattedStartDate = _dateFormat.format(parsedStartDate);
              } catch (e) {
                print("Invalid date format: ${transaction.startDate}");
              }

              return InkWell(
                borderRadius: BorderRadius.circular(8),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) =>
                          TransactionDetailsScreen(
                        transaction: transaction,
                      ),
                    ),
                  );
                },
                child: Card(
                  elevation: 4,
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Plate no: ${transaction.plateNumber}',
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: primaryColor),
                        ),
                        SizedBox(height: 4.0),
                        Text(
                          'Service: ${transaction.serviceName}',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 4.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(formattedStartDate),
                            Row(
                              children: [
                                Icon(
                                  Icons.chevron_right,
                                  color: Colors.blue,
                                ),
                                TextButton(
                                  onPressed: null,
                                  child: Text(
                                    '${transaction.status}',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue,
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
                ),
              );
            }).toList(),
          );
        } else {
          return const Center(
            child: Text("An error has occurred..."),
          );
        }
      },
    );
  }
}
