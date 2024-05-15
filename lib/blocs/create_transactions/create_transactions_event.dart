part of 'create_transactions_bloc.dart';

sealed class CreateTransactionsEvent extends Equatable {
  const CreateTransactionsEvent();

  @override
  List<Object> get props => [];
}

class CreateTransactions extends CreateTransactionsEvent {
  final Transactions transactions;

  const CreateTransactions(this.transactions);

  @override
  List<Object> get props => [transactions];
}

class UpdateTransaction extends CreateTransactionsEvent {
  final Transactions transaction;

  const UpdateTransaction(this.transaction);

  @override
  List<Object> get props => [transaction];
}
