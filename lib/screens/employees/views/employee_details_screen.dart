import 'package:flutter/material.dart';
import 'package:springcrate/screens/employees/class_def/employee.dart';

class EmployeeDetailsScreen extends StatelessWidget {
  const EmployeeDetailsScreen({super.key, required this.employee});

  final Employee employee;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Employees > ${employee.employeeName}')),
        body: const SingleChildScrollView(child: Text('Hello world!')));
  }
}
