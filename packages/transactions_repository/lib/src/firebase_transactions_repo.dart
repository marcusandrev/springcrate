import 'dart:developer';
import 'package:syncfusion_flutter_xlsio/xlsio.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:transactions_repository/src/entities/transactions_entity.dart';
import 'package:transactions_repository/transactions_repository.dart';

//Local imports
import 'package:springcrate/util/save_file_mobile.dart'
    if (dart.library.html) 'package:springcrate/util/save_file_web.dart';

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
  Future<void> exportDailyEmployeeTransactions(
      List<Transactions> transactions) async {
    final DateFormat dateFormatter = DateFormat('yyyy-MM-dd');
    final DateFormat hourFormatter = DateFormat('hh:mm');
    final Workbook workbook = new Workbook();
    final Worksheet worksheet = workbook.worksheets[0];
    try {
      final List<String> headers = [
        "DATE",
        "VEHICLE",
        "PLATE NO",
        "IN",
        "OUT",
        "ACTIVITY",
        "NAME",
        "AMOUNT",
        // ... Add more headers as needed
      ];

      // Write headers to the first row
      for (int j = 0; j < headers.length; j++) {
        worksheet.getRangeByIndex(1, j + 1).setText(headers[j]);
        worksheet.getRangeByIndex(1, j + 1).cellStyle.bold = true;
        worksheet.getRangeByIndex(1, j + 1).columnWidth = 20;
      }

      // Write transaction data starting from the second row
      int row = 2;
      for (Transactions transaction in transactions) {
        final DateTime startDate = DateTime.parse(transaction.startDate);
        final DateTime endDate = DateTime.parse(transaction.endDate);
        // Write each transaction data to corresponding columns
        worksheet
            .getRangeByIndex(row, 1)
            .setValue(dateFormatter.format(startDate));

        worksheet
            .getRangeByIndex(row, 2)
            .setValue(transaction.vehicleType.toUpperCase());

        worksheet.getRangeByIndex(row, 3).setValue(transaction.plateNumber);

        worksheet
            .getRangeByIndex(row, 4)
            .setValue(hourFormatter.format(startDate));

        worksheet
            .getRangeByIndex(row, 5)
            .setValue(hourFormatter.format(endDate));

        worksheet.getRangeByIndex(row, 6).setValue(transaction.serviceName);

        worksheet.getRangeByIndex(row, 7).setValue(transaction.name);

        worksheet.getRangeByIndex(row, 8).setValue(transaction.cost);
        // ... Write data to corresponding columns based on your Transactions class
        row++;
      }

      final today = dateFormatter.format(DateTime.now());
      final List<int> bytes = workbook.saveAsStream();

      workbook.dispose();

      await saveAndLaunchFile(
          bytes, 'Completed Transactions as of $today.xlsx');
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
}
