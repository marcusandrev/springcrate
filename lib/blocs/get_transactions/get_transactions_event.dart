part of 'get_transactions_bloc.dart';

sealed class GetTransactionsEvent extends Equatable {
  const GetTransactionsEvent();

  @override
  List<Object> get props => [];
}

class GetTransactions extends GetTransactionsEvent {}

class GetDailyEmployeeTransactions extends GetTransactionsEvent {}

class ExportDailyEmployeeTransactions extends GetTransactionsEvent {
  final List<Transactions> transactions;

  const ExportDailyEmployeeTransactions(this.transactions);

  @override
  List<Object> get props => [transactions];
}

class SearchTransactions extends GetTransactionsEvent {
  final String query;

  const SearchTransactions(this.query);

  @override
  List<Object> get props => [query];
}
