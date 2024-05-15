import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:services_repository/services_repository.dart';

class FirebaseServiceRepo implements ServiceRepo {
  final servicesCollection = FirebaseFirestore.instance.collection('services');

  @override
  Future<List<Services>> getServices() async {
    try {
      return await servicesCollection.get().then((value) => value.docs
          .map(
              (e) => Services.fromEntity(ServicesEntity.fromDocument(e.data())))
          .toList());
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<void> createServices(Services services) async {
    try {
      return await servicesCollection
          .doc(services.serviceId)
          .set(services.toEntity().toDocument());
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<void> deleteService(String serviceId) async {
    try {
      await servicesCollection.doc(serviceId).delete();
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}
