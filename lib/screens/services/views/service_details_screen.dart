import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:services_repository/services_repository.dart';
import 'package:springcrate/blocs/create_services/create_services_bloc.dart';

class ServiceDetailsScreen extends StatelessWidget {
  const ServiceDetailsScreen({Key? key, required this.services})
      : super(key: key);

  final Services services;

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: BlocProvider.of<CreateServicesBloc>(context),
      child: _ServiceDetailsScreen(services: services),
    );
  }
}

class _ServiceDetailsScreen extends StatelessWidget {
  const _ServiceDetailsScreen({super.key, required this.services});

  final Services services;

  String _formatPromo(dynamic promo) {
    if (promo is List<dynamic>) {
      return promo.join(', ');
    } else if (promo is String) {
      if (promo.startsWith('[') && promo.endsWith(']')) {
        return promo.substring(1, promo.length - 1);
      } else {
        return promo;
      }
    } else {
      return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    final serviceDetailItems = [
      _buildDetailWidget(context, 'Service Name', services.serviceName),
      _buildDetailWidget(context, 'Vehicle Type', services.vehicleType),
      _buildDetailWidget(context, 'Vehicle Size', services.vehicleSize),
      _buildDetailWidget(context, 'Service Cost', '${services.cost}'),
      _buildDetailWidget(context, 'Promo', _formatPromo(services.promo)),
    ];

    return BlocListener<CreateServicesBloc, CreateServicesState>(
      listener: (context, state) {
        if (state is UpdateServiceSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Transaction updated successfully')),
          );
        } else if (state is UpdateServiceFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Failed to update transaction')),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
              'Service > ${services.serviceName} - ${services.vehicleType.toUpperCase()}'),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildDetailWidget(context, 'Service ID', services.serviceId),
                  const SizedBox(height: 20),
                  GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 3.5,
                    ),
                    itemCount: serviceDetailItems.length,
                    itemBuilder: ((context, index) =>
                        serviceDetailItems[index]),
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: ElevatedButton(
                      onPressed: () => _showEditServiceDialog(context),
                      child: const Text('Edit Service'),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
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
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          value,
          style: TextStyle(color: Colors.grey[800], fontSize: 14),
        ),
      ],
    );
  }

  void _showEditServiceDialog(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final TextEditingController _serviceNameController =
        TextEditingController(text: services.serviceName);
    final TextEditingController _serviceCostController =
        TextEditingController(text: services.cost.toString());
    String _selectedVehicleType = services.vehicleType;
    String _selectedVehicleSize = services.vehicleSize;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Service'),
          content: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: _serviceNameController,
                  decoration: const InputDecoration(labelText: 'Service Name'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a service name';
                    }
                    return null;
                  },
                ),
                DropdownButtonFormField<String>(
                  value: _selectedVehicleType,
                  decoration: const InputDecoration(labelText: 'Vehicle Type'),
                  items: ['sedan', 'suv', 'van', 'pickup', 'motorcycle']
                      .map((type) => DropdownMenuItem(
                            value: type,
                            child: Text(type),
                          ))
                      .toList(),
                  onChanged: (value) {
                    if (value != null) {
                      _selectedVehicleType = value;
                    }
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select a vehicle type';
                    }
                    return null;
                  },
                ),
                DropdownButtonFormField<String>(
                  value: _selectedVehicleSize,
                  decoration: const InputDecoration(labelText: 'Vehicle Size'),
                  items: ['small', 'medium', 'large']
                      .map((size) => DropdownMenuItem(
                            value: size,
                            child: Text(size),
                          ))
                      .toList(),
                  onChanged: (value) {
                    if (value != null) {
                      _selectedVehicleSize = value;
                    }
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select a vehicle size';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _serviceCostController,
                  decoration: const InputDecoration(labelText: 'Service Cost'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a service cost';
                    }
                    if (double.tryParse(value) == null) {
                      return 'Please enter a valid number';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  final newService = services.copyWith(
                    serviceName: _serviceNameController.text,
                    vehicleType: _selectedVehicleType,
                    vehicleSize: _selectedVehicleSize,
                    cost: int.parse(_serviceCostController.text),
                  );
                  context
                      .read<CreateServicesBloc>()
                      .add(UpdateService(newService));
                  Navigator.of(context).pop();
                }
              },
              child: const Text('Submit'),
            ),
          ],
        );
      },
    );
  }
}
