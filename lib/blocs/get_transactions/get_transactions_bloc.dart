import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart';
import 'package:transactions_repository/transactions_repository.dart';
import 'package:springcrate/util/save_file_mobile.dart'
    if (dart.library.html) 'package:springcrate/util/save_file_web.dart';

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
        Map<String, int> netSalesByVehicleType =
            calculateNetSalesByVehicleType(transactions);
        print("Net Sales by Vehicle Type:");
        netSalesByVehicleType.forEach((vehicleType, netSales) {
          print("$vehicleType: Php ${netSales.toString()}");
        });
        emit(GetTransactionsSuccess(
            transactions, monthlySales, netSalesByVehicleType));
      } catch (e) {
        print(e);
        emit(GetTransactionsFailure());
      }
    });

    on<SearchTransactions>((event, emit) async {
      emit(GetTransactionsLoading());
      try {
        List<Transactions> transactions =
            await _transactionsRepo.getQueriedTransactions(event.query);
        Map<String, int> monthlySales =
            calculateMonthlyGrossSales(transactions);
        Map<String, int> netSalesByVehicleType =
            calculateNetSalesByVehicleType(transactions);
        print("Net Sales by Vehicle Type:");
        netSalesByVehicleType.forEach((vehicleType, netSales) {
          print("$vehicleType: Php ${netSales.toString()}");
        });
        emit(GetTransactionsSuccess(
            transactions, monthlySales, netSalesByVehicleType));
      } catch (e) {
        print(e);
        emit(GetTransactionsFailure());
      }
    });

    on<GetDailyEmployeeTransactions>((event, emit) async {
      emit(GetTransactionsLoading());
      try {
        List<Transactions> transactions =
            await _transactionsRepo.getDailyEmployeeTransactions();
        Map<String, int> monthlySales =
            calculateMonthlyGrossSales(transactions);
        Map<String, int> netSalesByVehicleType =
            calculateNetSalesByVehicleType(transactions);
        netSalesByVehicleType.forEach((vehicleType, netSales) {
          print("$vehicleType: Php ${netSales.toString()}");
        });
        emit(GetTransactionsSuccess(
            transactions, monthlySales, netSalesByVehicleType));
      } catch (e) {
        emit(GetTransactionsFailure());
      }
    });

    on<ExportDailyEmployeeTransactions>((event, emit) async {
      emit(GetTransactionsLoading());
      @override
      final DateFormat dateFormatter = DateFormat('yyyy-MM-dd');
      final DateFormat hourFormatter = DateFormat('hh:mm');
      final Workbook workbook = Workbook();
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
        for (Transactions transaction in event.transactions) {
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
        emit(GetTransactionsFailure());
      }
    });
  }

  Map<String, int> calculateMonthlyGrossSales(List<Transactions> transactions) {
    final Map<String, int> monthlySales = {};

    for (var transaction in transactions) {
      final String endDateString = transaction.endDate;

      try {
        DateTime.parse(endDateString);
      } catch (e) {
        print(e);
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

  Map<String, int> calculateNetSalesByVehicleType(
      List<Transactions> transactions) {
    // Initialize the map with all vehicle types and zero values
    final Map<String, int> netSalesByVehicleType = {
      'sedan': 0,
      'suv': 0,
      'van': 0,
      'pickup': 0,
      'motorcycle': 0,
    };

    for (var transaction in transactions) {
      final String endDateString = transaction.endDate;
      try {
        DateTime.parse(endDateString);
      } catch (e) {
        print(e);
        continue;
      }

      final String vehicleType = transaction.vehicleType
          .toLowerCase(); // Ensure consistency in vehicle type keys
      final int cost = transaction.cost;

      // Update the value for the corresponding vehicle type
      netSalesByVehicleType[vehicleType] =
          (netSalesByVehicleType[vehicleType] ?? 0) + cost;
    }

    return netSalesByVehicleType;
  }
}
