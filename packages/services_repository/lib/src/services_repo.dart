import 'models/models.dart';

abstract class ServiceRepo {
  Future<List<Services>> getServices();
  Future<void> createServices(Services services);
  Future<void> deleteService(String serviceId);
}
