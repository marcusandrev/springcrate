import 'package:flutter/material.dart';
import 'package:springcrate/screens/services/class_def/service.dart';

class ServiceDetailsScreen extends StatelessWidget {
  const ServiceDetailsScreen({super.key, required this.service});

  final Service service;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Service > ${service.serviceName}'),
        ),
        body: const SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Text('Hello world!'),
        ));
  }
}
