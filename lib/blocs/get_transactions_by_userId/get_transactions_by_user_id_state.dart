part of 'get_transactions_by_user_id_bloc.dart';

sealed class GetTransactionsByUserIdState extends Equatable {
  const GetTransactionsByUserIdState();

  @override
  List<Object> get props => [];
}

final class GetTransactionsByUserIdInitial
    extends GetTransactionsByUserIdState {}

final class GetTransactionsByUserIdLoading extends GetTransactionsByUserIdState {}

final class GetTransactionsByUserIdFailure extends GetTransactionsByUserIdState {}

final class GetTransactionsByUserIdSuccess extends GetTransactionsByUserIdState {
  final List<Transactions> transactions;

  const GetTransactionsByUserIdSuccess(this.transactions);

  @override
  List<Object> get props => [transactions];
}