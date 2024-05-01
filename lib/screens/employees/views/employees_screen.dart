import 'package:flutter/material.dart';
import 'package:springcrate/screens/employees/class_def/employee.dart';
import 'package:springcrate/screens/employees/views/employee_details_screen.dart';
import 'package:springcrate/util/employee_utils.dart';
import 'package:springcrate/widgets/searchbar.dart';
import 'package:springcrate/data/data.dart';

class EmployeesScreen extends StatelessWidget {
  const EmployeesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 20),
          Searchbar(
            borderColor: Theme.of(context).colorScheme.primary,
            iconColor: Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(height: 20),
          SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                for (var data in employeesData)
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, _createRoute(context, data));
                    },
                    child: _buildTransactionsCard(context, data),
                  )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionsCard(BuildContext context, Employee employee) {
    Color primaryColor = Theme.of(context).primaryColor;
    Color secondaryColor = Theme.of(context).colorScheme.secondary;
    return Card(
      elevation: 4,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              employee.employeeName,
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: primaryColor),
            ),
            const SizedBox(height: 4.0),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.only(right: 32),
                  child: Column(children: [
                    const Text(
                      'Contact No.',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Text(employee.contactNo)
                  ]),
                ),
                const SizedBox(height: 16),
                Column(children: [
                  const Text(
                    'Rate',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text(EmployeeUtils.stringifyRate(employee.rate))
                ])
              ],
            ),
            const SizedBox(height: 4.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(
                      Icons.chevron_right,
                      color: secondaryColor,
                    ),
                    TextButton(
                      onPressed: null, // Add functionality here
                      child: Text(
                        'More info',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: secondaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Route _createRoute(BuildContext context, Employee employee) {
    return PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            EmployeeDetailsScreen(employee: employee),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0);
          const end = Offset.zero;
          const curve = Curves.ease;

          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        });
  }
}
