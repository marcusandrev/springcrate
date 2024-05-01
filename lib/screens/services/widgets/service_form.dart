import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class ServiceForm extends StatefulWidget {
  const ServiceForm({super.key, required this.context});

  final BuildContext context;
  @override
  ServiceFormState createState() {
    return ServiceFormState();
  }
}

class ServiceFormState extends State<ServiceForm> {
  final _formKey = GlobalKey<FormState>();
  final List<dynamic> _promoItems = ['wash', 'vacuum', 'tire black', 'blower'];
  final _vehicleTypes = ['sedan', 'suv', 'van', 'pickup', 'motorcycle'];
  final _vehicleSizes = ['small', 'medium', 'large'];

  dynamic _selectedPromos = [];

  String _serviceName = '';
  String _vehicleType = '';
  String _vehicleSize = '';
  double _cost = 0;

  void _clear() {}

  void _onSubmit() {
    // TODO: Add logic for adding document to firebase
    final promos =
        _selectedPromos.map((promo) => promo.toUpperCase()).join(', ');

    print(
        "Service Name: $_serviceName\nPromos: $promos\nService Cost: $_cost\nVehile Type: $_vehicleType\nVehicle Size: $_vehicleSize");
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
                  'Service Details',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                TextFormField(
                  decoration: const InputDecoration(
                      alignLabelWithHint: true,
                      contentPadding: EdgeInsets.symmetric(vertical: 10),
                      border: UnderlineInputBorder(),
                      labelText: 'Enter Service Name'),
                  onChanged: (value) {
                    _serviceName = value;
                  },
                ),
                const SizedBox(height: 16.0),
                const Text(
                  'Select Promos',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                MultiSelectChipField(
                    showHeader: false,
                    chipColor: const Color(0x00000000),
                    textStyle: const TextStyle(color: Colors.black),
                    decoration: const BoxDecoration(border: null),
                    title: const Text('Select Promos'),
                    icon: const Icon(Icons.check),
                    items: _promoItems
                        .map((item) => MultiSelectItem(item, item))
                        .toList(),
                    headerColor: const Color(0x00000000),
                    onTap: (List<dynamic>? values) {
                      _selectedPromos = values;
                    }),
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
                TextFormField(
                  decoration: const InputDecoration(
                      border: UnderlineInputBorder(), labelText: 'Enter Cost'),
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  onChanged: (value) {
                    if (value != '') {
                      _cost = double.parse(value);
                    } else {
                      _cost = 0;
                    }
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
                      child: const Text('Add Service')),
                )
              ],
            )));
  }
}
