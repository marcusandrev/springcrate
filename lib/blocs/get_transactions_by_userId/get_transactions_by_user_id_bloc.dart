import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:transactions_repository/transactions_repository.dart';

part 'get_transactions_by_user_id_event.dart';
part 'get_transactions_by_user_id_state.dart';

class GetTransactionsByUserIdBloc
    extends Bloc<GetTransactionsByUserIdEvent, GetTransactionsByUserIdState> {
  final TransactionsRepo _transactionsRepo;
  GetTransactionsByUserIdBloc(this._transactionsRepo)
      : super(GetTransactionsByUserIdInitial()) {
    on<GetTransactionsByUserId>((event, emit) async {
      final userId = event.userId;

      emit(GetTransactionsByUserIdLoading());
      try {
        List<Transactions> transactions =
            await _transactionsRepo.getTransactionsByUserId(userId);
              

        emit(GetTransactionsByUserIdSuccess(transactions));
      } catch (e) {
        print(e);
        emit(GetTransactionsByUserIdFailure());
      }
    });
  }
}
