part of 'delete_transactions_bloc.dart';

sealed class DeleteTransactionsState extends Equatable {
  const DeleteTransactionsState();
  
  @override
  List<Object> get props => [];
}

final class DeleteTransactionsInitial extends DeleteTransactionsState {}

final class DeleteTransactionsLoading extends DeleteTransactionsState {}

final class DeleteTransactionsSuccess extends DeleteTransactionsState {}

final class DeleteTransactionsFailure extends DeleteTransactionsState {}

