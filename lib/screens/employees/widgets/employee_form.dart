import 'package:flutter/material.dart';

class EmployeeForm extends StatefulWidget {
  const EmployeeForm({super.key, required this.context});

  final BuildContext context;
  @override
  EmployeeFormState createState() {
    return EmployeeFormState();
  }
}

class EmployeeFormState extends State<EmployeeForm> {
  final _formKey = GlobalKey<FormState>();
  final _rates = ['70/30', '60/40'];

  String _employeeName = '';
  String _rate = '';
  String _contactNo = '';
  String _address = '';

  void _clear() {}

  void _onSubmit() {
    // TODO: Add logic for adding document to firebase
    print(
        'Employee Name: $_employeeName\nEmployee Rate: $_rate\nEmployee Contact Number: $_contactNo\nEmployee Address: $_address');
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
                  'Employee Details',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                TextFormField(
                  decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'Enter Employee Name'),
                  onChanged: (value) {
                    _employeeName = value;
                  },
                ),
                const SizedBox(height: 16.0),
                DropdownButtonFormField(
                    decoration: const InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: 'Select an employee rate'),
                    items: _rates.map((String rate) {
                      return DropdownMenuItem(
                          value: rate, child: Row(children: [Text(rate)]));
                    }).toList(),
                    onChanged: (value) {
                      _rate = value!;
                    }),
                const SizedBox(height: 16.0),
                TextFormField(
                  decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'Enter Contact Number'),
                  onChanged: (value) {
                    _contactNo = value;
                  },
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'Enter Address'),
                  onChanged: (value) {
                    _address = value;
                  },
                ),
                const SizedBox(height: 20.0),
                SizedBox(
                  width: double.infinity,
                  height: 45,
                  child: ElevatedButton(
                      style: ButtonStyle(
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10))),
                          backgroundColor:
                              MaterialStateProperty.all(Colors.blue),
                          foregroundColor:
                              MaterialStateProperty.all(Colors.white)),
                      onPressed: _onSubmit,
                      child: const Text('Add Employee')),
                )
              ],
            )));
  }
}
