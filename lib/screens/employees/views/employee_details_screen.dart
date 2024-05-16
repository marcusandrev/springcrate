import 'package:flutter/material.dart';
import 'package:user_repository/user_repository.dart';

class EmployeeDetailsScreen extends StatelessWidget {
  const EmployeeDetailsScreen({super.key, required this.myUsers});

  final MyUser myUsers;

  @override
  Widget build(BuildContext context) {
    final employeeDetailItems = [
      [
        _buildDetailWidget(context, 'Employee Name', myUsers.name),
        _buildDetailWidget(context, 'Employee Rate', myUsers.rate),
        _buildDetailWidget(context, 'Contact Number', myUsers.contactNumber),
      ]
    ];
    return Scaffold(
        appBar: AppBar(title: Text('Employees > ${myUsers.userId}')),
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
                    _buildDetailWidget(context, 'Address', myUsers.address),
                  ],
                )
              ],
            )));
  }
}

Widget _buildDetailWidget(BuildContext context, String label, String value) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        label,
        style: TextStyle(
            color: Colors.grey[800], fontSize: 16, fontWeight: FontWeight.bold),
      ),
      Text(
        value,
        style: TextStyle(color: Colors.grey[800], fontSize: 14),
      )
    ],
  );
}
