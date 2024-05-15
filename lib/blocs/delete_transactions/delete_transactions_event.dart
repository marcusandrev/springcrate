part of 'delete_transactions_bloc.dart';

sealed class DeleteTransactionsEvent extends Equatable {
  const DeleteTransactionsEvent();

  @override
  List<Object> get props => [];
}

final class DeleteTransaction extends DeleteTransactionsEvent {
  final String transactionId;

  const DeleteTransaction({required this.transactionId});

  @override
  List<Object> get props => [transactionId];
}
