import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:transactions_repository/transactions_repository.dart';

part 'delete_transactions_event.dart';
part 'delete_transactions_state.dart';

class DeleteTransactionsBloc extends Bloc<DeleteTransactionsEvent, DeleteTransactionsState> {
  final TransactionsRepo transactionsRepo;

  DeleteTransactionsBloc({required this.transactionsRepo}) : super(DeleteTransactionsInitial());

  @override
  Stream<DeleteTransactionsState> mapEventToState(DeleteTransactionsEvent event) async* {
    if (event is DeleteTransaction) {
      yield* _mapDeleteTransactionToState(event);
    }
  }

  Stream<DeleteTransactionsState> _mapDeleteTransactionToState(DeleteTransaction event) async* {
    yield DeleteTransactionsLoading();
    try {
      await transactionsRepo.deleteTransaction(event.transactionId);
      yield DeleteTransactionsSuccess();
    } catch (e) {
      yield DeleteTransactionsFailure();
    }
  }
}
