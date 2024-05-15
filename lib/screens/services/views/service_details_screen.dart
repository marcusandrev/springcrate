import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:services_repository/services_repository.dart';
import 'package:springcrate/blocs/delete_services/delete_services_bloc.dart';

class ServiceDetailsScreen extends StatelessWidget {
  const ServiceDetailsScreen({Key? key, required this.service})
      : super(key: key);

  final Services service;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => DeleteServicesBloc(serviceRepo: FirebaseServiceRepo())
        ..add(DeleteService(serviceId: service.serviceId)),
      child: _ServiceDetailsScreen(service: service),
    );
  }
}

class _ServiceDetailsScreen extends StatelessWidget {
  const _ServiceDetailsScreen({Key? key, required this.service})
      : super(key: key);

  final Services service;


  @override
  Widget build(BuildContext context) {
        final serviceDetailItems = [
      _buildDetailWidget(context, 'Service Name', service.serviceName),
      _buildDetailWidget(context, 'Vehicle Type', service.vehicleType),
      _buildDetailWidget(context, 'Vehicle Size', service.vehicleSize),
      _buildDetailWidget(context, 'Vehicle Size', '${service.cost}'),
    ];

    return BlocBuilder<DeleteServicesBloc, DeleteServicesState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Service > ${service.serviceName} - ${service.vehicleType.toUpperCase()}',
            ),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildDetailWidget(context, 'Service ID', service.serviceId),
                    const SizedBox(height: 20),
                    GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 3.5,
                      ),
                      itemCount: serviceDetailItems.length,
                      itemBuilder: ((context, index) => serviceDetailItems[index]),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: null,
                  child: Text('Delete Service'),
                ),
              ],
            ),
          ),
        );
      },
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
}
