import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:services_repository/services_repository.dart';
import 'package:springcrate/blocs/create_services/create_services_bloc.dart';
// import 'package:springcrate/screens/services/class_def/service.dart';

class ServiceForm extends StatelessWidget {
  const ServiceForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CreateServicesBloc(
        serviceRepo: FirebaseServiceRepo(),
      ),
      child: _ServiceForm(),
    );
  }
}

class _ServiceForm extends StatefulWidget {
  // const ServiceForm({super.key});

  // @override
  // ServiceFormState createState() {
  //   return ServiceFormState();
  // }
  @override
  _ServiceFormState createState() => _ServiceFormState();
}

class _ServiceFormState extends State<_ServiceForm> {
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

  // dynamic _selectedPromos = [];

  // String _serviceName = '';
  // String _vehicleType = '';
  // String _vehicleSize = '';
  // double _cost = 0;

  // void _clear() {}

  // void _onSubmit() {
  //   // TODO: Add logic for adding document to firebase
  //   final promos =
  //       _selectedPromos.map((promo) => promo.toUpperCase()).join(', ');

  //   print(
  //       "Service Name: $_serviceName\nPromos: $promos\nService Cost: $_cost\nVehile Type: $_vehicleType\nVehicle Size: $_vehicleSize");
  //   Navigator.pop(context);
  // }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CreateServicesBloc, CreateServicesState>(
        listener: (context, state) {
          if (state is CreateServicesSuccess) {
            setState(() {
              creationRequired = false;
            });
          } else if (state is CreateServicesLoading) {
            setState(() {
              creationRequired = true;
            });
          } else if (state is CreateServicesFailure) {
            return;
          }
        },
        child: Form(
            key: _formKey,
            child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Service Details',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
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
                          border: UnderlineInputBorder(),
                          labelText: 'Enter Cost'),

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
                                    context
                                        .read<CreateServicesBloc>()
                                        .add(CreateServices(service));
                                  }
                                },
                                style: TextButton.styleFrom(
                                    elevation: 3.0,
                                    backgroundColor:
                                        Theme.of(context).colorScheme.primary,
                                    foregroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(60))),
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
                  ],
                ))));
  }
}
