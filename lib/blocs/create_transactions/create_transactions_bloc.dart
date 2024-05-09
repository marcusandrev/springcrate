import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:transactions_repository/transactions_repository.dart';

part 'create_transactions_event.dart';
part 'create_transactions_state.dart';

class CreateTransactionsBloc
    extends Bloc<CreateTransactionsEvent, CreateTransactionsState> {
  final TransactionsRepo transactionsRepo;

  CreateTransactionsBloc({required this.transactionsRepo})
      : super(CreateTransactionsInitial()) {
    on<CreateTransactions>((event, emit) async {
      emit(CreateTransactionsLoading());
      try {
        await transactionsRepo.createTransactions(event.transactions);
        emit(CreateTransactionsSuccess());
      } catch (e) {
        emit(CreateTransactionsFailure());
      }
    });
  }
}
