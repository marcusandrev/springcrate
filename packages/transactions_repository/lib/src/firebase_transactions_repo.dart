import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:transactions_repository/src/entities/transactions_entity.dart';
import 'package:transactions_repository/transactions_repository.dart';

class FirebaseTransactionsRepo implements TransactionsRepo {
  final transactionsCollection =
      FirebaseFirestore.instance.collection('transactions');

  @override
  Future<List<Transactions>> getTransactions() async {
    try {
      return await transactionsCollection.get().then((value) => value.docs
          .map((e) => Transactions.fromEntity(
              TransactionsEntity.fromDocument(e.data())))
          .toList());
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<List<Transactions>> getQueriedTransactions(String search) async {
    final transactionsCollection = FirebaseFirestore.instance
        .collection('transactions')
        .where('plateNumber', isGreaterThanOrEqualTo: search)
        .where('plateNumber', isLessThan: '${search}z');
    try {
      return await transactionsCollection.get().then((value) => value.docs
          .map((e) => Transactions.fromEntity(
              TransactionsEntity.fromDocument(e.data())))
          .toList());
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<List<Transactions>> getDailyEmployeeTransactions() async {
    final DateFormat dateFormatter = DateFormat('yyyy-MM-dd');
    var today = dateFormatter.format(DateTime.now());

    final transactionsCollection = FirebaseFirestore.instance
        .collection('transactions')
        .where('status', isEqualTo: "Completed")
        .where('endDate', isGreaterThanOrEqualTo: today)
        .where('endDate', isLessThan: '${today}z');

    try {
      final test = await transactionsCollection.get().then((value) => value.docs
          .map((e) => Transactions.fromEntity(
              TransactionsEntity.fromDocument(e.data())))
          .toList());
      print(test);
      return await transactionsCollection.get().then((value) => value.docs
          .map((e) => Transactions.fromEntity(
              TransactionsEntity.fromDocument(e.data())))
          .toList());
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<void> createTransactions(Transactions transactions) async {
    try {
      return await transactionsCollection
          .doc(transactions.transactionId)
          .set(transactions.toEntity().toDocument());
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<void> updateTransaction(Transactions transactions) async {
    try {
      await transactionsCollection
          .doc(transactions.transactionId)
          .update(transactions.toEntity().toDocument());
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<List<Transactions>> getTransactionsByUserId(String userId) async {
    final transactionsCollection = FirebaseFirestore.instance
        .collection('transactions')
        .where('userId', isEqualTo: userId);
    try {
      return await transactionsCollection.get().then((value) => value.docs
          .map((e) => Transactions.fromEntity(
              TransactionsEntity.fromDocument(e.data())))
          .toList());
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}
