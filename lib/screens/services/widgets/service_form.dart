import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:services_repository/services_repository.dart';
// import 'package:springcrate/screens/services/class_def/service.dart';

class ServiceForm extends StatefulWidget {
  const ServiceForm({super.key, required this.context});

  final BuildContext context;
  @override
  ServiceFormState createState() {
    return ServiceFormState();
  }
}

class ServiceFormState extends State<ServiceForm> {
  final serviceNameController = TextEditingController();
  final serviceCostController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final List<dynamic> _promoItems = ['wash', 'vacuum', 'tire black', 'blower'];
  final _vehicleTypes = ['sedan', 'suv', 'van', 'pickup', 'motorcycle'];
  final _vehicleSizes = ['small', 'medium', 'large'];

  bool creationRequired = false;
  late Services service;

  @override
  void initState() {
    service = Services.empty;
    super.initState();
  }

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
                  controller: serviceNameController,
                  obscureText: false,
                  keyboardType: TextInputType.text,
                  validator: (val) {
                    if (val!.isEmpty) {
                      return 'Please fill in this field';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                      alignLabelWithHint: true,
                      contentPadding: EdgeInsets.symmetric(vertical: 10),
                      border: UnderlineInputBorder(),
                      labelText: 'Enter Service Name'),
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
                  // onTap: (List<dynamic>? values) {
                  //   _selectedPromos = values;
                  // }
                  onTap: (dynamic value) {
                    setState(() {
                      // Update service.promo with the selected promo
                      service.promo =
                          value.toString(); // Convert value to String
                    });
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
                    setState(() {
                      service.vehicleType =
                          value.toString(); // Convert value to String
                    });
                  },
                ),
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
                    setState(() {
                      service.vehicleSize = value.toString();
                    });
                  },
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  decoration: const InputDecoration(
                      border: UnderlineInputBorder(), labelText: 'Enter Cost'),

                  controller: serviceCostController,
                  obscureText: false,
                  keyboardType: TextInputType.number,
                  validator: (val) {
                    if (val!.isEmpty) {
                      return 'Please fill in this field';
                    }
                    return null;
                  },
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  // onChanged: (value) {
                  //   if (value != '') {
                  //     _cost = double.parse(value);
                  //   } else {
                  //     _cost = 0;
                  //   }
                  // },
                ),
                const SizedBox(height: 20.0),
                !creationRequired
                    ? SizedBox(
                        width: double.infinity,
                        child: TextButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                setState(() {
                                  service.serviceName =
                                      serviceNameController.text;
                                  service.cost =
                                      int.parse(serviceCostController.text);
                                });
                                print(service.toString());
                              }
                            },
                            style: TextButton.styleFrom(
                                elevation: 3.0,
                                backgroundColor:
                                    Theme.of(context).colorScheme.primary,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(60))),
                            child: const Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 25, vertical: 5),
                              child: Text(
                                'Add Service',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600),
                              ),
                            )),
                      )
                    : const CircularProgressIndicator(),
                // SizedBox(
                //   width: double.infinity,
                //   height: 45,
                //   child: ElevatedButton(
                //       style: ButtonStyle(
                //           shape: MaterialStateProperty.all(
                //               RoundedRectangleBorder(
                //                   borderRadius: BorderRadius.circular(10))),
                //           backgroundColor:
                //               MaterialStateProperty.all(Colors.blue),
                //           foregroundColor:
                //               MaterialStateProperty.all(Colors.white)),
                //       onPressed: _onSubmit,
                //       child: const Text('Add Service')),
                // )
              ],
            )));
  }
}
