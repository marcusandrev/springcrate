import 'package:flutter/material.dart';
import 'package:springcrate/data/data.dart';
import 'package:springcrate/screens/employees/class_def/employee.dart';
import 'package:springcrate/screens/transactions/class_def/transaction.dart';
import 'package:springcrate/util/employee_utils.dart';

class EmployeeDetailsScreen extends StatelessWidget {
  const EmployeeDetailsScreen({super.key, required this.employee});

  final Employee employee;

  @override
  Widget build(BuildContext context) {
    final status = employee.status == 0 ? 'Inactive' : 'Active';

    final employeeDetailItems = [
      [
        _buildDetailWidget(context, 'Employee Name', employee.employeeName),
        _buildDetailWidget(context, 'Employee Rate',
            EmployeeUtils.stringifyRate(employee.rate)),
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
                    Container(
                      padding: const EdgeInsets.only(top: 32, bottom: 16),
                      child: Text(
                        'Recent Transactions',
                        style: TextStyle(
                            color: Colors.grey[800],
                            fontSize: 24,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: transactionsData.length,
                      itemBuilder: ((context, index) =>
                          _buildRecenTransactionsCard(
                              context, transactionsData[index])),
                    )
                  ],
                )
              ],
            )));
  }

  Widget _buildActionButton(BuildContext context) {
    String actionText = EmployeeUtils.getActionText(employee.status);
    Color color = EmployeeUtils.getActionColor(employee.status);

    return ElevatedButton(
        style: ButtonStyle(
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10))),
            backgroundColor: MaterialStateProperty.all(color),
            foregroundColor: MaterialStateProperty.all(Colors.white)),
        onPressed: () {
          showModalBottomSheet<dynamic>(
              context: context,
              isScrollControlled: true,
              builder: (BuildContext context) {
                return Container(
                  padding: const EdgeInsets.all(16),
                  child: Wrap(children: [
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "You're about to ${actionText.toLowerCase()} an employee account.",
                            style: const TextStyle(
                                color: Colors.orange,
                                fontSize: 24,
                                fontWeight: FontWeight.bold),
                          ),
                          Container(
                            padding: const EdgeInsets.only(top: 12, bottom: 32),
                            child: Text(
                              "By clicking continue, you verify that you want to ${actionText.toLowerCase()} this account.",
                              style: TextStyle(color: Colors.grey.shade600),
                            ),
                          ),
                        ]),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                          onPressed: () {
                            // TODO: Add logic for updating status from on going to completed
                            Navigator.pop(context);
                          },
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10))),
                            foregroundColor:
                                MaterialStateProperty.all(Colors.white),
                            backgroundColor: MaterialStateProperty.all(color),
                            fixedSize: MaterialStateProperty.all(
                                const Size.fromHeight(45)),
                          ),
                          child: const Text('CONTINUE')),
                    )
                  ]),
                );
              });
        },
        child: Text(actionText));
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

  Widget _buildRecenTransactionsCard(
      BuildContext context, Transaction transaction) {
    return Card(
      elevation: 0,
      color: const Color(0x00000000),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Plate no: ${transaction.plateNo}',
                  style: TextStyle(
                      color: Colors.grey[800],
                      fontSize: 16,
                      fontWeight: FontWeight.bold)),
              Text('Service: ${transaction.service}'),
              Text('Commission: Php ${transaction.cost * employee.rate}')
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(
                height: 10,
              ),
              Text(transaction.endDate)
            ],
          ),
          Container(
            padding: const EdgeInsets.only(top: 16, bottom: 16),
            child: const Divider(height: 4, thickness: 1, color: Colors.grey),
          )
        ],
      ),
    );
  }
}
