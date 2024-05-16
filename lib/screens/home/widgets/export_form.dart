import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:springcrate/blocs/get_transactions/get_transactions_bloc.dart';
import 'package:transactions_repository/transactions_repository.dart';

class ExportForm extends StatelessWidget {
  const ExportForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => GetTransactionsBloc(FirebaseTransactionsRepo())
          ..add(GetDailyEmployeeTransactions()),
        child: _ExportForm());
  }
}

class _ExportForm extends StatefulWidget {
  const _ExportForm({super.key});
  @override
  ExportFormState createState() {
    return ExportFormState();
  }
}

class ExportFormState extends State<_ExportForm> {
  final _formKey = GlobalKey<FormState>();

  void _onSubmit() {
    // TODO: Add logic for adding document to firebase
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetTransactionsBloc, GetTransactionsState>(
        builder: (context, state) {
      if (state is GetTransactionsLoading) {
        // return const CircularProgressIndicator();
        return const Padding(
            padding: EdgeInsets.all(16),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: Text(
                      'Loading export details...',
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  CircularProgressIndicator()
                ]));
      } else if (state is GetTransactionsSuccess) {
        if (state.transactions.isEmpty) {
          return Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  const Text(
                    'Export Details',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    "Seems like you don't have completed transactions today...",
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: TextButton.styleFrom(
                            elevation: 3.0,
                            backgroundColor:
                                Theme.of(context).colorScheme.primary,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(60))),
                        child: const Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                          child: Text(
                            'Go Back',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          ),
                        )),
                  )
                ],
              ));
        }
        return Form(
            key: _formKey,
            child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Export Details',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'The report will contain \n✔️ Daily Transactions',
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 20.0),
                    SizedBox(
                      width: double.infinity,
                      child: TextButton(
                          onPressed: () {
                            context.read<GetTransactionsBloc>().add(
                                ExportDailyEmployeeTransactions(
                                    state.transactions));
                            Navigator.pop(context);
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
                              'Export Report',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600),
                            ),
                          )),
                    )
                  ],
                )));
      } else if (state is GetTransactionsFailure) {
        return Text('Failed to load services');
      } else {
        return Text('Unknown state');
      }
    });
  }
}
