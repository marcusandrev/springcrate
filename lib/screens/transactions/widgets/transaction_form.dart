import 'package:flutter/material.dart';

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
  final _vehicleTypes = ['sedan', 'suv', 'van', 'pickup', 'motorcycle'];
  final _vehicleSizes = ['small', 'medium', 'large'];
  // TODO: Get services from server backend
  final _services = [
    'wash',
    'wash & hand wax',
    'hand wax - interior',
  ];

  String _plateNo = '';
  String _vehicleType = '';
  String _vehicleSize = '';
  String _serviceType = '';

  void _clear() {
    _plateNo = '';
  }

  void _onSubmit() {
    // TODO: Add logic for adding document to firebase
    print(
        'Plate No. $_plateNo\nVehicle Type $_vehicleType\nVehicle Size $_vehicleSize\nService Type $_serviceType');
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
                        labelText: 'Select a vehicle type'),
                    items: _vehicleTypes.map((String vehicleType) {
                      return DropdownMenuItem(
                          value: vehicleType,
                          child: Row(children: [Text(vehicleType)]));
                    }).toList(),
                    onChanged: (value) {
                      _vehicleType = value!;
                    }),
                const SizedBox(height: 16.0),
                DropdownButtonFormField(
                    decoration: const InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: 'Select a vehicle size'),
                    items: _vehicleSizes.map((String vehicleSize) {
                      return DropdownMenuItem(
                          value: vehicleSize,
                          child: Row(children: [Text(vehicleSize)]));
                    }).toList(),
                    onChanged: (value) {
                      _vehicleSize = value!;
                    }),
                const SizedBox(height: 16.0),
                DropdownButtonFormField(
                    decoration: const InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: 'Select a service'),
                    items: _services.map((String serviceType) {
                      return DropdownMenuItem(
                          value: serviceType,
                          child: Row(children: [Text(serviceType)]));
                    }).toList(),
                    onChanged: (value) {
                      _serviceType = value!;
                    }),
                const SizedBox(height: 20.0),
                Container(
                  margin: const EdgeInsets.all(8.0),
                  width: double.infinity,
                  height: 40,
                  child: ElevatedButton(
                      style: ButtonStyle(
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
