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
        emit(GetTransactionsSuccess(transactions));
      } catch (e) {
        emit(GetTransactionsFailure());
      }
    });
  }
}
