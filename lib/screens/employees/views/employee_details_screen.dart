import 'package:flutter/material.dart';
import 'package:springcrate/screens/employees/class_def/employee.dart';

class EmployeeDetailsScreen extends StatelessWidget {
  const EmployeeDetailsScreen({super.key, required this.employee});

  final Employee employee;

  @override
  Widget build(BuildContext context) {
    final status = employee.status == 0 ? 'Inactive' : 'Active';

    final employeeDetailItems = [
      [
        _buildDetailWidget(context, 'Employee Name', employee.employeeName),
        _buildDetailWidget(context, 'Employee Rate', employee.rate),
        _buildDetailWidget(context, 'Contact Number', employee.contactNo),
        _buildDetailWidget(context, 'Employee Status', status),
      ]
    ];
    return Scaffold(
        appBar: AppBar(title: Text('Employees > ${employee.employeeName}')),
        bottomNavigationBar: BottomAppBar(
          height: 75,
          surfaceTintColor: Colors.grey.shade100,
          child: _buildActionButton(context),
        ),
        body: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2, childAspectRatio: 3.5),
                      itemCount: employeeDetailItems[0].length,
                      itemBuilder: ((context, index) =>
                          employeeDetailItems[0][index]),
                    ),
                    _buildDetailWidget(context, 'Address', employee.address),
                    const Divider(height: 4, thickness: 1, color: Colors.grey),
                    Text(
                      'Recent Transactions',
                      style: TextStyle(
                          color: Colors.grey[800],
                          fontSize: 24,
                          fontWeight: FontWeight.bold),
                    ),
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: 3,
                      itemBuilder: ((context, index) =>
                          _buildRecenTransactionsCard(context)),
                    )
                  ],
                )
              ],
            )));
  }

  Widget _buildActionButton(BuildContext context) {
    dynamic actionButtonText;
    dynamic color;
    if (employee.status == 0) {
      actionButtonText = 'Activate';
      color = Colors.green;
    } else {
      actionButtonText = 'Deactivate';
      color = Colors.red;
    }

    return ElevatedButton(
        style: ButtonStyle(
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10))),
            backgroundColor: MaterialStateProperty.all(color),
            foregroundColor: MaterialStateProperty.all(Colors.white)),
        onPressed: () {},
        child: Text(actionButtonText));
  }

  Widget _buildDetailWidget(BuildContext context, String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
              color: Colors.grey[800],
              fontSize: 16,
              fontWeight: FontWeight.bold),
        ),
        Text(
          value,
          style: TextStyle(color: Colors.grey[800], fontSize: 14),
        )
      ],
    );
  }

  Widget _buildRecenTransactionsCard(BuildContext context) {
    return Card(
      child: const Text('Nyelow'),
    );
  }
}
