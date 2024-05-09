part of 'get_employees_bloc.dart';

sealed class GetEmployeesState extends Equatable {
  const GetEmployeesState();

  @override
  List<Object> get props => [];
}

final class GetEmployeesInitial extends GetEmployeesState {}

final class GetEmployeesFailure extends GetEmployeesState {}

final class GetEmployeesLoading extends GetEmployeesState {}

final class GetEmployeesSuccess extends GetEmployeesState {
  final List<Employees> employees;

  const GetEmployeesSuccess(this.employees);

  @override
  List<Object> get props => [employees];
}
