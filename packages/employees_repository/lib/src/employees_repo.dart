import 'models/models.dart';

abstract class EmployeesRepo {
  Future<List<Employees>> getEmployees();
  Future<void> createEmployees(Employees employees);
  Future<void> updateEmployee(Employees employees);
}
