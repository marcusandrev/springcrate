import 'package:flutter/material.dart';
import 'package:services_repository/services_repository.dart';

class ServiceDetailsScreen extends StatelessWidget {
  const ServiceDetailsScreen({super.key, required this.service});

  final Services service;

  @override
  Widget build(BuildContext context) {
    final serviceDetailItems = [
      _buildDetailWidget(context, 'Service Name', service.serviceName),
      _buildDetailWidget(context, 'Vehicle Type', service.vehicleType),
      _buildDetailWidget(context, 'Vehicle Size', service.vehicleSize),
      _buildDetailWidget(context, 'Vehicle Size', '${service.cost}'),
    ];
    return Scaffold(
        appBar: AppBar(
          title: Text(
              'Service > ${service.serviceName} - ${service.vehicleType.toUpperCase()}'),
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
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2, childAspectRatio: 3.5),
                    itemCount: serviceDetailItems.length,
                    itemBuilder: ((context, index) =>
                        serviceDetailItems[index]),
                  ),
                ],
              )
            ],
          ),
        ));
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
              fontWeight: FontWeight.bold),
        ),
        Text(
          value,
          style: TextStyle(color: Colors.grey[800], fontSize: 14),
        )
      ],
    );
  }
}
