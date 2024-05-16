import 'models/models.dart';

abstract class ServiceRepo {
  Future<List<Services>> getServices();
  Future<List<Services>> getQueriedServices(String query);
  Future<void> createServices(Services services);
  Future<void> updateService(Services services);
}
