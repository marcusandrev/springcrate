import 'package:flutter/material.dart';
import 'package:springcrate/data/data.dart';
import 'package:springcrate/screens/employees/class_def/employee.dart';

class AssignForm extends StatefulWidget {
  const AssignForm({super.key, required this.context});

  final BuildContext context;
  @override
  AssignFormState createState() {
    return AssignFormState();
  }
}

class AssignFormState extends State<AssignForm> {
  final _formKey = GlobalKey<FormState>();
  final _employees = employeesData;

  String _employeeID = '';

  void _clear() {
    _employeeID = '';
  }

  void _getActiveEmployees() {
    // TODO: Fetch active employees from DB
  }

  void _onSubmit() {
    // TODO: Add logic for adding document to firebase
    print("Selected Employee $_employeeID");
    _clear();
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Active Employees',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                DropdownButtonFormField(
                    decoration: const InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: 'Select an employee'),
                    items: _employees.map((Employee employee) {
                      return DropdownMenuItem(
                          value: employee.employeeID,
                          child: Row(children: [Text(employee.employeeName)]));
                    }).toList(),
                    onChanged: (value) {
                      _employeeID = value!;
                    }),
                const SizedBox(height: 20.0),
                Container(
                  margin: const EdgeInsets.all(8.0),
                  width: double.infinity,
                  height: 40,
                  child: ElevatedButton(
                      style: ButtonStyle(
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10))),
                          backgroundColor:
                              MaterialStateProperty.all(Colors.orange),
                          foregroundColor:
                              MaterialStateProperty.all(Colors.white)),
                      onPressed: _onSubmit,
                      child: const Text('Start Transaction')),
                )
              ],
            )));
  }
}
