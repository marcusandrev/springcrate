import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:springcrate/blocs/get_transactions/get_transactions_bloc.dart';
import 'package:springcrate/screens/home/chart.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:springcrate/screens/home/widgets/export_form.dart';
import 'package:springcrate/util/string_utils.dart';
import 'package:transactions_repository/transactions_repository.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetTransactionsBloc(FirebaseTransactionsRepo())
        ..add(GetTransactions()),
      child: const _MainScreen(),
    );
  }
}

class _MainScreen extends StatelessWidget {
  const _MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Map<String, String> vehicleIcons = {
      'sedan': 'lib/assets/sedan.svg',
      'suv': 'lib/assets/suv.svg',
      'pickup': 'lib/assets/pickup.svg',
      'motorcycle': 'lib/assets/motorbike.svg',
      'van': 'lib/assets/motorbike.svg',
    };
    return BlocBuilder<GetTransactionsBloc, GetTransactionsState>(
      builder: (context, state) {
        if (state is GetTransactionsLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is GetTransactionsSuccess) {
          final monthlySales = state.monthlySales;
          final netSalesByVehicleType = state.netSalesByVehicleType;

          return Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 14.0, horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "2024",
                          style:
                              TextStyle(fontSize: 12, color: Colors.grey[600]),
                        ),
                        Text(
                          "Gross Sales",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ],
                    ),
                    ElevatedButton(
                      onPressed: () {
                        showModalBottomSheet(
                            context: context,
                            builder: (BuildContext context) {
                              return const Wrap(
                                children: [ExportForm()],
                              );
                            });
                      },
                      child: const Text('Export'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            Theme.of(context).colorScheme.secondary,
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.width,
                  child: MyChart(
                    monthlySales: monthlySales,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Net Sales",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                        Text(
                          "per vehicle",
                          style:
                              TextStyle(fontSize: 12, color: Colors.grey[600]),
                        ),
                      ],
                    ),
                    const Icon(
                      Icons.filter_list,
                      color: Colors.blue,
                      size: 24.0,
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      for (var entry in netSalesByVehicleType.entries)
                        _buildCard(
                          context,
                          vehicleIcons[entry.key]!,
                          StringUtils.capitalize(entry.key),
                          entry.value,
                        ),
                    ],
                  ),
                ),
              ],
            ),
          );
        } else {
          return const Center(child: Text("An error has occurred..."));
        }
      },
    );
  }

  Widget _buildCard(
    BuildContext context,
    String iconPath,
    String vehicleType,
    int netSales,
  ) {
    Color primaryColor = Theme.of(context).primaryColor;
    if (vehicleType.toLowerCase() == "motorcycle") {
      vehicleType = "MOTORBIKE";
    }
    return Card(
      elevation: 4,
      child: Container(
        width: 320,
        height: 170,
        padding: EdgeInsets.all(12),
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(iconPath,
                width: 26, height: 26, color: primaryColor),
            Text(
              vehicleType,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "Php $netSales",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
