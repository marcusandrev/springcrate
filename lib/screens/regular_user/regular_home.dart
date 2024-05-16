import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:springcrate/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:springcrate/blocs/get_transactions_by_userId/get_transactions_by_user_id_bloc.dart';
import 'package:transactions_repository/transactions_repository.dart';

class RegularHomeScreen extends StatelessWidget {
  final String userId;

  const RegularHomeScreen({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthenticationBloc>(
          create: (context) => AuthenticationBloc(
            userRepository: context.read<AuthenticationBloc>().userRepository,
          ),
        ),
        BlocProvider(
          create: (context) =>
              GetTransactionsByUserIdBloc(FirebaseTransactionsRepo())
                ..add(GetTransactionsByUserId(userId)),
        ),
      ],
      child: _RegularHomeScreen(userId: userId),
    );
  }
}

class _RegularHomeScreen extends StatelessWidget {
  final String userId;

  const _RegularHomeScreen({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) =>
            GetTransactionsByUserIdBloc(FirebaseTransactionsRepo())
              ..add(GetTransactionsByUserId(userId)),
        child: SizedBox(
          child: BlocBuilder<GetTransactionsByUserIdBloc,
              GetTransactionsByUserIdState>(
            bloc: BlocProvider.of<GetTransactionsByUserIdBloc>(context),
            builder: (context, state) {
              if (state is GetTransactionsByUserIdInitial) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is GetTransactionsByUserIdLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is GetTransactionsByUserIdSuccess) {
                final transactions = state.transactions;
                return _buildEmployeeDetails(context, transactions);
                // return _buildTransactionsList(context, transactions);
                // return const Text('Employee Details');
              } else if (state is GetTransactionsByUserIdFailure) {
                return const Center(child: Text('Error fetching transactions'));
              } else {
                return const Text('Unexpected state');
              }
            },
          ),
        ));
  }

  Widget _buildEmployeeDetails(
      BuildContext context, List<Transactions> transactions) {
    double totalCost =
        transactions.fold(0, (sum, transaction) => sum + transaction.cost);
    final employeeDetailItems = [
      [
        _buildDetailWidget(context, 'Employee Name', transactions[0].name),
        _buildDetailWidget(
            context, 'Total Earnings', 'Php ${totalCost.toStringAsFixed(2)}'),
      ]
    ];
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 3.5,
            ),
            itemCount: employeeDetailItems[0].length,
            itemBuilder: ((context, index) => employeeDetailItems[0][index]),
          ),
          SizedBox(height: 20),
          Text(
            'Recent Transactions',
            style: TextStyle(
              color: Colors.grey[800],
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          _buildTransactionsList(context, transactions),
        ],
      ),
    );
  }
}

Widget _buildDetailWidget(BuildContext context, String label, String value) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        label,
        style: TextStyle(
            color: Colors.grey[800], fontSize: 16, fontWeight: FontWeight.bold),
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
  return Column(
    children: [
      ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
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

          return Card(
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
          );
        },
      ),
    ],
  );
}
