import 'models/models.dart';

abstract class EmployeesRepo {
  Future<List<Employees>> getEmployees();
}
