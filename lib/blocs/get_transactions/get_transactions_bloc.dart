import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:transactions_repository/transactions_repository.dart';

part 'get_transactions_event.dart';
part 'get_transactions_state.dart';

class GetTransactionsBloc
    extends Bloc<GetTransactionsEvent, GetTransactionsState> {
  final TransactionsRepo _transactionsRepo;

  GetTransactionsBloc(this._transactionsRepo)
      : super(GetTransactionsInitial()) {
    on<GetTransactions>((event, emit) async {
      emit(GetTransactionsLoading());
      try {
        List<Transactions> transactions =
            await _transactionsRepo.getTransactions();
        Map<String, int> monthlySales =
            calculateMonthlyGrossSales(transactions);
        emit(GetTransactionsSuccess(transactions, monthlySales));
      } catch (e) {
        emit(GetTransactionsFailure());
      }
    });
  }

  Map<String, int> calculateMonthlyGrossSales(List<Transactions> transactions) {
    final Map<String, int> monthlySales = {};

    for (var transaction in transactions) {
      final String endDateString = transaction.endDate;
      if (endDateString == "0000-00-00000:00:00.000000") {
        continue;
      }

      final DateTime endDate = DateTime.parse(endDateString);
      final int cost = transaction.cost;

      final String monthKey =
          '${endDate.year}-${endDate.month.toString().padLeft(2, '0')}';

      if (monthlySales.containsKey(monthKey)) {
        monthlySales[monthKey] = monthlySales[monthKey]! + cost;
      } else {
        monthlySales[monthKey] = cost;
      }
    }

    return monthlySales;
  }
}
