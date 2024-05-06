import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:springcrate/data/data.dart';
import 'package:springcrate/screens/services/class_def/service.dart';

class TransactionForm extends StatefulWidget {
  const TransactionForm({super.key, required this.context});

  final BuildContext context;
  @override
  TransactionFormState createState() {
    return TransactionFormState();
  }
}

class TransactionFormState extends State<TransactionForm> {
  final _formKey = GlobalKey<FormState>();
  // TODO: Get services from server backend
  // final _services = [
  //   'wash',
  //   'wash & hand wax',
  //   'hand wax - interior',
  // ];

  String _plateNo = '';
  String _serviceType = '';

  void _clear() {
    _plateNo = '';
  }

  void _onSubmit() {
    // TODO: Add logic for adding document to firebase
    print('Plate No. $_plateNo\nService: $_serviceType');
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
                  'Transaction Details',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                TextFormField(
                  decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'Enter Plate number'),
                  onChanged: (value) {
                    _plateNo = value;
                  },
                ),
                const SizedBox(height: 16.0),
                DropdownButtonFormField(
                    decoration: const InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: 'Select a service'),
                    items: servicesData.map((Service service) {
                      return DropdownMenuItem(
                          value: service.serviceName,
                          child: Row(children: [Text(service.serviceName)]));
                    }).toList(),
                    onChanged: (value) {
                      _serviceType = value!;
                    }),
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
                      child: const Text('Add Transaction')),
                )
              ],
            )));
  }
}
