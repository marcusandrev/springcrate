part of 'create_transactions_bloc.dart';

sealed class CreateTransactionsState extends Equatable {
  const CreateTransactionsState();
  
  @override
  List<Object> get props => [];
}

final class CreateTransactionsInitial extends CreateTransactionsState {}

final class CreateTransactionsLoading extends CreateTransactionsState {}
final class CreateTransactionsFailure extends CreateTransactionsState {}
final class CreateTransactionsSuccess extends CreateTransactionsState{}

final class UpdateTransactionLoading extends CreateTransactionsState {}
final class UpdateTransactionFailure extends CreateTransactionsState {}
final class UpdateTransactionSuccess extends CreateTransactionsState{}