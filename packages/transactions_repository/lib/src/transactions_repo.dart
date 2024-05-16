import 'models/models.dart';

abstract class TransactionsRepo {
  Future<List<Transactions>> getTransactions();
  Future<List<Transactions>> getQueriedTransactions(String search);
  Future<void> createTransactions(Transactions transactions);
  Future<void> updateTransaction(Transactions transactions);

  Future<List<Transactions>> getTransactionsByUserId(String userId);
}
