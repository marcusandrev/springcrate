part of 'get_transactions_bloc.dart';

sealed class GetTransactionsState extends Equatable {
  const GetTransactionsState();
  
  @override
  List<Object> get props => [];
}

final class GetTransactionsInitial extends GetTransactionsState {}

final class GetTransactionsLoading extends GetTransactionsState {}
final class GetTransactionsFailure extends GetTransactionsState {}
final class GetTransactionsSuccess extends GetTransactionsState {
  final List<Transactions> transactions;
   final Map<String, int> monthlySales;
   final Map<String, int> netSalesByVehicleType;


  const GetTransactionsSuccess(this.transactions, this.monthlySales, this.netSalesByVehicleType);

  @override
  List<Object> get props => [transactions, monthlySales, netSalesByVehicleType];
}
