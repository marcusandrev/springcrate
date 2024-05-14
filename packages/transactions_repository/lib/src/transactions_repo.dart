import 'models/models.dart';

abstract class TransactionsRepo {
  Future<List<Transactions>> getTransactions();
  Future<void> createTransactions(Transactions transactions);
  Future<void> updateTransaction(Transactions transactions);
}
