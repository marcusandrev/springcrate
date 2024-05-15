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
        Map<String, int> netSalesByVehicleType =
            calculateNetSalesByVehicleType(transactions);
        print("Net Sales by Vehicle Type:");
        netSalesByVehicleType.forEach((vehicleType, netSales) {
          print("$vehicleType: Php ${netSales.toString()}");
        });
        emit(GetTransactionsSuccess(
            transactions, monthlySales, netSalesByVehicleType));
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
    if (endDateString == "0000-00-00000:00:00.000000") {
      continue;
    }

    final String vehicleType = transaction.vehicleType.toLowerCase(); // Ensure consistency in vehicle type keys
    final int cost = transaction.cost;

    // Update the value for the corresponding vehicle type
    netSalesByVehicleType[vehicleType] =
        (netSalesByVehicleType[vehicleType] ?? 0) + cost;
  }

  return netSalesByVehicleType;
}
}
