part of 'get_transactions_by_user_id_bloc.dart';

sealed class GetTransactionsByUserIdEvent extends Equatable {
  const GetTransactionsByUserIdEvent();

  @override
  List<Object> get props => [];
}

class GetTransactionsByUserId extends GetTransactionsByUserIdEvent {
  final String userId;

  const GetTransactionsByUserId(this.userId);

  @override
  List<Object> get props => [userId];
}