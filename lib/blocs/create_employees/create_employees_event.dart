part of 'create_employees_bloc.dart';

sealed class CreateEmployeesEvent extends Equatable {
  const CreateEmployeesEvent();

  @override
  List<Object> get props => [];
}

class CreateEmployees extends CreateEmployeesEvent {
  final Employees employees;

  const CreateEmployees(this.employees);

  @override
  List<Object> get props => [employees];
}

class UpdateEmployee extends CreateEmployeesEvent {
  final Employees employees;

  const UpdateEmployee(this.employees);

  @override
  List<Object> get props => [employees];
}
